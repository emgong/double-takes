---
title: "The Failures of \"Intro to TDD\""
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
reddit: true
---

I'm now halfway through teaching a two-week crash course on "agile development stuff" to a team of very traditional enterprise Java developers. Condensing fifteen years of our community's progress into 8 half-day workshops has presented an obvious challenge: given the clear time constraints, what set of ideas and practices could conceivably have the biggest positive impact on these developers' professional lives?

After a few days of fits and starts, I've come to at least one realization: test-driven development ("TDD") as it's traditionally introduced to beginners is officially *off my list*.

The problems with how TDD is typically introduced are fundamental, because they put the learner on a path that leads to a destination which might *resemble* where they want to go, but doesn't actually show them the way to the promised destination itself. This sort of phenomenon happens often enough that I've decided to finally settle on a name: "WTF now, guys?"

<figure>
  ![Fig 1. WTF Now, Guys?](/img/tdd-fail/wtf-now-guys.svg)
  <figcaption>Fig. 1 — Seriously, though, WTF?</figcaption>
</figure>

I think this illustration captures why arguments between developers over TDD tend to be unsatisfyingly dissonant. When a developer lodges a complaint like, "mock objects were everywhere and it was awful", another developer operating from the context of the taller mountain might reply, "huh? Mock objects are everywhere and it's wonderful!" In fact, it's typical for folks to talk over one another in debates about TDD, and I believe it's because we use the same words and tools to describe and practice entirely unrelated activities. What's a valid problem with TDD from the mountain on the left comes across as nonsense to someone scaling the mountain on the right.

If I'm right (judge for yourself below), I think this argument might explain why so many developers who were once excited by the promise and initial experience of TDD eventually grew disillusioned with it.

## Teaching "classic TDD" with code katas.

Let's talk about using [code katas](http://en.wikipedia.org/wiki/Kata_(programming) to teach TDD.

I started the group with a brief demonstration of test-driving a function that returns the Fibonacci number for a given index. I was stumbling over myself to emphasize that the entire day's examples were *not very realistic*, but might at least illustrate the basic rhythm of "red-green-refactor". Later, we moved on to a walkthrough of [Uncle Bob's bowling game kata](http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata). Finally, we finished the day with the attendees pairing off to implement their own Roman-to-Arabic numeral conversion function.

The next day I stood at the whiteboard and asked the class to summarize what they perceived as the *benefits* of TDD. Unsurprisingly (but importantly), every attendee perceived TDD as being about correctness: "code free of defects", "automated regression testing vs. manual", "changing code without fear of breaking it," etc.

When I reacted to their answers by telling the class that TDD's primary benefit is to improve the *design* of our code, they were caught entirely off guard. And when I told them that any regression safety gained by TDD is at best secondary and at worst illusory, they started looking over their shoulders to make sure their manager didn't hear me. This did not sound like the bill of goods they had been sold.

Instead, let's pretend that I had sold the code katas above as emblematic of my everyday routine, as opposed to what they are: trivial example exercises. What if I'd turned the students loose under the false premise that TDD as it's practiced in kata exercises would prove useful in their day jobs?

### Failure #1: Encouraging Large Units

For starters, if you intend for every test to make some progress in *directly solving your problem*, you're going to end up with units that do more and more stuff. The first test will result in some immediate problem-solving implementation code. The second test will demand some more. The third test will complicate your design further. At no point will the act of TDD *per se* prompt you to improve the intrinsic design of your implementation by breaking your large unit up into smaller ones.

<figure>
  ![Fig 2. Classic TDD Kata](/img/tdd-fail/new-story.svg)
  <figcaption>Fig. 2 — Consider the above. If a new requirement were introduced, most developers would feel inclined to add additional complexity to the existing unit as opposed to preemptively assuming that the new requirement should demand the creation of a new unit.</figcaption>
</figure>

Preventing your code's design from growing into a large, sprawling mess is left as an exercise to the developer. This is why many TDD advocates call for a "heavy refactor step" after tests pass, because they recognize this workflow requires intervention on the part of the developer to step back and identify any opportunities to simplify the design.

Refactoring after each green test is gospel among TDD advocates ("red-green-refactor", after all), but in practice most developers often skip it mistakenly, because nothing about the TDD workflow inherently compels people to refactor until they've got a mess on their hands.

