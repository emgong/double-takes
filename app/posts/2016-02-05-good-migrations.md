---
title: "Good migrations."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
reddit: false
---

We wrote a gem! It's called
[good_migrations](https://github.com/testdouble/good-migrations) and we recommend
you add it to all of your [Ruby on Rails](http://rubyonrails.org) projects and
subsequently forget about it.

Just do it. There's no reason we can see not to blindly copy-paste this command
right now:

``` bash
$ echo "gem 'good_migrations'" >> Gemfile
```

Need some background first? Okay.

## Some background

A little over a year ago, we [shared some
tips](/posts/2014-11-04-healthy-migration-habits.html) for writing better database
migrations in Rails. In the [last
section](/posts/2014-11-04-healthy-migration-habits.html#habit-4-don-t-reference-models)
of that post, we explained why it's important to _resist the temptation_ to
reference your app's ActiveRecord models from your migration code.

Following that advice would require vigilance on the part of the developer and
their team to steer clear of this potential hazard. And, while standing vigilant
has its virtues when truly necessary, it's generally better to leverage
automation when possible to reduce the number of things we need to actively worry
about while we work.

So after Aaron Patterson shared [a gist of one
approach](https://gist.github.com/tenderlove/44447d1b1e466a28eb3f) to
monkey-patch and disable the ActiveSupport auto-loader while migrations were
running, we jumped at the opportunity to wrap a well-tested gem around it.

If you have the `good_migrations` gem in your Gemfile, your migrations will raise
an error whenever the Rails auto-loader attempts to load
a Ruby file from your project's `app/` directory, do its best to explain why
this is almost certainly a problem, and then forward you to the Github README
for more details. There's no API or configuration to worry about, and if you
*really really need* to load a file from `app/` you can always (*gasp*) `require`
it explicitly.

By adding this gem to your Rails projects as a preventative measure, you'll be
guarding yourself from one of the most obscure and hard-to-debug classes of
errors on Rails projects. What's not to like?
