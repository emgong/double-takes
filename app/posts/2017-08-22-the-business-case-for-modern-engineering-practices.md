---
title: "The business case for modern engineering practices."
description: "Why business managers should concern themselves with coding practices."
tldr:
  title: "A guest post from Daryl"
  body: """
        Our longtime friend and colleague <a
        href="https://en.m.wikipedia.org/wiki/SOLID_(object-oriented_design)">Daryl
        Kulak</a> recently finished a
        <a href="https://smile.amazon.com/Journey-Enterprise-Agility-Thinking-Organizational/dp/3319540866">great
        book</a> on the future of agile software. To celebrate, we
        invited him to share some of what he's learned about the intersection
        of smart engineering practices & smart business decision-making. Enjoy!
        <div class="rt">— Todd & Justin</div>
        """
author:
  name: "Daryl Kulak"
  url: "https://www.linkedin.com/in/darylkulak"
---

From a developer's perspective, modern engineering practices have a lot of
advantages. You can spend less time debugging when you have a suite of automated
unit tests to pinpoint problems. Most developers I've met who've made the switch
from conventional coding practices to modern engineering practices have had an
almost religious experience with how much it has helped them technically,
professionally and even personally.

But that's not the topic for today. Today's topic is why modern engineering
practices make business sense. Why are they worth investing in? Why will they
benefit the organization?