Some teachers deal with this problem by exhorting developers to refactor rigorously with an appeal to virtues like discipline and professionalism. That doesn't sound like much of a solution to me, however. Rather than question the professionalism of someone who's already undertaken the huge commitment to practice TDD, I'd rather question whether the design of my tools and practices are *encouraging me to do the right thing* at each step in my workflow.

### Failure #2: Encouraging Costly Extract Refactors

Nevertheless, suppose that you *do* take the initiative to perform an extract refactor after the unit starts becoming large.

<figure>
  ![Fig 3. Extract Refactor](/img/tdd-fail/extract-refactor.svg)
  <figcaption>Fig. 3 — Extracting part of a unit's responsibility into a new child unit. The original test remains unchanged to assure us that the refactor didn't break anything.</figcaption>
</figure>

Keep in mind, however, that extract refactors are generally quite painful to undertake. Extract refactors often require intense analysis and focus in order to detangle one complex parent object into one tidy child object and one now-slightly-less complex parent. Paraphrasing a conversation with [Brandon Keepers](http://twitter.com/bkeepers), "it's easier to take two balls of yarn and tie them into a knot than it is to take a single knot of yarn and pull them into two balls."

### Failure #3: Characterization Tests of Greenfield Code

Even after the refactor is completed successfully, more work remains! To ensure that every unit in your system is paired with a well-designed (I call it "symmetrical") unit test, you now have to design a new unit test that characterizes the behavior of the new child object. This is hugely problematic, because characterization tests are a tool for dealing with legacy code, and as such should never be necessary if all the code was test-driven. And yet, if we define "characterization test" as "wrapping an untested unit with tests to verify its behavior," that's exactly the situation at hand: writing tests for an already-implemented unit that has no matching unit test.

Because the new test is not written in a normal TDD rhythm, the developer runs the same risks as one would when practicing "test-after-development". Namely, because the code already exists, your characterization test can exercise each line of the new child unit without any certainty that the test demands all of the unit's behaviors. So even though you've done the extra (and laudable) work of covering the new unit, the upper bound on that test's quality is lower than if you'd test-driven that unit from scratch. That observation alone suggests the activity is wasteful.

<figure>
  ![Fig 4. Child Characterization Test](/img/tdd-fail/child-characterization-test.svg)
  <figcaption>Fig. 4 — Characterizing the new child unit's behavior with a test. We should be wary of the test's robustness, however, because it was the product of "test-after development".</figcaption>
</figure>

### Failure #4: Redundant test coverage

But now your system is plagued by yet another testing evil: redundant test coverage! Covering the same behavior in two places often *feels* warm and fuzzy to TDD novices, but it doesn't take long before the cost of change spirals out of control.

Suppose a new requirement comes along requiring a change to the extracted child object's behavior. Ideally, this would require exactly three changes (all of which should be readily anticipated by the developer): the integration test that verifies the feature, the unit's test to specify the change in behavior, and the unit itself. But in our redundantly-tested example, the parent unit's test *also* needs to change.

Worse yet, the developer implementing the change has no reason to expect the parent object's unit test will fail. That means, at best, the developer faces an unpleasant surprise when the parent's unit test breaks and extra work is subsequently required to redesign the parent's test to consider the new behavior of the child. At worst, the developer might lose sight of the fact that the test failure was a *false negative* caused by a course-of-business change and not a *true negative* indicating a bug, which could result in wasted time investigating the nature of the parent's test failure.

<figure>
  ![Fig 5. Redundant Test](/img/tdd-fail/redundant-test.svg)
  <figcaption>Fig. 5 — A change in the child object causes the parent's test to break, requiring the parent's test to be redesigned even though the parent object itself didn't change.</figcaption>
</figure>

Imagine if the child object were used in two places—or ten! A trivial change in an oft-depended-on unit could result in hours and hours of painstaking test fixes for everything that depends on the changed unit.

### Failure #5: Eliminating Redundancy Sacrifices Regression Value

If we hope to avoid the eventual pain wrought by redundant test execution, our intrepid attempt to undergo a simple *extract method refactor* now requires us to redesign the parent unit's test.

Recall that the parent's unit test was written with correctness and regression safety in mind, so its original author will probably not appreciate my prescription to remove the redundancy: replace the real instance of the child unit from the parent's test with a test double in its place.

<figure>
  ![Fig 6. "Useless" test](/img/tdd-fail/useless-test.svg)
  <figcaption>Fig. 6 — The parent test with its previously-real instance of the child unit replaced with a test double</figcaption>
</figure>

"Well now the test is worthless and doesn't actually verify anything!" the original author might argue. And because of the philosophy under which this code was originally written (that TDD is about solving problems incrementally with a side effect of total regression safety), their complaint would be completely valid. Their point could be countered with, "but that unit is already tested separately," but without an additional integration test to ensure the units work correctly together, the original author's concerns aren't likely to be assuaged.

It's at this point that I've seen numerous teams reach a complete dead end, with some being "pro-mocking" and others being "anti-mocking", but with neither really understanding that this disagreement is merely a symptom of the fallacious assumptions that classical TDD encourages us to make.

### Failure #6: Making a Mess with Mocks

Even though I'm usually on team "Yay mocks!", their use in a situation like this one is unfortunate. First, by replacing the child unit with a test double, the parent unit's test is going to become convoluted: part of the test will specify bits of logical behavior carried out by the parent, while other parts will specify the intended collaboration between the parent and child objects. In addition to juggling both concerns, the tester's hands will be tied in *how* the parent-child collaboration is specified because any stubbing will need to be made to agree with whatever logic the parent implements.

Tests that specify both logical behavior and unit collaboration like this are very difficult to read, comprehend, and change. And yet, this frightening scenario probably describes the vast majority of tests in which test doubles are used. It's no wonder I hear so many complaints of "over-mocking" in unit tests, a claim that until relatively recently befuddled me.

The solution to this mess is also a lot of work. The parent unit needs to be refactored such that it only facilitates collaboration between other units and contains no implementation logic of its own. That means the parent unit's other behaviors not implemented by the previously extracted child will also need to be extracted into new units (including all the time-consuming activities described thus far). Finally, the parent's original test should be *thrown away* and rewritten strictly as a "specification of collaboration", ensuring that the units interact with each other as needed. Oh, and because there's no longer a fully integrated test to make sure the parent unit works anymore, a separate integration test ought to be written.

<figure>
  ![Fig 7. Redo](/img/tdd-fail/redo.svg)
  <figcaption>Fig. 7 — A second child object is extracted to encapsulate any remaining behavior in the parent, the parent's test is then replaced with a test specifying the interaction of the two children.</figcaption>
</figure>

**Ouch.** It takes such rigor and discipline to maintain a clean codebase, comprehensible tests, and fast build times when you take this approach that it's no wonder why few teams ultimately realize their goals with TDD.

## A Successful Approach to TDD

Instead, I'd like to chart a different course by introducing a very different TDD workflow from that shown above.

First, consider the resulting artifacts of the roundabout, painful process detailed in the previous example:

* A parent unit that depends on logical behavior implemented in two child units
* The parent's unit test, which specifies the interaction of the two children
* The two child units, each with a unit test specifying the logic for which they're responsible

If this is where we're bound to end up, why not head in that direction from the outset? My approach to TDD considers this, and could be described as an exercise in **reductionism**.

Here's my process:

**(1)** Pull down a new feature request that will require the system to do a dozen new things.

<figure>
  ![Fig 8. Step 1](/img/tdd-fail/step1.svg)
</figure>

**(2)** Panic over how complex the feature seems. Question why you ever started programming in the first place.

<figure>
  ![Fig 9. Step 2](/img/tdd-fail/step2.svg)
</figure>

**(3)** Identify an entry point for the feature and establish a public-facing contract to get started (e.g. "I'll add a controller action that returns profits for a given month and a year")

This would also be a good opportunity to encode the public contract in an integration test. This post isn't about integration testing, but I'd recommend a test that both runs in a separate process and uses the application in the same way a real user would (e.g. by sending HTTP requests). Having an integration test for regression safety from the start can help us *avoid* scratching that itch from our unit tests.

<figure>
  ![Fig 10. Step 3](/img/tdd-fail/step3.svg)
</figure>

**(4)** Start writing a unit test for the entry point, but *instead of immediately trying to solve the problem*, intentionally defer writing any implementation logic! Instead, break down the problem by dreaming up all of the objects you wish you had at your disposal (e.g. "This controller would be simple if only it could depend on something that gave it revenue by month and on something else that gave it costs by month").

This step improves your design by encouraging small, single-purpose units by default.

<figure>
  ![Fig 11. Step 4](/img/tdd-fail/step4.svg)
</figure>

**(5)** Implement the entry point with TDD by writing your test as if those imagined units did exist. Inject test doubles into the entry point for the dependencies you think you'll need and specify the subject's interaction with the dependencies in your test. Interaction tests specify "collaboration" units which only govern the usage of other units and contain no logic themselves.

This step can improve your design because it gives you an opportunity to discover a usable API for your new dependencies. If an interaction is hard to test, it's cheap to change a method signature because the dependency doesn't actually exist yet!

<figure>
  ![Fig 12. Step 5](/img/tdd-fail/step5.svg)
</figure>

**(6)** Repeat steps (4) and (5) for each newly-imagined object, discovering ever-more-fine-grained collaborator objects.

Human nature seems to panic at this step ("we'll be overrun by tiny classes!"), but in practice it's manageable with good code organization. Because each object is small, understandable, and single-use, it's usually painless to delete any or all the units under an obsoleted subtree of your object graph when requirements change. (I've come to pity codebases with many large, oft-reused objects, as it's rarely feasible to delete them, even after they no longer fit their original purpose.)

<figure>
  ![Fig 13. Step 6](/img/tdd-fail/step6.svg)
</figure>

**(7)** Eventually, reach a point where there's no conceivable way to pass the buck any further. At that point, implement the necessary bit of logic in what will become a leaf node in your object graph and recurse up the tree to tackle the next bit of work.

The goal of this game is to discover as many collaboration objects as necessary in order to define leaf nodes that implement a piece of narrowly-defined logic that your feature needs.

Tests of "logical units" exhaustively specify useful behavior and should give the author confidence that the unit is both complete and correct. Logical units' tests remain simple because there's no need to use test doubles—they merely provide various inputs and assert appropriate outputs.

<figure>
  ![Fig 14. Step 7](/img/tdd-fail/step7.svg)
</figure>

I like to call this process "Fake it until you make it™", and while it's definitely based on the keen insights of [GOOS](http://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627), it places a fresh emphasis on reductionism. I also find value in discriminating between the responsibilities of "collaboration units" and "logical units", both for clearer tests and also for more consistent code.

Note also that there is no heavy refactor step necessary when you take this approach to TDD. Extract refactors become an exceptional case and not part of one's routine, which means all the downstream costs of extract refactors that I detailed earlier can be avoided.

### Changing how we teach TDD

It took me the better part of four years to understand my frustrations with TDD well enough to articulate this post. After plenty of time wandering the wilderness and mulling over these issues, I can say I finally find TDD to be an entirely productive, happy exercise. TDD isn't worth the time investment for every endeavor, but it's an effective tool for confronting the anxiety & perceived complexity one faces when building a hopefully long-lived system.

My goal in sharing this with you is that we begin teaching others that *this* is what test-driven development is all about. Novices have little to gain by being put through the useless pain that results from the simplistic assumptions of classical TDD. Let's find ways to teach a more valuable TDD workflow that gives students an immediately valuable tool for breaking down confusingly large problems into manageably small ones.

<!--

The problems tackled by most code katas don't resemble real systems in two obvious ways: they give the student an algorithmic problem to solve and they're small enough to fit inside a single unit of functionality without becoming a mess. Part of this is a result of the obvious limitations of an hour-long exercise, but I suspect the real reason is that most TDD evangelists pray at the alter of the algorithm.

## The Church of Algorithms

The root of the problem is the same thing that plagues both computer science academia and job interviews: our egos trick us into believing that writing software is a **serious undertaking** to implement intrinsically complex *algorithms* and/or *business logic*. In reality, however, most of the world's software is only incidentally complex: our code *does many things*, but few of those things are nontrivially hard.

Logical complexity comes across as intellectually impressive, so programmers tend to over-emphasize its importance. I can count on one hand the number of complex algorithms I've had to carefully think about, implement, and analyze over the course of my career. And yet, everything about the software world seems focused on these rare feats: college curricula are generally obsessed with algorithms, software jobs are distributed based on candidates' ability to implement algorithms on whiteboards, and programming language designers prioritize logical expressiveness over code organization.

Incidental complexity is a lot less sexy, by comparison. That an application has to perform umpteen unrelated tasks in a certain order whenever a user clicks a button sounds more like an administrative task than an intellectual one. Nevertheless, this accurately describes the code I write every day. The single most important skill for managing incidental complexity in software is **reductionism**: how to successfully break a large task into ever-smaller ones. After all, the major risk posed by incidental complexity is that some day the mess will grow so large that it will cease to be comprehensible.

-->
