---
title: "Configure Leiningen for ClojureScript and Clojure Testing"
author:
  name: "Andrew Vida"
  url: "http://twitter.com/andrewvida"
reddit: false
---

I'm currently working on a project with both Clojure and ClojureScript code using Leiningen and found it difficult to determine how to properly set up and test both.  I'd like to share with you my journey on testing both Clojure and ClojureScript code using Leiningen.

We are currently using Midje to test our Clojure code and have decided to use cljs.test, which comes out of the box, to test our ClojureScript. Since cljs.test is fairly new, I had a hard time researching how to get it set up properly.

Let's begin to get cljs.test working! First, you'll need a place to put your new ClojureScript tests. I added a new `cljs` folder in the `test` directory and moved all of the existing Clojure tests to a new `clj` folder.  The new structure looks like this:

```
resources
├── public
│   ├── js
│   │   ├── main.js
src
├── my_namespaced_app
│   ├── foo.clj
src-cljs
├── my_namespaced_app
│   ├── foo.cljs
test
├── clj
│   ├── my_namespaced_app
│   │   ├── foo_test.clj
└── cljs
    └── my_namespaced_app
        ├── foo_test.cljs
```

Next, to ensure our existing Midje tests can run, you'll need to add `:test-paths ["test/clj"]` to your project.clj.  This lets Leiningen know that you're using a different directory structure. Now, `lein midje 'my_namespaced_app.*` will find and execute your Midje tests!

## Build configuration

Within the `:builds` sequence for lein-cljsbuild, we began with two profiles; one for basic development, and one with advanced optimizations.  I've added a new one called `:test`that includes the paths to the source and the tests.  This makes it extremely convenient because it allows cljsbuild to compile in all three sequences at once and gives you a test suite alongside the library code.  Below is the new `:builds` sequence:

``` clojure
:builds {:minify {:source-paths ["src-cljs"]
                  :compiler {:output-to "resources/public/js/main.js"
                             :output-dir "cljsbuild-output-minify"
                             :optimizations :advanced
                             :pretty-print false}}
         :dev {:source-paths ["src-cljs"]
               :compiler {:output-to "resources/public/js/main.js"
                          :output-dir "resources/public/js/build-output-dev"
                          :optimizations :whitespace}}
         :test {:source-paths ["src-cljs" "test/cljs"]
                :compiler {:output-to "resources/public/js/main-test.js"
                           :optimizations :whitespace
                           :pretty-print true}}
```

## Running ClojureScript tests with PhantomJS

So far, what we've seen has been fairly straightforward.  We've moved our existing Clojure tests, created a home for our ClojureScript tests and created a new test suite build.  Now, we're going to talk about the more tricky bits; how to actually get our ClojureScript tests to execute using PhantomJS.

There are several components needed to get this to work.  The first component, we've already completed by adding a test build that compiles the tests into JavaScript so they can be run by PhantomJS.

Let's next create a script that will fire up a headless browser that we'll eventually use to execute our tests.  As you can see from the new `:test` profile, we're outputting the compiled JavaScript to a `resources` directory.  We'll create this new PhantomJS script and save it to a new `resources/test/phantom` path as `runner.js`.  Below is the script:

```javascript
var page = require('webpage').create();
var system = require('system');

if (system.args.length !== 2) {
  console.log('Expected a target URL parameter.');
  phantom.exit(1);
}

page.onConsoleMessage = function (message) {
  console.log(message);
};

var url = system.args[1];

page.open(url, function (status) {
  if (status !== "success") {
    console.log('Failed to open ' + url);
    setTimeout(function() { // https://github.com/ariya/phantomjs/issues/12697
      phantom.exit(1);
    }, 0);
  }

  page.evaluate(function() {
   //OUR TESTS WILL BE EXECUTED HERE!!!
  });

  setTimeout(function() { // https://github.com/ariya/phantomjs/issues/12697
    phantom.exit(0);
  }, 0);
});
```

The next component is a static HTML page with a `<script>` tag that will pull in the compiled test code when the page is loaded. Create this file, `test.html`, and save it to the `resources/test` directory.  The script tag will point to the location of the compiled JS that is output from the `:test` profile.

```html
<html>
  <body>
    <script src="../public/js/main-test.js" type="text/javascript"></script>
  </body>
</html>
```

Since we're hopefully going to have many ClojureScript tests, lets create a file that we'll use to execute all of our tests from the `runner.js` file.  Create a new file called `test.cljs` and place it in the `tests/cljs/my_namespaced_app` directory.

```clojure
(ns cljs.my-namespaced-app.test
  (:require [cljs.test :refer-macros [run-all-tests]]))

(enable-console-print!)

(defn ^:export run []
  (run-all-tests #"cljs.my-namespaced-app.*-test"))
```

The `run` function will execute all of the tests that match the reader. Using this pattern, we can create our first _real_ test. Let's create a new file called `foo_test.cljs` and save it to the `test/cljs/my_namespaced_app` directory.

```clojure
(ns cljs.my-namespaced-app.foo-test
  (:require [cljs.test :refer-macros [deftest is]]))

  (deftest do-i-work
    (is (= 1 2)))
```
Now that we have tests, lets tell the PhantomJS runner how to execute them.  In `runner.js`, replace the comment in `page.evaluate...` with `cljs.my_namespaced_app.test.run();`

Finally, we need to add a `:test-commands` entry that will hook all of this together. It creates one test named "unit", that will run PhantomJS with a couple of arguments: the location of our script and the static HTML page that will load the compiled test code.  Our final lein-cljsbuild will look like this:

```clojure
:cljsbuild {:builds {:minify {:source-paths ["src-cljs"]
                                :compiler {:output-to "resources/public/js/main.js"
                                           :output-dir "cljsbuild-output-minify"
                                           :optimizations :advanced
                                           :pretty-print false
                                           :externs ["externs/jquery-externs-1.9.js"
                                                     "externs/externs.js"
                                                     "externs/moment.js"]}}
                     :dev {:source-paths ["src-cljs"]
                           :compiler {:output-to "resources/public/js/main.js"
                                      :output-dir "resources/public/js/build-output-dev"
                                      :optimizations :whitespace}}
                     :test {:source-paths ["src-cljs" "test/cljs"]
                            :compiler {:output-to "resources/public/js/main-test.js"
                                       :optimizations :whitespace
                                       :pretty-print true}}}
            :test-commands {"unit" ["phantomjs"
                                    "resources/test/phantom/runner.js"
                                    "resources/test/test.html"]}}
```

Wow!  After all of that we're ready to actually run the tests.  Run `lein cljsbuild test` and you should see one failing test.  I'll leave it to you to make it pass!

## Other Gotchas
If you're working with frameworks such as Reagent or Om, you might encounter this error:

```bash
Running ClojureScript test: unit
TypeError: 'undefined' is not a function (evaluating 'RegExp.prototype.test.bind(
    /^(data|aria)-[a-z_][a-z\d_.\-]*$/
  )')
 ```

 In that case, you'll need to include a polyfill for Function.prototype.bind. In the sample project below, I've included this.  You'll need to add another `<script>` tag to `test.html` to fix this.

If you run into other errors, such as ones for jQuery, you can do something similar.  Either add the JavaScript for it and add another script tag, or just include it from a CDN.  The choice is up to you.

These errors gave me much displeasure and my hope is that you won't have to feel the same pain.

## Extras
I have set up a basic project for you with example files to help with any setup questions you may have.  You can find it [here](https://github.com/andrewvida/leiningen-cljs-test-example).
