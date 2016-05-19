---
title: "The test double abuse scandal."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
reddit: false
---

## The trouble with test doubles

I've had the good fortune of writing a few different test double ("mocking")
libraries over the last few years, most notably
[gimme](https://github.com/searls/gimme) for Ruby and
[testdouble.js](https://github.com/testdouble/testdouble.js) for JavaScript. As
for others, I really like [Mockito](http://mockito.org) for Java, too.

But beyond that, I don't like many mocking libraries. Or much of the mocking I
encounter, for that matter.

See, the three libraries above are all designed with a singular purpose: to help
developers practice [a](2015-09-10-how-i-use-test-doubles.html)
[particular](2014-05-14-mock-objects-in-discovery-tests.html)
[brand](https://github.com/testdouble/contributing-tests/wiki/London-school-TDD)
of [TDD](https://en.wikipedia.org/wiki/Test-driven_development). The way these
test double libraries accomplish that goal is by providing an opinionated API to
facilitate the use of functions and objects that wouldn't otherwise exist by
enabling your tests to take a trial run at using them. The developer can then
quickly iterate on the subject's contract with each dependency (e.g. its method
signature and value types). But I'll explain more about how outside-in testing
works in [just a bit](#how-discovery-testing-works). For now, all that matters is
that these tools are written to facilitate a very specific, poorly-understood
creative workflow.

So, why don't I like most mocking libraries? Because hardly anyone uses them in
a way that provides much value. Rather than encouraging clean, simple designs,
it's as if most mock usage is born out of a base impulse to poke holes in
hard-to-use code. Test doubles hould help define clear boundaries between a unit
and its dependencies, but most mocks are used to keep tangled dependency graphs
on life support, enabling verification of what amount to implementation details
and inhibiting the healthy design pressure to refactor hard-to-change code.

As a guy who works at [a company named Test Double](http://testdouble.com), I
have a vested interest in their being well understood and well used. In fact, I
would go so far as to say that test doubles should be used in only two cases:

* When practicing rigorous outside-in test-driven development
* When a clean boundary or protocol between areas of code is already established
and a test would be clearer if the things beyond that boundary were controlled by
the test

The above cases easily account for less than 1% of the use of mock objects I've
seen over the last decade, which is disheartening to say the least.

Not to belabor the point, but this isn't necessarily the fault of developers.
Even though lots of mocking libraries were written by developers who grok this
stuff, their documentation often focuses on "how to fake stuff" and not "how to
write good tests". It's much easier to give people what they ask for instead of
what they need, though, and so mocking libraries cursed with popularity tend to
become bloated and oriented towards problematic usage over time.

In fact, the whole reason I recently invested the time in writing [testdouble.js
over sinon](2016-03-13-testdouble-vs-sinon.html) was that
I have yet to see a team whose use of Sinon provided more value than harm. While
how we use our tools is ultimately our responsibility, the tools themselves
matter a great deal in informing our use—something I recently enjoyed [reflecting
on in this talk at
RailsConf](http://localhost:8000/posts/2016-05-09-make-ruby-great-again.html)

So, if most people are abusing test doubles, what's a way to use them
productively? Read on!

## How discovery testing works

Let's talk about what I mean when I say "outside-in" test-driven development. To
be even more clear, these days I refer to it as "discovery testing".

The practice starts by thinking about the ultimate goal of a feature and working
outside-in, starting with a test of an entry point (e.g. a `main` function, a
CLI, a UI handler, or an HTTP route). From there, the primary activity is
oriented around breaking the problem down as much as possible by "discovering"
names and contracts of new units that could do the requisite work.

The workflow goes something like this:

1. Write a failing test for a new function
2. Instead of implementing the functionality, code by wishful thinking and ask
"what 2 or 3 subordinate functions could do all this work for me?"
3. Can't break it down? Then implement the subject as a pure function and don't
use test doubles in its test
4. Can break it down? Then use a test double library to create & inject fake
dependencies
5. Design a test that requires the subject to invoke these new dependencies
to ultimately return a value ("stubbing") or have a final side effect ("spying")
6. If the functions you thought your subject would need are awkward to use, or
the values that would pass between them aren't a good fit, there's no cheaper
time to throw them out and start over—they don't exist yet!

What shakes out is a tree of very small, well-named units and a great many pure
functions as leaf nodes in that tree.

The tests that use test doubles provide very little safety, as they only test the
single responsibility of their subject: to call other stuff correctly. The tests
of the pure functions shouldn't use test doubles, because their responsibility is
to take inputs, implement some bit of logic, and return a value—any fakeness
would undercut confidence in that responsibility.

The benefits to this approach are numerous, but they're highly opinionated too,
in ways that often surprise people:
* Small, thoughtfully-named identifiers
* [SRP](https://en.wikipedia.org/wiki/Single_responsibility_principle)-compliant
units
* Clear unidirectional dependency graphs, allowing for easy extraction or
reimplementation
* Anxiety-reduction by helping combat [blank page
syndrome](https://blog.codinghorror.com/avoiding-blank-page-syndrome/)

Take a look at [scripty](https://github.com/testdouble/scripty/tree/master/lib)
for an imperfect example of why this is a culturally shocking approach to most
JavaScript developers, who tend to prefer packing in numerous responsibilities
into a single-function, favoring conciseness over reductionism.

It's clear that not a lot of people write code this way. Even most people who
practice TDD [rely on refactor-heavy
workflows](2014-01-25-the-failures-of-intro-to-tdd.html) to ultimately arrive at
small, well-named units via hard-thinking and method extraction.

Should you try this out? That's up to you and whether you value the stated
benefits enough to cut against the grain of your preferred language, framework,
and social ecosystems.

I think it's often worth it, especially when approaching a problem I don't have
tremendous confidence in solving.

## I really hate mocking

The trouble with all this is that I can count on two hands the number of
developers I'm acquainted with that really understand this highly-disciplined
school of test-driven development.


