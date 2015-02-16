---
title: "Arcane knowledge needed to write a test."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
reddit: true
---

<figure>
  [![A smoke test](/img/rails-smoke-test.gif)](/img/rails-smoke-test.gif)
  <figcaption>A single test</figcaption>
</figure>

This weekend I was reminded how complex (and in some cases, convoluted) typical test setup is for Rails applications. The steps below were all necessary in my case, but please don't read this list's tools as criticisms of their _excellent_ open source maintainers. In this case, [Jonas Nicklas](https://twitter.com/jonicklas), [Hiro Asari](https://twitter.com/hiro_asari) (of Travis) & [Mike Moore](https://twitter.com/blowmage) all took time _out of their holiday weekends_ to help unblock me.

These are the things I either knew in advance or discovered in the process of setting up the solitary test you see running in the GIF above:

1. For a new [Rails](http://rubyonrails.org) project, the "[minitest](https://github.com/seattlerb/minitest)" gem is included even though it's absent from the generated Gemfile.
* In spite of minitest's aforementioned inclusion, the addition of the [minitest-rails](https://github.com/blowmage/minitest-rails) gem is apparently necessary to avoid some tests from raising errors
* The minitest-rails gem must be added to the `:development` group (in addition to `:test`) of the Gemfile, so that its rake tasks are available from the command line. That means that running an app in development unnecessarily pollutes it with all the class loading and monkey-patching of its test-scope dependencies
* Outside of Rails, `Minitest::Spec` is the test class used for `describe`...`it` style tests. In a Rails app, however, each test is an instance of `ActiveSupport::TestCase` with the `Minitest::Spec::DSL` merely mixed in (this required an update to [minitest-given](https://github.com/jimweirich/rspec-given))
* If you don't add `require "rails/test_unit/railtie"` to your `application.rb`, then the server started by `rake test` will actually be initialized in development mode, even if your test helper explicitly sets `ENV['RAILS_ENV'] = "test"` (further blurring the line of production-scope and test-scoped dependencies)
* Before any tests are defined (e.g. in a `test/test_helper.rb` file), one must first `require File.expand_path("../../config/environment", __FILE__)` and then `require "rails/test_help"` or errors will be raised
* To run full-stack tests with browser automation, one might add the [minitest-rails-capybara](https://github.com/blowmage/minitest-rails-capybara) gem and then must explicitly `require "minitest/rails/capybara"` (and to know that this both includes and `require`'s [Capybara](https://github.com/jnicklas/capybara) itself)
* [Rack::Test](https://github.com/brynary/rack-test) is Capybara's default driver and that it can't make web requests outside the Rack app (e.g. Github OAuth, Harvest integration). In this case, [Selenium](http://www.seleniumhq.org) was added by the [selenium-webdriver](https://rubygems.org/gems/selenium-webdriver) gem and the setting `Capybara.default_driver = :selenium`
* Without Firefox installed, one might need the `chromedriver` bin (via `brew install chromedriver`), as well as to override the Capybara driver registration with `Capybara.register_driver :selenium { |app| Capybara::Selenium::Driver.new(app, :browser => :chrome) }`
* minitest-rails-capybara expects its test files to be placed in `test/features`
* When using Capybara, the `Minitest::Spec` DSL changes from `describe`/`it` to `feature`/`scenario`, unless you use `describe 'foo', :capybara do`
* In order to extract one's use of Capybara's API into other modules or classes, they must `extend` or `include` the `Capybara::DSL`
* The test database in such an arrangement is, by default, persisted between tests and test runs; wiping and re-seeding the database is left as an exercise to the user (perhaps one might `Rake::Task["db:setup"].invoke` in a before hook)
* To enable CI, one might go to [Travis](https://travis-ci.org), login, click "Accounts", click the repo owner, manually sync repos, then click "on" for the repo under test
* Rails tests will require non-default CI settings, necessitating a `.travis.yml` file with `language: ruby`, and a `before_script` that calls `RAILS_ENV=test bundle exec rake db:setup`
* Any secure environment variables needed by the application must be added with the `travis` gem CLI (via `gem install travis`), then created with `travis encrypt SOMEVAR="some val" --add env.global` and committed
* To run browser tests in a headless CI environment, an appropriate Capybara driver is necessary; in this case, via the [poltergeist](https://github.com/teampoltergeist/poltergeist)
* To juggle the two drivers, an environment variable might flag their use (`Capybara.default_driver = ENV['HEADLESS'] ? :poltergeist : :selenium`), with `- HEADLESS=true` in the `env.global` key of the `.travis.yml`
* To speed up test time, one should add `cache: bundler` to the `.travis.yml` file [Note: at this time I can't seem to get caching to work, despite this]
* Github OAuth applications require a static port in the OAuth callback URL, meaning the test must fix its port to a known value via `Capybara.server_port = ENV['SOME_SET_PORT']`
* Capybara makes web requests to `127.0.0.1`, and any request to `localhost` will spawn a separate browser session. As a result, the OAuth success callback won't be able to be verified unless its callback URL's host is set explicitly to `127.0.0.1`
* Github's login page throws JavaScript errors, so Poltergeist's Capybara driver must be overridden so as to specify that it should ignore _all_ JS errors with `Capybara.register_driver :poltergeist { |app| Capybara::Poltergeist::Driver.new(app, :js_errors => false) }`

As for the task of actually writing any tests, I leave that as an exercise to the reader.

I don't have a solution in mind as to how to make this setup process simpler (and surely it would be, if only I'd acquiesce a bit more to [Omakase](http://guides.rubyonrails.org/testing.html)), but it certainly feels like the requisite work to get up-and-running with full-stack testing presents too high a barrier of entry, especially given that Ruby's testing tools are, generally, *the good ones*. Also, while I typically use [RSpec](https://github.com/rspec/rspec), I don't believe much, if any, of the work above would have been obviated by it (or [Cucumber](https://cukes.info), for that matter).
