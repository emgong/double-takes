---
title: "Mock objects in Discovery Tests."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
video:
  url: "http://www.youtube.com/embed/MkgDPRgt9XU"
  type: "youtube"
reddit: true
---

This screencast is a very cursory introduction to a variant of TDD that's described as
everything from "London style" to "Mockist", "Outside-in", "Isolation", and "GOOS".
I've recently started calling it "Discovery Testing" to emphasize its intended benefit
and distance it from the now too-conflated-to-be-useful term "unit test". Since none
of those other names have stuck, perhaps this one will.

The screencast may provide you with a clearer picture about what some people who talk about
mock objects in a positive light are actually talking about. My goal is to  illustrate
and demonstrate their very narrow (but well-defined) purpose in this alternative approach to TDD.
Our use of mock objects is fundamentally different from how they're used by most
well-published practitioners of TDD, but both tribes tend to confuse the community
by using the same language to describe differently-motivated activities.

A lot of criticism about mock objects (e.g. mocks returning mocks, mocks reducing
confidence in a test's value, mocks that produce fantasy green tests) simply have
*no bearing on discovery testing* as I practice it. Each of those symptoms suggest
a wildly different (and less valuable, in my opinion) approach to mock objects
which—depressingly—also represents the vast majority of their use.

If you haven't yet, please read [Gary's post on test isolation](https://www.destroyallsoftware.com/blog/2014/test-isolation-is-about-avoiding-mocks)
this morning. I agree with Gary wholeheartedly. As much as I love how test
doubles provide a mechanism to accomplish a workflow that I really
enjoy using, I only use mocks to the extent I need them to specify the contract
between a subject's dependencies. The real goal of discovery testing is to
quickly reduce the scope of a problem and expose a rich harvest of leaf nodes
in the object graph. Leaf nodes that have no dependencies and implement pure
functions are easy to test, maintain, and understand. As a result, the name of the
game is to **maximize the leaf nodes in your object graph and minimize the collaborators**.
I tend to write a deep and wide tree with lots of collaborators when reducing a
very complex task, and I tend to arrive at much flatter trees when the task is
either simple or well-understood.

Here are some links to things covered or mentioned in the screencast:

* [The screencast's example code](https://github.com/testdouble/discovery-testing)
* [GOOS](http://www.growing-object-oriented-software.com)
* [Beck, DHH, Fowler TDD Hangout](https://plus.google.com/events/ci2g23mk0lh9too9bgbp3rbut0k)
* [Uncle Bob's recent post on mocking](http://blog.8thlight.com/uncle-bob/2014/05/14/TheLittleMocker.html)
* [Uncle Bob's other recent post on mocking](http://blog.8thlight.com/uncle-bob/2014/05/10/WhenToMock.html)
* [Gary Bernhardt's post on test isolation](https://www.destroyallsoftware.com/blog/2014/test-isolation-is-about-avoiding-mocks)
* [jasmine-given](https://www.github.com/searls/jasmine-given)
* [node-sandboxed-module](https://github.com/felixge/node-sandboxed-module)
* [jasmine-stealth](https://www.github.com/searls/jasmine-stealth)

If you enjoy the screencast, please let us know by [twitter](http://twitter.com/testdouble)
or [e-mail](mailto:hello@testdouble.com)!
