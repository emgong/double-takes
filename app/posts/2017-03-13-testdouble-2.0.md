---
title: "testdouble.js 2.0"
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
reddit: false
---

The best mocking library for JavaScript testing has just gotten a whole lot
better with today's release of [testdouble.js
2.0](https://github.com/testdouble/testdouble.js).  This release irons out a few
public API quirks found in the 1.x series, greatly enhances a number of existing
features, and sets the team up to keep delivering features to make unit testing
more pleasant. As always, our goal is to create a tool that aids developers in
arriving at simpler, more usable designs in their JavaScript applications.

Here's a taste of what's been included in this version 2.0 release:

* A (breaking) change to how `td.replace()` swaps out constructor functions.  In
  1.x, `td.replace` would inject an artificial constructor and return to the
  test a plain object of test double functions. Instead, 2.x returns the entire
  fake constructor to the test. User feedback tells us this behavior will be
  less surprising. The change also enables tests to stub & verify how
  constructors themselves are invoked for the first time.  Moreover, "static"
  properties on the constructor are now also replaced with test doubles in
  addition to prototypal functions.  Finally, this behavior is now exposed via a
  new top-level `td.constructor()` API method (as opposed to only being
  accessible via `td.replace`). [More on constructor function changes
  here](https://github.com/testdouble/testdouble.js/pull/201)
* The `td.function()` method of creating a test double has now gained the
  ability to mimic an actual dependency the same way its siblings `td.object()`
  and `td.constructor()` imitate objects and constructors. When passed a
  function, `td.function` will infer its name, copy its properties, and replace
  any function properties with test doubles (e.g.  imagine a module that exports
  an async function but also exposes a `sync` version as a property of the
  primary one—now both functions will be placed under the test's control!).
  [More on td.function's changes
  here](https://github.com/testdouble/testdouble.js/pull/204)
* [Proxy test
  doubles](https://github.com/testdouble/testdouble.js/blob/master/docs/4-creating-test-doubles.md#objectobjectname)
  are now a practical option for many teams. While not a new feature, many
  testdouble.js users are now running Node.js version 6 or higher, which
  includes support for [ES
  Proxy](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy).
  When we first shipped this feature, it only worked on prerelease versions of
  Firefox, so most users missed it. If you haven't tried this "blank slate"
  approach to designing your subject's dependencies, give it a try!
* Support for nested usage of [argument
  matchers](https://github.com/testdouble/testdouble.js/blob/master/docs/5-stubbing-results.md#loosening-stubbings-with-argument-matchers),
  which allows for even more granular control over how a test double is invoked.
  Now instead of specifying whether an entire argument satisfies
  `td.matchers.isA(Number)`, you can assign the matcher to a single property on
  an object or element of an array. There are now vanishingly few invocations
  that _can't_ be specified by testdouble.js. [More on improved nested matcher
  support here](https://github.com/testdouble/testdouble.js/pull/203)
* Asynchronous support for stubs that use `thenCallback`, `thenResolve`, or
  `thenReject`. Callback stubs can now be deferred to a later call stack by
  setting the `defer` option to true. Callback and promise stubs can also be
  configured with a `delay` (in milliseconds) so tests can have fine-grained
  control over the order and timing of asynchronous events in cases significant
  to the
  [subject](https://github.com/testdouble/contributing-tests/wiki/Subject).
  [More on async stubbing
  here](https://github.com/testdouble/testdouble.js/pull/205)
* Improved messages when a `td.verify()` call fails due to a test double not
  being invoked the right number of times in a way that satisfied the specified
  verification. (This gets really tricky when using argument matchers, trust
  us!) [More on improved verification messages
  here](https://github.com/testdouble/testdouble.js/pull/196)
* Internal build improvements, notably the incorporation of
  [babel](http://babeljs.io) and [yarn](http://yarnpkg.com) into the project.
  Neither of these are user-facing changes, but we hope the conversion of the
  project to ECMAScript 201X will lower the barrier of entry for new
  contributors

These changes also set us up for a few exciting new ideas for the 2.0 series of
the library. Just a sample of them include:

* Now that each type of test double can be created by imitating a production
  dependency, test doubles are now primed to provide warnings when stubbed or
  verified with an arity that doesn't match the defined function `length`. This
  may be a useful way to combat so-called fantasy tests as test doubles slip out
  of alignment with their mirrored actual dependencies. [More on the opportunity
  to warn about arity mismatches
  here](https://github.com/testdouble/testdouble.js/issues/3)
* While testdouble.js boasts a one-of-a-kind test double introspection API in
  [td.explain](https://github.com/testdouble/testdouble.js/blob/master/docs/9-debugging.md#tdexplainsometestdouble),
  it still requires a bit of futzing when a test fails unexpectedly. The recent
  improvements to how messages are factored will allow us to be more proactive
  when a test fails. By passing failure status to `td.reset()` (which you should
  be calling after each test!), testdouble.js could be improved to log out a
  state of its universe (e.g. what test doubles were created by the test, and
  how they were each stubbed, invoked, and verified). Our goal with this feature
  is to increase the odds that you'll recognize the cause of an error without
  having to debug or `console.log` and re-run the test. [The issue for this
  `td.reset` health check is
  here](https://github.com/testdouble/testdouble.js/issues/162)
* Currently, each mechanism available for creating test doubles performs a
  shallow clone of the actual dependency being doubled. Now that the
  `td.constructor()` API has been made to be symmetrical between the test and
  subject, we can consider implementing a "deep mock" feature that recursively
  replaces even deeply-nested functions in a dependency with test doubles. What
  remains to be seen is whether this is _ever actualy a good idea_, however. If
  you feel strongly about this, [please let us
  know](https://github.com/testdouble/testdouble.js/issues/new)

There's never been a better time to take a second look at incorporating
testdouble.js into the design of your unit tests. Our goal was to ship a 2.0
release that establishes solid footing on which the library can be maintained
for years to come and we're confident this release has accomplished that goal.

## Slow and steady adoption

In the 18 months since we first published our eponymous testdouble.js library,
we've been reminded that it's pretty hard to rally a community around a mocking
library, even if we're certain it's far-and-away the best one available for a
given language.

That's the kind of paragraph you write before printing a chart showing that your
mocking library hasn't exactly taken the JavaScript world by storm:

<figure>
  ![Monthly downloads of testdouble.js vs Sinon](/img/tdjs/td-vs-sinon.png)
  <figcaption>The X-axis of this graph is actually not red.</figcaption>
</figure>

Why is Sinon still the runaway leader in JavaScript mocking a year hence? If
you'll permit it, I'd like to spend a little time explaining away this chart and
pretending it doesn't bother me with lots of big words and careful
argumentation about why we think it's worth continuing to invest our time in
this library.

## Why it's important that testdouble.js exists

The first mocking library I encountered that featured a pleasant user experience
was Java's [Mockito](http://mockito.org), years ago. But even though it was
vastly superior, it took many more years before its adoption rate (much less its
userbase) began to rival other Java mocking libraries—despite their painfully
clunky APIs. We're now seeing a similar curve to the adoption of testdouble.js,
even as its chief alternative [Sinon.js](http://sinonjs.org) is now clearing an
astonishing 3 million downloads per month.

But for the fact a lot of Sinon users aren't aware of its alternatives, the
relatively gradual adoption of testdouble.js is not a grave concern to us. If
anything, this presents an opportunity to explain why test doubles are
emblematic of a cadre of low-priority-and-yet-fundamental aspects of software
development.

First, consider just how distant test doubles can seem from the vantage point of
a team trying to build and deploy an application:

* The primary concern of software development is the production code. Opinions
  vary wildly on the best way to write code. Even if two vastly different
  implementations both behave identically from the perspective of the user,
  developers regularly stake their reputations on passionately-held beliefs over
  how software should be made. Even when arguments over code devolve into
  absurdity, debate is at least governed by a clearly-defined limiting
  factor: an implementation has to _actually work_ to be considered superior
* A secondary concern of development is automated testing. Here, opinions are
  even more diverse! Teams regularly litigate what types of tests to write and
  how many—they even disagree about the _nature_ of the confidence they seek
  from their code's test suites (it's about design! Nay, integration!). The
  governing principle of debates over testing is therefore much looser than it
  is for code, but it still exists: the tests should pass, be reasonably fast,
  and give confidence that the production code _probably works_
* Mocking libraries represent a distant _tertiary_ concern for developers: to
  the extent their tests can't (or shouldn't) perfectly replicate real-world
  conditions in which to exercise their production code, how should we go about
  faking out reality?  Because "making test doubles" is in nobody's job
  description, most developers rarely evolve beyond intuition when it comes to
  gauging how much fakeness they should tolerate. Most of a team's (very
  limited) energy on this concern is spent arguing _whether_ to fake something
  or to what extent, much less _why_ or _how_. If a limiting factor exists to
  keep these debates grounded in some kind of value system, it's so hazy as to
  be imperceptible

The truth is that the vast majority of developers don't give much thought to
their use of test doubles, and they only reach for the nearest mocking library
to the extent needed to make their immediate test pain go away. This fact
dramatically strengthens the incumbency effect that a library like Sinon enjoys.
Think about it: for all the complaining we do about JavaScript framework
fatigue, we see few hot takes about the dizzying speed of innovation of test
double libraries.

If there's one principle that has guided my own open source, writing, and
speaking, it's been that the industry doesn't give people enough time to
consider secondary-but-still-important topics that impact the software we write.
Having a consistent, comprehensible, and well-reasoned approach to _defining
reality_ is exactly one such topic. It's true: mocking libraries are a distant,
seemingly-trivial concern from the perspective of the people cutting our
paychecks. But that doesn't make it any less critical that teams maintain a
clear understanding of the context under which their code is verified.

It's been my privilege to have taken so much time to consider this particular
scruple over the years, and it's why this library is as opinionated and focused
as it is. As our team has grown around it, I've seen [our
consultants](http://testdouble.com/agency) use testdouble.js as an educational
tool on their client teams, helping developers better express intention in their
tests and in turn improve the design of their production code. One of the
reasons I love that our company is named [Test Double](http://testdouble.com) is
that this seemingly minor aspect of our craft demonstrates the importance of
sweating the small stuff if your aim is to write great software.

As a result of all this, it's no surprise that testdouble.js adoption has been
slow and steady—99% of people using a mocking library are simply looking for a
hammer to knock real things out with fake things in an effort to get a test to
pass. This library was written to suit a much more conscientious workflow and as
a result serves a smaller, more discriminating audience. If you haven't before
had the chance, there's an incredible opportunity to be found in taking the time
to dive in and better understand how thoughtful use of test doubles can improve
the design of your code. Consider exploring our [wiki on
testing](https://github.com/testdouble/contributing-tests/wiki) or the longer
form screencast series on this blog on [Discovery
Testing](2015-09-10-how-i-use-test-doubles) or [asking me something on
twitter](https://twitter.com/searls).

Most important of all, we hope you'll enjoy the improvements made in today's
2.0 release. If you find working with testdouble.js to be valuable, we'd love to
hear about it!