Working at [Pillar Technology](http://pillartechnology.com) the past eight
years, I've had the chance to see several dozen teams using these practices,
including pair programming,
[SOLID](https://en.m.wikipedia.org/wiki/SOLID_(object-oriented_design))
principles, test-driven development (TDD), continuous integration and DevOps.
Some of the practices seem counter-intuitive, at best, and downright
nonsensical, at worst. Especially to managers and businesspeople. But I've seen
the benefits firsthand.<sup>&ast;</sup>

Let's outline the five business benefits I've observed.

## 1 - Lower Total Cost of Ownership

Where do IT shops spend most of their money?  On the new development efforts?
Nope. Almost all technology departments spend an overwhelming amount of their
budgets on what is called "keeping the lights on." That means paying for the
on-going operations of the data center, help desk, setting up new users,
upgrading versions of software and, a very big item, maintaining existing code.
Every time you build a new app and finish it, that app goes into the pile of
existing apps and has to be maintained by someone. Over time, that pile gets
larger and larger and eventually eats the IT budget. Instead of spending so much
time optimizing our development process (often 20% of the budget) how about we
optimize the maintenance efforts (80%)?

Using modern engineering practices leads directly to reducing the big line item
of on-going software maintenance. Developers are thinking ahead to how easy (or
hard) this software will be to maintain later. Things like variable naming are a
**big deal** with the new engineering practices. I remember one developer named a
switch "Deja Vu" to show that "you've been here before. Cute, to be sure, but he
really didn't seem to be worried about someone knowing what he was trying to
accomplish five years later.

But engineering practices go far beyond variable naming. Developers look at the
lengths of methods, keeping them short and simple and only trying to accomplish
one thing. They try not to have embedded IF-THEN or FOR LOOPS, because that
always creates confusion when you're trying to debug.

In fact, if we can just reduce debugging time after an app is in production,
what a giant relief that would be (and money saver)! Modern engineering
practices focus in on exactly that. Reducing debugging.

Which leads to probably the number one most productive engineering practice.
Testing. No, we are not talking about some separate testing group running
special system-wide tests against thousands of lines of code to see if the
business functionality is working. We are talking about unit tests written by
developers. Lots of unit tests. Great developers create tests as part of writing
code, in a process called test-driven development. The results, in terms of
reducing debugging time, are just this side of magical. The whole mindset of
writing tests immediately while coding creates a situation that I say reduces
the "legacy of legacy applications." A legacy application is the one that people
are afraid to touch.

"Here, fix this in the Antiquated-78 system, please."

"No way! If I make one fix, I might bring the whole house of cards come crashing
down!  Pick some other victim, okay?"

But with lots of tests (high-quality tests, that is) you can make a fix and then
run the tests to see what else you broke. If the tests are small in scope, you
can see within a few lines of code right where the problem is.

So we can attack that giant "keep the lights on" budget line item with
engineering practices. What else?

## 2 - Increased Speed of Development

Just like we can decrease debugging time post-production, we can do the same for
the development lifecycle. People can accomplish so much more business value if
they can easily spot their errors with code that is easy to read and has tests
wrapped around it.

Pairing is an engineering practice where two developers work side-by-side, two
monitors, one computer, one piece of code. One person is called the driver and
is writing the code, the other is the navigator and is watching what the driver
is doing and trying to help. This practice helps productivity go through the
roof. I think of it as "instant QA" because we're essentially trying to find
errors before they are even compiled. Plus, the old problem I remember as a
developer of banging my head against the wall for hours because I missed one
small thing is often reduced to seconds, because the other person can bring
their unique perspective and can point out the error in no time.

#3 - Faster Ramp-up Time

Pairing also helps with ramping up a new team member. Remember how intimidating
it was to have to jump in to a new application and figure out what was
happening? With pairing, you can benefit from an experienced team member's
viewpoint, and they can give you a guided tour of the unfamiliar code. Pairs
don't have to be one junior and one senior. There are lots of ways to pair and
ways to learn.

These practices also keep the team from having siloed knowledge. It is difficult
to be the only expert in a particular piece of code when people are pairing and
using tests and good clean coding principles. Then when that person quits or has
to move to another team, there isn't the huge gap that there might have been.
Siloed knowledge costs money.

## 4 - Lower Cost of Development Tools

This isn't a direct result of modern engineering practices, but it is
correlated. Developers using these practices seem to greatly prefer open source
development tools over proprietary tools, like those from IBM or Oracle. There
is something about being able to look inside the code of the tool you're using
to figure out the best way to use it.

The developers' preferences, in this case, are the company's financial gain,
because open source tools cost exactly nothing in license fees, although there
is often a need to pay for support, but the total bill is reduced by half or
more from what you'd pay for the proprietary stuff. And the open source tools
are updated very often and include the latest features and ideas, because there
are so many people contributing to them around the world. The tricky thing can
be to pick the "it tool" among the has-beens. There is nothing more frustrating
than to start using an open source development tool only to find that everyone
else has moved on to the next thing, so the support community is non-existent.

## 5 - Reduced Developer Turnover

Again, it is hard to show the exact connection, but I've certainly seen a
correlation between these practices and reduced developer turnover. In our
consulting firm, turnover is ridiculously low. I attribute it to our company
culture, of course, but also to the practices. The thing is, this type of
engineering goes beyond practices, after all. It is more about a mindset, a
worldview. It is a line of thinking that developers should write code they feel
proud of. Developers should not allow themselves to be in situations where they
are rushing to create the next chunk of functionality, abandoning the quality
they know they should be building in. As a manager, working with this type of
developer is a very different world from regular code-slinging programmers. It
is more frustrating for the manager, to be sure, but the results are also a lot
better in terms of everything we've described in this article.

Although the modern engineering practices and worldview may seem very odd to
non-technical executives and managers, there is a significant business case to
be made for trying it. If you want an experiment to reduce the heavy costs
you're paying each year for maintaining code, slow development cycles and heavy
turnover, consider hiring a firm like [Test Double](//testdouble.com) or [Pillar
Technology](http://pillartechnology.com) to help you get started with a
high-quality software engineering approach.

* * *

<sup>&ast;</sup> No, I don't have scientific proof of these benefits. In order
to have "proof" we would have to run identical teams side-by-side where one
group uses modern engineering practices and one does not. They'd have to be
building the same application and have the same team members on both teams (some
developers are more productive than others, after all). Do you see the problem?
Yes, these are anecdotal, but my observations are based on several dozen
"anecdotes" which hopefully helps my case.

> Daryl Kulak is an executive consultant at Pillar Technology. His latest book is
> called "The Journey to Enterprise Agility: Systems Thinking and Organizational
> Legacy" (Springer, 2017). It is available in [hard
cover](https://smile.amazon.com/Journey-Enterprise-Agility-Thinking-Organizational/dp/3319540866),
> [PDF](http://www.springer.com/us/book/9783319540863#otherversion=9783319540870)
> as well as [audiobook on
> Audible](https://www.audible.com/pd/Business/The-Journey-to-Enterprise-Agility-Audiobook/B072WB7QG7).
