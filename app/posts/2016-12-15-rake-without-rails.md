---
title: "Rake without Rails."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
reddit: false
---

A lot of ink has been spilled over how to get "real" unit tests working in Ruby
on Rails projects. The first time I encountered it was when [Gary
Bernhardt](https://www.destroyallsoftware.com) and [Corey
Haines](http://coreyhaines.com) started the "[fast
specs](https://www.youtube.com/watch?v=bNn6M2vqxHE)" meme. Knowing both of them,
it was partially about improving runtime speed for faster feedback, but it was
also about gaining focus and simplicity by way of excluding the myriad global
constants that come along with `require "rails"`.

Because [RSpec](http://rspec.info) has always shipped with is own (quite nice!)
CLI, setting up a test suite that didn't load rails was as simple as creating a
one-off helper file and cordoning off a directory for rails-free tests (e.g.
`rspec spec/fast`). For Minitest users running their tests with a Rake task, a
few more steps were needed, but it was still pretty straightforward.

But then, after the "movement" died down, Rails 4 arrived and a change to how it
configured Rake inadvertently made it really hard to run `rake` without first
requiring the universe. In a Rails 4 app, the generated Rakefile looks like
this:

```ruby
require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
```

So, in the post-Rails 4 world, if you're thinking, "oh, I'll just write a custom
Rake task that only loads plain-ol' Ruby objects in `lib/` and save myself the
time to require Rails", you may not realize that the very first thing your
Rakefile does is load all of Rails (and probably most of your Gemfile, too).

I'd completely forgotten about this today when I wrote a little Rake task to run
unit tests that didn't depend on any Rails-aware code in
`lib/tasks/unit_test.rake`:

``` ruby
require "rake/testtask"

Rake::TestTask.new(:unit_test) do |t|
  t.warning = false
  t.libs << "test"
  t.libs << "app"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_unit_test.rb']
end
```

I was feeling pretty clever, because any file ending in `_unit_test.rb` would
belong to a logical test suite, even if intermingled with directories
containing Rails-aware tests. And, because `_unit_test.rb` also ends in
`_test.rb`, any unit tests would also be scooped up by our existing test
task—meaning I wouldn't have to futz with CI configuration or, even better,
inform other developers on the project about what I was doing. (That last bit is
important: the number one reason I saw the "fast specs" meme fail in practice
was that less zealous team members would forget to run the extra test suite,
only to be surprised when "Chris's suite" would fail in CI.)

Isolated Rake task in hand, I wrote a dummy test and ran it with `time rake
unit_test`:

```
# Running:

.

Finished in 0.001424s, 702.2472 runs/s, 702.2472 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

real	0m2.120s
```

Ruby isn't the fastest interpreted language on the planet, but it's surely fast
enough to load Rake and run a two-line method in less than two seconds. Seeing
this wall-time was a dead giveaway that Rails was being loaded before my task
was even defined.

[Aaron Patterson](https://tenderlovemaking.com) and I have investigated removing
the Rails-generated Rakefile's dependency on Rails in the past, but eliminating
the application load from the Rake environment would be a nontrivial endeavor.
And, at the end of the day, this isn't really Rails' problem. It's a Rails app,
it's going to want to load Rails. News at 11.

So, where to turn if you want to run any tasks that are reliably divorced from
Rails (and your other gems that lack a `require => false` directive in your
Gemfile)? It turns out you can always just write an additional Rakefile.

## Rakefile.norails

The `rake` cli takes a predictable `--rakefile` argument, so if you write a
`Rakefile.norails`, you can run it like this:

```
$ rake --rakefile Rakefile.norails
```

If you don't find yourself writing many Rakefiles from scratch, you could get
started by just cherry-picking the tasks you'd defined with the intention of not
needing Rails, like so:

``` ruby
import "lib/tasks/unit_test.rake"

task :default => :unit_test
```

This way, the `:unit_test` task will be available to both Rake configurations,
sparing your colleagues any grief if they forget about your custom Rakefile and
the two seconds it can save them. (If you're befuddled why two seconds should
matter to you, check out [this tiny portion](https://vimeo.com/145917204#t=1911)
of my [How to Stop Hating Your
Tests](2015-11-16-how-to-stop-hating-your-tests) talk.)

New, isolated Rakefile in  hand, let's try to run it with `rake --rakefile
Rakefile.norails`:

```
# Running:

.

Finished in 0.001076s, 929.3680 runs/s, 929.3680 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

real	0m0.794s
```

Excellent, we cut our load time by more than half!

To figure out how low the floor is, we could cut it further by eliminating Rake
and running just a single test using the `ruby` CLI.  When I ran `time ruby -I
lib:test test/lib/simple_unit_test.rb`, it yielded a `0.423s` run time.

## What if someone loads Rails anyway?

It would be tempting to call our work finished at this point, but there's a
lingering fear: what if one of these tests inadvertently requires some code
that, in turn, results in Rails being loaded? It's not hard to imagine that
happening, and if just a single test were to accidentally load Rails, it would
eradicate the intended benefit of this separate Rakefile.

So, can we ensure Rails isn't loaded? We can! By using Ruby's `at_exit` hook, we
can add a check that the `Rails` constant is still undefined after all of our
tasks are finished executing. Here's what my final `Rakefile.norails` file
looked like:

``` ruby
import "lib/tasks/unit_test.rake"

task :default => :unit_test

at_exit do
  if defined?(Rails)
    raise "Rails wound up getting loaded by a Rakefile.norails task! Failing!"
  end
end
```

But that's still not enough! Because `Rake::TestTask` will spawn a separate test
process, we also need to install this trip-wire somewhere in our test suite. I
chose to throw it in my `test/unit_test_helper.rb` file:

``` ruby
require "minitest/autorun"

class UnitTest < Minitest::Test
end

MiniTest.after_run do
  if ENV['NO_RAILS'] && defined?(Rails)
    raise "Rails wound up getting loaded by a unit test! Failing!"
  end
end
```

Now, if either a test or a rake task were to load Rails, an error will be
raised and the process will exit non-zero. Note the `ENV['NO_RAILS']` condition,
though. So that our unit tests won't inadvertantly break our integrated rake
task (recall that `rake test` will scoop up these new unit tests), we'll need
some kind of flag to ensure we only trigger this alarm in the event that the
unit tests were launched via `Rakefile.norails`.

With that caveat, here's our final `Rakefile.norails` file:

``` ruby
ENV['NO_RAILS'] = "true"

import "lib/tasks/unit_test.rake"

task :default => :unit_test

at_exit do
  if defined?(Rails)
    raise "Rails wound up getting loaded by a Rakefile.norails task! Failing!"
  end
end
```

## Rake off Rails

This approach to running tasks in isolation from Rails has a few benefits:

* Only takes a few minutes to set up
* Unit tests will also be run by the app's existing test task
* If someone forgets `--rakefile Rakefile.norails`, they can still run the
  `unit_test` task
* If a "no rails" task or a test inadvertently loads Rails, we'll be alerted
  immediately

For a real-world example, this blog post resulted from [this actual
commit](https://github.com/testdouble/present/commit/75c08cda795fa8c24826358f67649096940d68a0)
in Test Double's [present](https://github.com/testdouble/present) app, which we
use internally for tracking time & generating invoices.
