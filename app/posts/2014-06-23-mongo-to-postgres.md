---
title: "Mongo to Postgres."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
reddit: true
---

This morning, I finished a production migration of a client application off of [MongoDB](http://www.mongodb.com) and onto [PostgreSQL](http://www.postgresql.org). I'll document a few things I learned along the way here, and I'll spare you arguments about the merits of [why](http://www.sarahmei.com/blog/2013/11/11/why-you-should-never-use-mongodb/) we decided to migrate.

The Rails 4.0 application that I was migrating is small, about a year-old, runs on Heroku, has zero automated tests, and was using [Mongoid](http://mongoid.org).

I was hoping to find a silver bullet to just do my job for me (like [MoSQL](https://stripe.com/blog/announcing-mosql)!), but after running into a number of hurdles, it seemed like I was better rolling my own migration. I also decided to do all the conversions in Ruby from a Rails-aware process so that I could run all of the models' validations as they were moved from one store into the next (acquiescing to how slow this would be).

## Prep a development environment

Since I wasn't familiar with the application or with MongoDB, the first step to pull off any migration was to take a snapshot of production so that I could be sure any code I wrote would be run under realistic data. (This was only possible because of production's modest size, but if it had been larger I could have taken a random sample). To load production onto my machine, I ran:

``` bash
mongodump -h "$NAME.mongohq.com:10015" -d myAppId1234 -u heroku -p "$PASSWORD" -o db/dump/myAppId1234.mongo
mongorestore --drop db/dump/myAppId1234.mongo
```

Next, I pointed the Mongoid config's (`config/mongoid.yml`) `development` key to the new dump:

``` yaml
development:
  sessions:
    default:
      database: myAppId1234
```

Now my development server would be running with production code. This way I could be sure to develop migrations that hit all of (and only!) the edge cases that matter to my production data.

## Shadow your models

Next, I prepared to add ActiveRecord support to the app:

* I added the `pg` gem to the project and a `config/database.yml`
* I uncommented `require "active_record/railtie"` to my `application.rb`
* I copied all of my Mongoid models into a new `Sql` module with `mkdir app/models/sql && cp app/models/*.rb app/models/sql` and had them extend `ActiveRecord::Base` instead of including `Mongoid::Document`

This left me with a structure that looked a little like this:

```
├── cheese.rb
├── sql
│   ├── cheese.rb
│   ├── user.rb
│   └── walrus.rb
├── user.rb
└── walrus.rb
```

(In my case, I had 8 or 9 models in total.)

Finally, I generated a new, empty migration and began to take stock of my situation.

## Identify your constraints

I was very fortunate that this application wasn't taking advantage of any of Mongo's advanced features, neither in its document composition nor its runtime operations. Here are a few happy constraints I was able to identify:

* One god model had `has_many` relationships pointing to 6 or 7 other models with reciprocal `belongs_to` relationships
* No other model had any relationships at all
* The only non-traditional field type in any of the Mongo documents was one `Array` field, but [Zach](https://twitter.com/theotherzach) pointed out that Postgres actually has a [query-able Array type](http://www.postgresql.org/docs/9.1/static/arrays.html) which was a perfect fit. (Just pass `:array => true` as an option to the column definition in your migration.)
* Only one model was using undeclared, "dynamic" attributes (via `include Mongoid::Attributes::Dynamic`), and upon inspection it was safe to discard all of them during the migration
* All of the queries were made using the mostly-compatible-with-ActiveRelation Mongoid API. The differences were minor and ultimately none of them took more than a few minutes to port to ActiveRecord.

All of this suggested that the migration was conceptually straightforward and I was safe to proceed.

## Iteratively build migrations

Next up, I started filling in my migrations one step at a time, which was mostly a straightforward process of:

1. One model at a time, add `create_table` and `add_index` calls to the migration's `change` method
2. Add a `mongo_id` column to each table where the legacy Mongo ID would be stored
3. Guard against duplicative INSERTs with a unique index (e.g. `add_index :walruses, :mongo_id, :unique => true`)
4. Run `rake db:drop db:create db:migrate`
5. Write just enough code to migrate that model

This allowed me to start with a simple one-to-one model and incrementally add complexity as I tackled each subsequent model.

### Start with simple models

I started with a little class named `app/models/converts_from_mongo.rb` that looked like this:

``` ruby
module Sql
  class ConvertsFromMongo
    def convert(mongo, ar_type)
      sql = ar_object_for(mongo, ar_type).tap do |sql|
        sql.assign_attributes(initial_attrs)

        keys(mongo, sql).each do |key|
          if key == "_id"
            sql.mongo_id = mongo.id.to_s
          elsif sql.respond_to?("apply_mongo_#{key}!")
            sql.send("apply_mongo_#{key}!", mongo.send(key))
          elsif mongo.respond_to?(key) && !key.end_with?("_id")
            sql.send("#{key}=", mongo.send(key))
          end
        end

        sql.save!
      end
    end

  private

    def ar_object_for(mongo, ar_type)
      ar_type.where(:mongo_id => mongo.id.to_s).first || ar_type.new
    end

    def keys(mongo, sql)
      (mongo.attributes.keys + sql.attributes.keys).uniq - ["id"]
    end
  end
end
```

The above was good enough to do my top-level models. I could just open a console and run `Sql::ConvertsFromMongo.new.convert(Walrus.first, Sql::Walrus)`. If an attribute, say, `teeth` was more complex than a simple value copy would allow, the new `ActiveRecord` model could define a method named `apply_mongo_teeth!`, which could transform the data however it needed.

### Handle (unidirectional) relationships

Eventually the script got more complex as I wanted the top-level object to be responsible for its dependent `has_many` records (if I'd had embedded models in the document, I would have handled those, too).

``` ruby
module Sql
  class ConvertsFromMongo
    def convert(mongo, ar_type, initial_attrs = {})
      sql = (ar_type.where(:mongo_id => mongo.id.to_s).first || ar_type.new).tap do |sql|
        sql.assign_attributes(initial_attrs)

        # ...

        has_manies_for(ar_type).each do |key|
          mongo.send(key).no_timeout.each do |mongo_has_many|
            convert(mongo_has_many, sql.send(key).proxy_association.klass,
              {ar_type.to_s.foreign_key => sql.id}
            )
          end
        end
      end
    end

  private  
    #...
    def has_manies_for(ar_type)
      ar_type.respond_to?(:mongo_has_manies) ? ar_type.mongo_has_manies : []
    end
  end
end
```

In the above, I looped over each AR model's `has_many` relationships (which they declare by responding to `mongo_has_manies`, because I was too lazy to figure out how to introspect it), and then for each-and-ever related item, I'd call the `convert` method again, this time passing a little hash which could initialize the inverse `belongs_to` ID.

### Put together a rake task

Since I wanted to be able to run this whole migration as a detached rake task, I created a little task in `lib/tasks/mongo_to_pg.rake`

``` ruby
desc "Mongo to postgres conversion"
task :mongo_to_pg => :environment do
  converter = Sql::ConvertsFromMongo.new
  User.all.no_timeout.each do |mongo_user|
    converter.convert(mongo_user, Sql::User)
  end

  Walrus.all.no_timeout.each do |c|
    converter.convert(c, Sql::Walrus)
  end
end
```

Since Walrus had a `has_many` relationship with every other model, this was sufficient to migrate the entire application's data. Note also that the `no_timeout` call was necessary because Mongoid uses a cursor to batch requests to MongoDB, and it normally has a 10 minute timeout, which is liable to expire when processing a large batch.

### Prevent runaway memory usage

I was finally ready to try this out on heroku in a staging environment by running:

```
$ heroku pg:reset database -a stagingName
$ heroku run:detached rake db:migrate mongo_to_pg -a stagingName
```

In the above, `heroku run:detached` is a fantastic, little-known Heroku sub-command which will kick off a `run` command on a spare dyno and continue even if your local machine disconnects. It will even print out a `heroku log <PID>` command you can run to monitor your process.

Unfortunately, I quickly realized that everything was working great until I got about 2/3 through my data set, at which point I began seeing "**Error R14 (Memory quota exceeded)**" errors. It actually wasn't obvious this error was being triggered, in part because it didn't crash the process, instead it merely drastically reduced my dyno's resources.

Because the memory exception had the side-effect of starving the dyno of almost all its resources, it sent me down a pretty deep rabbit hole reading up on ActiveRecord internals, articles about Ruby's GC, and so forth. All of which made me suspect that ActiveRecord was perhaps-too-cutely holding onto references of the newly-created dependent models because it happened to know that an in-scope parent object held a reference to it.

To debug this, I pulled in the impressive [ruby-mass](https://github.com/archan937/ruby-mass) gem to sniff out the references to these new AR objects with something like this:

``` ruby
require 'ruby-mass'

# ...
has_manies_for(ar_type).each do |key|
  mongo.send(key).no_timeout.each do |mongo_has_many|
    new_item = convert(mongo_has_many, sql.send(key).proxy_association.klass,
      {ar_type.to_s.foreign_key => sql.id}
    )
    puts Mass.references(new_item) #=> {"ActiveModel::Errors#2155577620" => ["@base"]}
  end
end
#...

```

`Mass.references` will hunt through the `ObjectSpace` for any other objects holding a reference with the same object ID as what's been passed to it. This helped me uncover that `ActiveRecord::Associations::HasManyAssociation` instances were holding instance variables called `@owner` and `@target` and that `ActiveModel::Errors` instances had a `@base` ivar pointing to each new instance being created. As a result, every object committed to the database was effectively *never* eligible for garbage collection. I also had to remove all of my higher-order `ActiveRecord::Base.transaction` demarcations, as they hold a reference to all records to-be-committed.

 All of these references were preventing any of my newly-created ActiveRecord objects from being garbage collected, which in turn was causing my Heroku dyno to run out of memory.

The fun part about writing code you plan on throwing away as soon as you run it is that you can make a mess without hurting anything more than your dignity. So I went ahead and hacked up the code that looped over each `has_many` relationship as such:

``` ruby
has_manies_for(ar_type).each do |key|
  mongo_type = key.classify.constantize
  sql_type = sql.send(key).proxy_association.klass
  belongs_to_attrs = {ar_type.to_s.foreign_key => sql.id}
  ids = mongo.send("#{key.singularize}_ids")
  ids.each_slice(1000).each_with_index do |id_batch, i|
    ActiveRecord::Base.transaction do
      mongo_type.find(id_batch).each do |mongo_has_many|
        convert(mongo_has_many, sql_type, belongs_to_attrs)
      end
    end

    if (i+1) % 15 == 0
      ObjectSpace.each_object(ActiveModel::Errors).each do |err|
        err.instance_variable_set("@base", nil)
      end
      ObjectSpace.each_object(ActiveRecord::Associations::HasManyAssociation).each do |err|
        err.instance_variable_set("@owner", nil)
        err.instance_variable_set("@target", nil)
      end
      GC.start
    end
  end
end
```

The above adds a few things in the interest of keeping the memory footprint of the task low:

* Loads all of the IDs from Mongo at once, so that it can slice them into batches of 1000 (`ids.each_slice(1000).each_with_index`), reducing the lifespan of Mongoid's cursors
* Every 15 batches (an arbitrary number), it loops through all `ActiveModel::Errors` and `ActiveRecord::Associations::HasManyAssociation` instances to clear out any potential reference to the new ActiveRecord objects (obviously, this is something you would never want to do on a running web server, but turned out fine for a one-off rake process)
* After eliminating the known rogue references, it kicks off GC manually.

Somewhat surprisingly, this worked perfectly. The memory overhead for my batch remained roughly constant once it initially warmed up, and no data integrity issues were introduced.

### The prestige

The really *cool* part of this entire endeavor was the fact that `ActiveModel` gives you so much compatibility between like-for-like models that once the data existed in both places, I was able to do this:

``` bash
$ rm app/models/*.rb
$ mv app/models/sql/*.rb app/models/
```

And then unwrap the `module Sql` around my new AR models.

I was shocked that—barring a few hiccups—the entire app *just worked*, running against PostgreSQL instead of MongoDB.

### Deploy it

Deployment required a few straightforward steps:

1. Disable the non-readonly portions of the app
2. Push the branch with the mongo data migration rake task and run it on heroku
3. Once the task completes, push the branch that deletes the Mongoid models
4. Make sure things seem to work
5. Re-enable the writable portions of the app

All told, we experienced about an hour of downtime.

## Parting thoughts

I'm not sure how much of this experience is generally applicable. In hindsight, I was really fortunate that my model was as simple as it was, that the application was taking so little advantage of Mongo-specific features, and that I was permitted an hour of downtime to complete the migration. (This approach would have dovetailed nicely into a zero-downtime scheme in fact, but would required more effort to ensure no new Mongo records fell through the cracks.)

Perhaps heretically, I was also pleased with how smooth everything went in lieu of tests; the application didn't previously have any automated tests, and I didn't add any during this transition. Fortunately, the application is small enough that I can get through about 90% of its logical branches manually in under a minute.

Of course, you're unlikely to run into a situation exactly like this one, but I wanted to share my experience in case some individual portion of it might prove useful to you. *#ymmv*
