---
title: "My favorite way to TDD."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
video:
  url: "https://www.youtube.com/embed/videoseries?list=PLIuJbrOVyGjl0keQ-QyiMEOCvmabJEf0t"
  type: "youtube"
reddit: true
---

I've been chatting with a bunch of people lately about testing. Everything from
helping people get started from square one, companies transitioning suites into new contexts
(say, after moving from a monolith to a microservices architecture), all the way to teams
struggling with large slow test suites that they've grown to hate.

One topic that comes up often is the role of mock objects in testing, particularly
when practicing test-driven development. There are a lot of forceful generalizations
out there ("beware of over-mocking!", "only mock what you own!", "only mock external
systems you don't own!"), but taken alone they don't do very much to explain when
test doubles should be used and when they shouldn't. I have a pretty good idea why
that is.

The reason is that there are two schools-of-thought when it comes to TDD as a
productivity workflow. On one hand: Detroit-school TDD, the simpler red-green-refactor
workflow. On the other: London-school TDD, which makes use of test doubles to
direct the design of systems.

This video series explores the lesser known latter school, using a technique that
I've come to call Discovery Testing. We'll start with the background needed to make
sense of why the tooling and terminology we use about testing is so overloaded, then
use an ambitious approach to [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)
as an example problem to work through together, one test at a time.

Episodes so far in the series:
* [Part 1](https://www.youtube.com/watch?v=aeX5OXO-w30&index=1&list=PLIuJbrOVyGjl0keQ-QyiMEOCvmabJEf0t)
* [Part 2](https://www.youtube.com/watch?v=jGs55tQS7ww&index=2&list=PLIuJbrOVyGjl0keQ-QyiMEOCvmabJEf0t)
* [Part 3](https://www.youtube.com/watch?v=iL2l_pbOlug&list=PLIuJbrOVyGjl0keQ-QyiMEOCvmabJEf0t&index=3)

Some links of things referenced in the series so far:
* My wiki on testing topics
* [Our new testdouble.js library](https://github.com/testdouble/testdouble.js)
* [GOOS](http://www.growing-object-oriented-software.com)
* [Code Retreat](http://coderetreat.org)
* The original implementation this series is based on is [on GitHub](https://github.com/searls/junit-mocha-example/tree/2015-08-31-group/src/main/java/com/conway)
