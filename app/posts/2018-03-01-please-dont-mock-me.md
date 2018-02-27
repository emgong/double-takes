---
title: "Please don't mock me"
subtitle: "and other test double advice"
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
video:
  url: "https://player.vimeo.com/video/257056050"
  type: "vimeo"
reddit: false
---

The [video above](https://vimeo.com/testdouble/please-dont-mock-me) was recorded
at the inaugural [Assert.js 2018](https://www.assertjs.com) conference in San
Antonio, Texas.

If you've ever been frustrated with how a test faked out a network request,
mocked something out, or otherwise kept passing while production burned, then
this talk is for you. In it, I do my best to boil down nearly a decade of
practicing & teaching test-driven development with JavaScript to summarize the
Do's and Don'ts of faking things out in your tests.

By watching this talk, you'll learn about nine common abuses and misuses of
mocks, and one workflow that puts them to productive use—each explained
at a level of detail you probably haven't seen elsewhere. While you're at it,
you'll also get a pretty good handle on how to use our
[testdouble.js](https://github.com/testdouble/testdouble.js) library, as well.

If you enjoy the talk, please share it with your friends and colleagues! And if
you know a team that could use additional developers and is looking to improve
its JavaScript craft, we'd [love to hear from
you](https://testdouble.com/contact).

## Transcript

The transcript of the presentation follows:

<pre class="transcript">
[00:00] (applause)
[00:03] - Hello. Alright, let's get rolling.
[00:07] The title of this presentation is
[00:08] "Please Don't Mock Me."
[00:09] That's what my face looked like seven years ago.
[00:12] I go by my last name Searls on most internet things.
[00:16] If you'd like my contact info,
[00:17] you could npm install me.
[00:19] (laughter)
[00:21] I am the creator and the current maintainer
[00:24] of the world's second most popular
[00:25] JavaScript mocking library,
[00:27] if you don't count Jest's mocks or Jasmine spies.
[00:31] Here's a download chart.
[00:33] That's sinon.js, the most popular,
[00:35] and that's us down there.
[00:36] (laughter)
[00:37] This was a really important day.
[00:40] We finally caught up last month,
[00:41] but then npm turned the servers back on.
[00:44] (laughter)
[00:46] So we're fighting. (laughter)
[00:48] You can help boost our numbers
[00:50] by installing testdouble.
[00:51] That's the name of the library today.
[00:54] and playing with it.
[00:55] We're gonna see a bunch of examples of it today.
[00:56] And the reason I'm here is to tell you
[00:58] that the popularity of a mocking library doesn't matter
[01:01] (chuckles)
[01:02] And of course you should respond by saying,
[01:04] "You're just saying that because your thing's not popular."
[01:06] (laughter)
[01:07] And that's probably true. (laughter)
[01:09] And I'm rationalizing a bit here.
[01:13] But really the reason that I'm saying that
[01:16] is because literally nobody knows how to use mocks.
[01:19] And that's shocking.
[01:21] I probably shouldn't say that.
[01:22] I should say figuratively nobody knows how to use mocks.
[01:26] And the reason kind of comes down to this Venn diagram.
[01:30] Because there is a group of people
[01:31] who can explain how to best mock things,
[01:34] and then there's another group
[01:35] who always mocks things consistently.
[01:37] But unfortunately, there's a much larger universe
[01:40] of people who use mocking libraries.
[01:42] And I wasn't aware of this,
[01:44] because when we designed testdouble.js,
[01:45] it was really just targeting the intersection
[01:47] of people who know how to use --
[01:49] fake things well in their tests.
[01:52] And it's a small group of people.
[01:53] So just becoming more popular
[01:55] doesn't actually solve any problems.
[01:57] So instead our goal, in both writing the library
[02:01] and its messages and its opinionated documentation,
[02:03] as well as this conversation itself,
[02:05] is to grow the intersection of people
[02:07] who know how to use mock objects well,
[02:08] so that they can write better designed code
[02:10] and better designed tests.
[02:12] But before we dig in, we need to define a few terms.
[02:14] First, subject or subject under test.
[02:17] Whenever I say this, imagine your performing an experiment
[02:20] and this is your test subject.
[02:22] The thing you're testing.
[02:24] Dependency I'm gonna use to define anything
[02:26] that your subject relies upon to get its job done,
[02:30] usually it's another module that it requires.
[02:32] Unit Test. This is a loosey goosey term
[02:35] that has lots of definitions,
[02:36] but for today, we're just going to say
[02:38] that a unit test is anything that exercises
[02:40] a private API by invoking a method,
[02:43] whether or not it calls through
[02:44] to its real dependencies or not.
[02:46] Test double is a catch-all term
[02:49] that just means fake thing that's used in your test.
[02:51] It's meant to evoke the image of a stunt double
[02:53] like for the purpose of a test instead of a movie.
[02:56] So whether you call them stubs or spies or mocks or fakes,
[02:59] for the purpose of this conversation,
[03:00] it doesn't really matter.
[03:01] Also, oddly enough, I come from a company called Test Double
[03:05] We are a consultancy.
[03:06] We pair with teams that are probably just like your team,
[03:10] if you're looking for extra software developers.
[03:11] We'll deploy, work with you, get stuff done.
[03:14] But also with any eye to, you know, making things better.
[03:16] You can learn more about us at our website.
[03:18] And part of the reason I like
[03:21] that we named the company Test Double
[03:22] is that something about mocking is an evergreen problem,
[03:25] because it sits at this intersection
[03:27] of communication, design, technology, testing.
[03:31] All of these different concerns,
[03:32] they need to be sorted out among every single different team
[03:35] and so it's never like it's gonna truly be solved.
[03:37] It's something we can keep on working and getting better at.
[03:40] Of course, I did not think very hard
[03:42] about creating a library and a company with the same name
[03:44] and the brand confusion that would result.
[03:46] So I've had a few people stop me and ask,
[03:48] "Do I really have 30 full-time employees
[03:51] "who just work on a mocking library?"
[03:52] And an unpopular one at that.
[03:54] The answer is no.
[03:57] We're consultants.
[03:59] And there's gonna be lots and lots of code examples
[04:01] in this talk today, but there's no test at the end.
[04:03] They're just here for illustrative purposes.
[04:06] I don't expect everyone to follow
[04:08] every single curly brace and semi-colon.
[04:10] Also, there's no semi-colons because I use standard.
[04:13] (laughter)
[04:15] And I'm also here --
[04:16] If you're a pedant like me, I'm going to be
[04:18] very lazily using the word mock
[04:20] for situations that like mock isn't technically
[04:23] the correct word if you're into jargon.
[04:25] It's just monosyllabic and popular.
[04:27] So I'm gonna be saying mock a whole lot.
[04:29] Alright, this presentation has four parts.
[04:31] The first part is obvious abuses of mock objects.
[04:34] Then we're gonna move into the slightly less obvious abuses.
[04:37] Then we're gonna talk about rational use cases
[04:39] for mocking stuff but nevertheless dubious.
[04:42] And then finally, the only real good use
[04:45] that I found after a decade of doing this.
[04:47] And so let's just start off,
[04:49] top to bottom, with the obvious abuses.
[04:52] And talk about partial mocks.
[04:54] So let's say that you run a park ticket kiosk,
[04:57] and people tap on the screen
[04:59] so that they could order tickets.
[05:00] And say that it's a 12 year old who calls.
[05:03] We call through to our inventory
[05:05] to ensure that we have child tickets
[05:06] available before we sell them.
[05:08] If the person had said they were 13,
[05:09] we'd call back to the inventory
[05:10] to make sure we have adult tickets.
[05:12] And then, either way, regardless of the age you type in,
[05:14] we want to try to upsell them to Express Passes.
[05:17] And so we ensure that we have those available.
[05:18] The logic for this might look
[05:20] like something like this as a function.
[05:22] If they're less than 13, we'd call the child ticket function
[05:24] If it's over, call the adult.
[05:26] And then if the express modules turned on,
[05:28] we'd call that.
[05:30] And then the rest of your purchasing flow.
[05:32] Now how to test this, well you'd probably think
[05:34] I'll create a kiosk test module.
[05:37] I'll invoke it just like I always would.
[05:39] Then I've got this call to inventory,
[05:41] but this method doesn't return anything.
[05:43] It doesn't have any other measurable side effect,
[05:46] and so what I'll do is I'll mock it out.
[05:47] And then I'll just verify that
[05:49] the call took place how I expected.
[05:50] You could do that in a test like this.
[05:52] You could replace that method out of the inventory,
[05:54] and then have the test just pass in
[05:57] 12 year old and then verify
[05:59] that the ensureChildTicket was called one time.
[06:02] To do the adult code path,
[06:04] you would just do the basic same thing,
[06:05] punch a hole in reality.
[06:07] While you're there, you could make sure
[06:09] that you don't call the adult ticket
[06:11] during the child code path,
[06:12] and then everything else is copy paste,
[06:14] but with changed values.
[06:15] Change the age, and make sure it's calling adult
[06:17] instead of child, and so forth.
[06:18] Pretty perfunctory.
[06:20] You run the test.
[06:21] The test passes.
[06:22] Everything is great.
[06:23] Problem is, time passes,
[06:25] and as time passes, you get a phone call,
[06:28] because the build is broken.
[06:29] Your test is failing.
[06:31] So you run the test again,
[06:32] and sure enough, it's failing,
[06:33] and it's failing in a weird way,
[06:34] where the child code path is calling
[06:36] the adult ticket checker thing,
[06:38] and the adult one is calling it twice.
[06:40] So you don't know what's going on,
[06:42] you open up the code,
[06:43] and you look and try to understand it,
[06:44] and you realize the only other
[06:46] potential cause for this is
[06:49] this call to ensure Express Pass.
[06:51] So you open up that inventory.js,
[06:53] but remember we faked out two of these functions,
[06:55] but not all of them.
[06:57] And so this ensure Express Pass is still the real thing,
[07:00] and it looks like somebody changed it
[07:01] to make sure that they don't try to upsell the Express Pass
[07:03] if the adult one's not available.
[07:05] And so like you can't really --
[07:06] who's to blame in this case, right?
[07:08] You can't really blame the person maintaining this
[07:09] for having not anticipated somebody would have
[07:12] a half-real, half-fake inventory
[07:13] floating around their tests.
[07:15] And so what do we do, right,
[07:18] when we hit this situation.
[07:19] Well, one thing you can do, that's just a quick fix,
[07:22] is to also just punch a hole
[07:23] in that ensure Express Pass thing,
[07:25] and doing nothing more than that will make this test pass,
[07:28] but it doesn't quite feel right.
[07:30] Sort of like the advice is when your ship is sinking
[07:32] to just keep poking holes until it stops.
[07:34] (audience laughs)
[07:35] Something is wrong fundamentally with this design,
[07:39] and the problem is, it's only superficially simple.
[07:42] It feels simple because the text in that test
[07:44] is only concerned with what we care about,
[07:46] but it's not actually forming a good experimental control.
[07:49] So instead, I'd knock all that out,
[07:51] replace the whole inventory module,
[07:53] and then require the thing that I depend on.
[07:55] That way I know that it's not going
[07:57] to change for nonsensical reasons.
[07:59] So in general, rule of thumb,
[08:01] if your dependency is real,
[08:03] and you're calling a thing with the test,
[08:05] it's gonna be really easy,
[08:06] 'cause then we're invoking it just like we always would.
[08:08] If the dependencies are fake,
[08:10] then it's still pretty straightforward,
[08:12] because mocking libraries are pretty sophisticated.
[08:14] But if you have a dependency
[08:15] that's simultaneously real and fake,
[08:17] that's when you start to get feedback
[08:18] like what's being tested,
[08:20] or what's the value of the test here.
[08:21] It's just a bad time, don't do it.
[08:23] There's a special sub-type of partial mocking,
[08:26] called mocking the subject,
[08:27] and long story short, I'm just exhorting people
[08:30] please don't fake parts of the thing that's being tested.
[08:34] And like, you should laugh, and be like that's funny.
[08:36] Why would you fake out the thing that you're testing?
[08:37] That doesn't make any sense.
[08:38] But people do it so much
[08:40] that I've had to name a pattern after it
[08:42] called contaminated test subjects.
[08:44] And I get a lot of issues opened about this.
[08:45] Typically, the report, or rhetoric, that somebody has to me
[08:49] to say I've got a good reason for this is.
[08:51] Oh this module is so huge
[08:54] that I've gotta fake out this thing and this thing
[08:55] in order to test this other thing.
[08:57] But it's sort of like, well,
[08:58] if you're thing is too long,
[08:59] poking holes in it all over isn't gonna make it shorter.
[09:02] Now you just have two problems.
[09:04] You've got a big object that nobody understands,
[09:06] and tests of it that nobody trusts.
[09:08] So I don't have anything more to say here.
[09:10] Just don't do that.
[09:11] A third obvious abuse of mock out tests.
[09:14] Replacing some, but not all, of your dependencies.
[09:17] Some people use the term overmocking
[09:21] as if mocking is a thing like an affordance to be moderated.
[09:24] It makes me think that there's
[09:26] like this invisible mockometer or something.
[09:28] And as you mock stuff, it starts to fill up,
[09:32] but be careful, because it might blow up.
[09:33] And now you've overmocked,
[09:34] 'cause you crossed this invisible threshold.
[09:36] It just makes no sense to me,
[09:39] and to explain why, we're gonna take an example.
[09:41] Say that you handle seat reservations,
[09:43] and so you're pair programming,
[09:45] and in your set-up, you think
[09:47] for this thing that requests seats,
[09:49] I need a seat map, something to price the seats,
[09:51] to tell whether they're vacant,
[09:53] and then finally to make the booking request.
[09:55] And so, that's what our set-up looks like,
[09:57] and I imagine you have different test cases,
[10:00] like the seat's open or taken or expensive and yada yada.
[10:03] And so because you're pairing
[10:04] you gotta normalize on approach,
[10:06] and the person on the right prefers writing
[10:08] isolated uni-tests that mock out all of their dependencies.
[10:10] The person on the left just wants maximally realistic tests
[10:13] to make sure that things work,
[10:14] and wants to avoid mocking.
[10:15] And since you're pairing, what do you do?
[10:17] You compromise,
[10:18] and so you just flip a coin, and then you just
[10:19] mock out half the things, instead of all of them.
[10:21] (audience laughs)
[10:23] I get it. That's not a laugh line.
[10:24] That happens all of the time.
[10:26] But you know, you check your mockometer,
[10:28] on this whole overmocking ideology,
[10:30] and you're only at 47 percent.
[10:31] Looks okay. (audience laughs)
[10:34] It just snuck in there.
[10:37] Time passes, and you get a call again,
[10:39] 'cause the test is failing.
[10:41] What's happening here is that
[10:42] this request seat function that's the thing under test,
[10:45] is calling a map to get a seat back.
[10:47] Normally it gets that seat,
[10:48] but it's not anymore because the format of the string
[10:51] is now, instead of 23A, it's 23-A.
[10:54] Nobody called us, so our test started failing.
[10:56] Now, that person on the right
[10:57] who prefers to isolate their subject might say,
[10:59] "This failure had nothing to do with the subject."
[11:01] And she'd be right.
[11:02] 'Cause if you look at where seat number is here,
[11:04] it's just simply passed to this other thing.
[11:06] There's no logic or string stuff here.
[11:08] And it's the dependency that should be dealing with that.
[11:11] This test shouldn't necessarily have broken.
[11:13] So she fixes it, per se, by going into that require,
[11:16] and then just knocking it out with a fake,
[11:18] and updating the test, and getting it's passing again.
[11:20] Now more time passes,
[11:22] but this time production is broken.
[11:24] And what's happening in this case is that
[11:26] book seat dependency that would pass the itinerary,
[11:28] the seat, the price tier to actually make the booking.
[11:31] That's faked out, and it turns out that the person
[11:34] who maintains that transposed the second and third argument,
[11:37] and now it's price and then seat in that call order,
[11:40] but again, nobody called us.
[11:42] And this time, our test is still passing,
[11:43] because the test didn't enforce
[11:45] the errity of that particular method.
[11:47] And so now production blew up
[11:49] because no test was there to catch it.
[11:51] And of course now the developer on the left
[11:52] who likes to have tests be as realistic as possible,
[11:55] will say, "Well, this wouldn't have happened
[11:56] "if we hadn't mocked book seat."
[11:58] And he's right, too.
[11:59] So if we look at this here,
[12:01] sure enough we're calling book seat
[12:02] with the incorrect argument order.
[12:06] There it is right there.
[12:08] And he's upset, so he goes in
[12:09] and looks at where we've mocked out book seat,
[12:11] and replaces it with the real thing.
[12:13] I'm pretty sure this isn't what people mean
[12:17] when they say ping-pong pairing,
[12:19] but it's the kind of passive aggressive back and forth
[12:23] that I see in code bases all the time,
[12:25] when people can't agree on a common approach
[12:27] to known situations.
[12:29] The funny thing about it is that tests are supposed to fail.
[12:34] If a test never, ever fails
[12:35] in the thousands of times that you run it,
[12:37] that test has told you effectively nothing.
[12:39] So we should plan for that failure
[12:42] by designing how things should fail.
[12:45] Like take a wired unit test, for example.
[12:47] This one calls for all of its dependencies.
[12:49] Nothing is mocked.
[12:50] Our mockometer readings are safe.
[12:52] And you ask when it should fail,
[12:55] well, the test should fail whenever
[12:56] its behavior or its dependencies' behavior changes,
[12:59] and as a result of that, we need to be careful
[13:02] and cognizant of the amount of redundant coverage
[13:05] across all of our tests to reduce the cost of change.
[13:08] For example, if one of those dependencies is required
[13:10] by 35 other things and then you need to change it,
[13:12] now you've got 35 broken tests.
[13:14] That's kind of a pain.
[13:15] Now in an isolated unit test,
[13:17] you have the opposite situation,
[13:18] where all of your dependencies are mocked out,
[13:20] and it's 100 percent mocked out,
[13:22] so people are flipping out 'cause it's so overmocked.
[13:24] Readings are off the charts.
[13:26] And you ask, when should it fail?
[13:27] Well that test in particular is gonna fail
[13:29] when the dependencies' protocol changes.
[13:31] When the contract or the relationship
[13:32] between the caller changes.
[13:34] And so, to be safe, you should create
[13:37] some kind of integration test that just ensures
[13:39] that everything's plugged in together correctly.
[13:41] That's typically all you need, but you do need it.
[13:43] But what about this test,
[13:44] where things are half real and half fake.
[13:46] Well, from the overmocking ideology perspective,
[13:50] it's safe, it looks fine.
[13:52] But you ask, when should it fail,
[13:54] and the answer is anything could change and break this test.
[13:58] And so therefore, we should not write tests like this.
[14:01] (audience laughs)
[14:01] So please don't do this.
[14:03] So instead of critiquing how much somebody is mocking,
[14:06] critique how mocks are being used and for what purpose,
[14:08] and start to get into the actual strategy behind a test.
[14:12] The common thread between all these obvious abuses
[14:14] is that it's clear people tend to --
[14:17] We have an intrinsic default setting
[14:19] to value maximal realness over experimental control.
[14:23] I really like this quote.
[14:25] "Instead of treating realness as a virtue to be maximized,
[14:29] "we should clarify what our test is trying to prove
[14:31] "and then use all of our tools, mocks included,
[14:34] "to ensure we have sufficient experimental control."
[14:37] Unfortunately, that quote was me, just now.
[14:39] (audience laughs)
[14:41] I wish somebody had told me this years ago.
[14:44] So let's move on to the less obvious abuses.
[14:46] And mocking out third party dependencies.
[14:49] This is a frequent request on our --
[14:54] GitHub issues.
[14:55] So let's say you depend on this third party dependency
[14:57] in your application called awesome-lib.
[14:59] And it's so awesome, that references to it
[15:01] have leaked all throughout your code base.
[15:03] And the usage of it is a little bit strange though.
[15:06] First, you call it.
[15:07] It takes in the config file,
[15:09] which you'll read from disc.
[15:10] And then it returns an instance with this optimize method
[15:12] and a call back, and then you get these
[15:14] cool interpreter hints that make your code go fast, I guess.
[15:17] Problem is, that's a really weird usage of the library,
[15:21] and so it's really hard to mock out.
[15:23] Awesome lib, it's really painful.
[15:24] Here you can see, we have to replace the whole file system.
[15:27] And then we replace the module itself.
[15:29] Then we have to create an instance that the lib will return,
[15:33] and then we have to do all this stubbing.
[15:34] And we say, like oh, well
[15:35] when the file system has this path, it gets this config.
[15:38] When that config is passed to awesome lib,
[15:39] it returns that instance, and then finally,
[15:41] when we call that optimize method on the instance,
[15:42] then we get a call back trigger that passes back the hint.
[15:46] That's a lot of work.
[15:47] And it's easy to look at that,
[15:50] 'cause it's a lot of test set-up,
[15:51] and it says "td" everywhere.
[15:53] It's easy to look at that and blame the mocking library,
[15:55] but really the root cause is the design of the code.
[15:58] So, hard to mock code is hard to use code, typically,
[16:01] but because we're staring at the test,
[16:02] we tend to blame the test.
[16:05] So that ping just sort of kind of
[16:06] festers throughout our code base.
[16:08] We got a lot of messiness in our code,
[16:09] but also a lot of duplication in our tests.
[16:11] And so maybe this'll save us,
[16:13] but there's been an announcement
[16:14] that awesome lib 2 is coming out,
[16:16] and so you're excited, like maybe this will make it easier.
[16:18] But of course, all they did was
[16:19] change the call backs to promises.
[16:21] (audience laughs)
[16:23] So you gotta update all those references.
[16:25] And now, you like check it out.
[16:27] Instead of stubbing returns and callbacks,
[16:28] you gotta change those to resolve.
[16:30] And then you gotta do it 18 different places,
[16:32] which is frustrating.
[16:33] And assault on wounds, HackerNews calls,
[16:36] and nobody uses awesome-lib anymore.
[16:39] Instead, everyone uses mindblow now.
[16:42] And so, your team goes from frustrated to angry,
[16:46] and just watching the churn of these third dependencies
[16:49] go through your system.
[16:50] So TLDR, if something is hard to mock
[16:54] and you own that thing, it's a private module
[16:56] with its on API that you can change,
[16:58] the remedy is change it.
[17:00] That test has provided you with valuable feedback,
[17:02] saying the design of this thing's hard to use.
[17:05] But if you're mocking a third party thing,
[17:06] and it's painful to mock,
[17:09] well what do you do then?
[17:11] Send a pull request.
[17:12] You do nothing.
[17:13] It's just useless pain,
[17:15] and useless pain, if everyone here cares about testing,
[17:18] you came to a conference just about JavaScript testing.
[17:20] If your team is suffering a lot of useless pain
[17:23] in their testing workflow,
[17:24] other people are gonna notice.
[17:26] That's money going out the window,
[17:27] and you're gonna lose credibility
[17:28] and political capital to keep on testing.
[17:31] So we should try to minimize it.
[17:32] So instead of mocking out third party dependencies,
[17:35] I encourage people to wrap them instead
[17:37] in little custom modules that you do own.
[17:40] This is a module that wraps awesome-lib.
[17:43] It kind of tucks under a rug almost
[17:46] all of the complexity and how to call it.
[17:49] Instead, you get this simple little call back API.
[17:52] And as you think, you realize now you have breathing room
[17:54] to consider how we use this thing.
[17:56] You realize we could probably cache that file read,
[17:59] 'cause there's just a single place that's using this,
[18:01] but we crammed it in in the interest of terseness
[18:03] as we copied that third party reference everywhere.
[18:06] Or maybe it's got certain errors we understand
[18:09] that we could handle or at least translate
[18:10] into something more domain specific.
[18:12] The tests obviously get a lot easier,
[18:14] because we're gonna depend on that wrapper
[18:16] and mock that out.
[18:18] So we can delete all this,
[18:19] and then this stuff gets a little bit simpler, too.
[18:21] And just creates a lot more space and breathing room
[18:25] to consider (audience laughs) the design
[18:27] of what you actually care about which is the subject,
[18:30] instead of all this cognitive energy going to test set-up.
[18:33] You don't need to worry about
[18:35] writing unit tests of your wrappers.
[18:37] Trust the framework.
[18:38] They probably work.
[18:39] You definitely don't want them to be isolation tests,
[18:41] because then if they are hard to mock,
[18:43] you're gonna have that useless pain again,
[18:45] which is just money out the window.
[18:46] Another thing that I see people do
[18:49] that isn't obviously a problem,
[18:51] but usually turns out to be one,
[18:52] is when they tangle up logic
[18:54] with their delegation to dependencies.
[18:56] And so, let's take an example.
[18:58] Let's say you own a fencing studio,
[18:59] and you rent out swords.
[19:00] But you might want to be able to ask,
[19:03] "Hey, how many swords do we expect
[19:04] "to have in stock next Tuesday?"
[19:06] And you could write a function for that.
[19:07] So you pass in a date.
[19:09] You call something to fetch rentals,
[19:11] and that gets you a call back with the rentals
[19:12] that are currently outstanding.
[19:13] And then you need to filter them down,
[19:15] so you take the duration of days,
[19:18] and get it into milliseconds,
[19:19] and then you add that to the start time
[19:21] to figure out when they're due.
[19:23] And then if they're due before the given date,
[19:24] you can expect the rental to be due at that point.
[19:28] And then you just pluck the swords out of that.
[19:29] In addition, you have current standing inventory,
[19:32] so you call your inventory module,
[19:34] which gives you a call back,
[19:35] and you just concatenate that inventory
[19:38] with the swords that you expect to be back.
[19:39] So it's pretty straightforward.
[19:40] We can run a test of it.
[19:42] Start by creating a rental object.
[19:44] It has like -- we'll stub fetch rentals
[19:47] to return a rental to us.
[19:49] We'll stub the current inventory
[19:50] to return a leased sword to us.
[19:52] We'll call it with the correct date so they all match up,
[19:55] and then we'll just assert
[19:56] that we get those two swords back from the function.
[19:58] This test passes.
[19:59] That's great.
[20:01] So time marches on yet again.
[20:03] This time, your test didn't break,
[20:04] but rather somebody points out,
[20:06] "Hey, this current inventory thing with the call back
[20:08] "can make this faster now,
[20:09] because we have a new inventory cache,
[20:11] which is synchronous."
[20:13] And so she jumps into the code,
[20:14] and deletes that call back method.
[20:15] Instead it just calls the synchronous one,
[20:17] out those things.
[20:18] And things are a little bit cleaner now,
[20:19] a little tidier, and definitely a lot faster.
[20:22] But of course, it broke the test.
[20:23] And that's really frustrating.
[20:25] You look at the test.
[20:26] Here it is, the test is specifying
[20:27] that it relies on current inventory.
[20:30] And some guy on the team shows up,
[20:33] "Oh, this test is coupled to the implementation,
[20:36] "and that is very bad, and we should feel bad."
[20:38] Those scare quotes are mine,
[20:39] because I think it misdiagnoses
[20:42] the real root cause problem here,
[20:44] which is that we have this naive assumption
[20:47] that tests exist to make change safe,
[20:49] but we rarely really inspect in our minds.
[20:53] What kind of tests make
[20:55] what kind of change what kind of safe?
[20:58] And the answer is different depending
[20:59] on the type of test that we're running.
[21:01] So let's dig in.
[21:02] First, if you're running a test of something
[21:04] that has no dependencies, no mocking at all,
[21:06] it probably specifies logic, ideally a pure function.
[21:09] And if it does, that means if the logic's rules change,
[21:12] then the test needs to change.
[21:14] So take for example, you convert a for loop to a four each,
[21:17] that calls on duration.
[21:18] That's just a refactor.
[21:19] It's probably not gonna change the behavior.
[21:21] The test should keep passing.
[21:22] But if we're changing the duration
[21:24] to some duration plus a one day grace period,
[21:26] you should absolutely expect that test to fail,
[21:28] because you just changed the rules of the game,
[21:30] and the test's job was to specify those rules.
[21:33] Consider the case of writing a test of something
[21:35] with mocked out dependencies,
[21:36] the test's job there isn't to specify logic,
[21:40] but it's to specify relationships.
[21:41] How is this subject going to orchestrate this work
[21:45] across these three things that actually go and do it?
[21:47] And so when the contract between it
[21:49] and the things it depends on changes,
[21:51] that's when the test needs to change.
[21:53] So if this duration grace period thing happens,
[21:55] that test should keep on passing,
[21:57] because that should be implemented
[21:58] in something responsible for actually doing the work.
[22:00] But if we start calling inventory cache
[22:03] instead of current inventory,
[22:04] of course you should expect that to change,
[22:06] because the relationships in the contracts are different.
[22:08] So where things fly off the rails is when somebody asks
[22:11] what if the subject has both mocked dependencies and logic?
[22:15] Well, to graph out our current situation,
[22:18] we have this sword stock module,
[22:19] which depends on current inventory and fetch rentals,
[22:21] but it also has this third responsibility
[22:24] that it just brings in house,
[22:25] which is to calculate when swords are due.
[22:27] And so, this first one specifies a relationship.
[22:30] The second one, it's specifying relationship.
[22:32] But the third responsibility,
[22:34] it's implementing this logic itself.
[22:36] And you can see this really clearly in your test, right?
[22:39] This stuff's focused on relationships.
[22:41] This stuff's focused on logic.
[22:42] Same thing in the code.
[22:44] This stuff, relationships.
[22:46] This a big old chunk of logic.
[22:48] And what it represents is a sense
[22:50] mixed levels of abstraction,
[22:52] where two thirds of our thing is concerned about delegating,
[22:54] and one third is concerned with logic,
[22:57] which is a classical design smell.
[22:59] And we just got to find out about it,
[23:00] because we were mocking.
[23:02] So what I'd recommend you do,
[23:03] spin off that third responsibility
[23:05] so that sword stock's only job
[23:08] is to be a delegator of responsibility to other things,
[23:11] and trust me, you'll feel better.
[23:12] And on top of it, swords due taking in a date and rentals
[23:15] and returning swords, is now a pure function,
[23:18] and your intuition will start to agree with you
[23:20] as to when it should change, and when it shouldn't.
[23:22] And what kind of safety you're gonna get from it.
[23:24] So in short, if a test specifies logic,
[23:27] it makes me feel great, 'cause there's nothing easier
[23:29] to test than passing in a couple values
[23:31] and getting one back.
[23:32] If a test specifies relationships,
[23:34] I feel good because I've got some sort of evidence
[23:36] that the design is being validated,
[23:39] that thing's are easy and simple to use,
[23:40] but if a test specifies both,
[23:42] I feel no safety whatsoever from it.
[23:46] I'm just bracing for the pain of a hard to maintain test.
[23:49] So if you struggle with this, or if your team does,
[23:52] and you need some slogan to tape to a wall.
[23:55] Have it be this one.
[23:56] That functions should do or delegate, but never both.
[24:00] I think a lot of our designs could improve
[24:02] if we followed that.
[24:03] Another less obvious abuse is
[24:06] when people mock data providers
[24:08] at intermediate levels in the stack.
[24:10] So let's say, hypothetically,
[24:12] that we invoice travel expenses,
[24:13] and we have an invoicing app that calls via HTTP
[24:16] to an expense system, we get some JSON back.
[24:18] And so our subject under test sends these invoices,
[24:21] the system's way over there though,
[24:23] because we depend on building invoices,
[24:25] which depends on filtering approved expenses,
[24:27] which depends on grouping them by purchase order,
[24:30] which depends on loading the expenses,
[24:31] which depends on http.get,
[24:33] which finally calls through to the other system,
[24:35] and then of course we get all the data
[24:36] transformed all the way back up the stack.
[24:38] And so, when you have this layered of an architecture,
[24:41] it's reasonable to ask, "Okay, so what layer
[24:42] "am I supposed to mock when I write my test?"
[24:44] Well, it depends.
[24:46] If what you're writing is
[24:47] an isolated unit test of said invoice,
[24:49] then you always want to mock out
[24:50] the direct dependency because it's gonna specify
[24:53] the contract that you have with it,
[24:54] and the test data that you need
[24:55] is gonna be absolutely minimal to just exercise the behavior
[24:58] and the subject that you're concerned with.
[25:00] But if you're trying to get the regression safety
[25:02] and make sure that the thing works,
[25:03] then you either want to keep everything realistic
[25:06] or stay as far away as possible.
[25:08] Ideally, out at the http layer,
[25:10] because those fixtures that you save off,
[25:12] can have some kind of meaning later on if anything changes,
[25:15] and you can use that to negotiate
[25:16] with whoever's writing the expense system.
[25:18] What you don't want to do is just pick some arbitrary depth,
[25:22] like this group by PO thing and mock that out.
[25:25] Maybe it's the nearest thing, or maybe it feels convenient,
[25:27] but it's gonna fail for reasons
[25:29] that have nothing to do with send subject, send invoice.
[25:32] And the data at that layer is this internal structure
[25:36] that doesn't mean anything outside of our system.
[25:39] So if the mock layer is a direct dependency
[25:41] and it fails, it's a good thing,
[25:44] because it means that our contract changed,
[25:45] and we need to go and inspect that.
[25:47] If the mocked layer is an external system and it blows up,
[25:50] it's another good failure,
[25:51] because it's the start of a conversation
[25:53] about how this API's contract is changing underneath us.
[25:56] But if you mock out an intermediate layer,
[25:59] again it's another form of useless pain,
[26:01] you learn nothing through the exercise,
[26:02] except that you had to spend half a day fixing the build.
[26:05] The common thread between all these lesser abuses
[26:08] of mock objects is that
[26:10] through un-careful, undisciplined use of mocks
[26:14] we undercut our test's return on investment.
[26:17] Where we're just not clear about
[26:19] what the value of the test is anymore.
[26:22] And if you can't defend the value of your tests --
[26:25] Excuse me, we can't defend the value of our tests
[26:29] if they fail for reasons that don't mean anything,
[26:31] or have to change in ways that we can't anticipate.
[26:35] Unfortunately, that's also me,
[26:36] because there aren't that many quotes about mocks.
[26:40] (audience laughs)
[26:40] Out there, it turns out.
[26:42] Alright, I got my own quote wrong,
[26:45] and how I read it, too.
[26:46] (audience laughs)
[26:47] Alright, so let's move on to the rational uses
[26:50] that are often dubious in my opinion.
[26:54] The first is when you use mocks in tests of existing code.
[26:57] So let's say that you work
[26:58] at an internet of things doorbell start-up.
[27:01] And because you're a start-up, you move fast and loose.
[27:04] You've got a lot of spaghetti code,
[27:05] that you wish you could clean up.
[27:07] But you just won more funding,
[27:09] and so now you're excited.
[27:10] You can finally start writing some unit tests.
[27:12] You've been putting this off forever.
[27:13] And it's been hanging over your head for a long time,
[27:16] but you've got zero test coverage.
[27:18] So you write what you think is gonna be
[27:20] the easiest test that you could ever write.
[27:22] It's just like pass the doorbell
[27:24] to the thing that rings the doorbell
[27:25] and increments like a ding count.
[27:27] Here we go, we require our doorbell.
[27:30] We require the subject that rings it.
[27:32] We create a doorbell.
[27:33] We pass it to the subject,
[27:34] and then we should assert
[27:35] that the doorbell's ding count goes up to one.
[27:38] Great. Couldn't be easier.
[27:39] So we run our test,
[27:40] and of course, it fails.
[27:41] And it says, "Oh by the way,
[27:42] "doorbell requires a door property."
[27:45] Well, okay, we can go in, require a door,
[27:47] create a door, pass it to the doorbell, run our test again.
[27:50] Oh, right, well you can't have a door
[27:52] if you don't have a house.
[27:53] Alright, fine, so (audience laughs)
[27:55] we'll import a house, create a house,
[27:56] pass it to the door, pass to the doorbell,
[27:58] which passes to the subject, and run our test.
[28:00] (mumbles) House requires a paid subscription,
[28:03] and now we're talking about payment processes, databases.
[28:05] This code was not written to be used more than once.
[28:08] It was just used once in production.
[28:10] So it's not very usable.
[28:11] And so we run into this pain of all this test set-up.
[28:13] So a lot of people here will look at this,
[28:16] they'll table flip, they'll delete all that stuff,
[28:17] and they'll just replace it with a mock object.
[28:19] Something fake that they can control
[28:21] for the purpose of just getting a test to run.
[28:23] And they'll set the ding count to zero.
[28:25] They'll tuck it all in.
[28:26] And clearly that smells.
[28:28] And if you're not --
[28:30] If you're mocking smell-o-meter is not finely attune,
[28:34] the nature of this smell is actually really subtle,
[28:37] because every other example that I've shown
[28:39] so far of a mock in a test is replacing
[28:42] a dependency of the subject that does part of the work
[28:44] that the subject delegates to,
[28:46] not a value that passes through it,
[28:48] either an argument or a return value.
[28:50] The reason for that is values
[28:52] carry type information which is useful,
[28:54] but also that they should be really cheap and easy
[28:57] to instantiate free of side effects.
[28:59] So if your values are hard to instantiate,
[29:00] it's easy, just like make 'em better.
[29:03] Don't just punch a hole in it, and mock 'em out.
[29:06] And so nevertheless, you got that test going.
[29:09] You got a little bit of tests coverage.
[29:10] Another I've seen teams do is
[29:12] if they've got a really big, hairy module,
[29:15] they'll want to tackle that first
[29:17] when they start writing tests,
[29:18] and so they want to write a unit test,
[29:19] and if they try to write it symmetrically
[29:21] against the private API of this thing,
[29:23] it tends to just result in a gigantic test
[29:26] that's every bit as unwieldy as the module was,
[29:29] and gets you absolutely no closer
[29:30] to cleaning that huge module up
[29:33] and making the design better.
[29:34] 'Cause if you depend on 15 different things,
[29:37] like whether or not you mock those dependencies out,
[29:40] you're gonna have a ton of test set-up pain.
[29:42] It's gonna be really hard to write that test.
[29:44] And the underlying test smell was obvious --
[29:46] or the smell rather, was obvious
[29:48] before you even started writing the test,
[29:50] which was like this object was too big.
[29:52] And so if you know that the design has problems,
[29:54] what more is a unit test going to tell you,
[29:57] except be painful.
[29:59] So instead, odds are the reason you're writing tests,
[30:02] is like you want to have refactor safety
[30:05] so that you can improve the design of that thing.
[30:07] So if you're looking for safety,
[30:08] you need to get further away
[30:09] from the blast radius of that code,
[30:10] increase your distance.
[30:12] The way that I would do that is
[30:13] I'd consider the module in the context of an application.
[30:16] Like there's other complexities, sure,
[30:17] like maybe there's a router in front of it or something.
[30:20] But go create a test that runs in a separate process,
[30:22] but then invokes the code the same way a real user would
[30:24] by maybe sending a post request.
[30:26] And then you could probably rely on it
[30:30] going and talking to some data store of something.
[30:32] And after you've triggered the behavior
[30:34] that you want to observe,
[30:35] maybe you can interrogate it with additional HTTP requests,
[30:37] or maybe you can go and look at the SQL directly.
[30:40] But this provides a much more reliable way
[30:43] for creating a safety net to go
[30:44] and aggressively refactor that problematic subject.
[30:48] And so integration tests, they're slower.
[30:50] They're finickier.
[30:51] They're a scam, in the sense that
[30:53] if you right only integration tests,
[30:55] your build duration will grow in a super linear rate
[30:58] and eventually become an albatross killing the team.
[31:00] (audience laughs)
[31:01] They do provide refactor safety,
[31:04] so in the short and the medium term,
[31:05] if that's what you need, that's great.
[31:07] And plus, they're more bang for your buck anyway.
[31:09] When you don't have a lot of tests,
[31:11] you'll get a lot of coverage out the gate.
[31:12] Another thing I see people who have existing code
[31:15] that they're trying to get under test
[31:16] and using mock objects,
[31:17] they'll use mocks just as a cudgel
[31:20] to shut up any side effects.
[31:21] So you might see something like this.
[31:22] Init-bell is being knocked out whenever we require init,
[31:26] which is the thing responsible for starting up the app,
[31:28] and somebody might point out,
[31:30] "Hey, why are we faking this?"
[31:31] And turns out, oh well, it dings every doorbell
[31:33] some start-up chime sequence at require-time.
[31:36] Now, that's a smell, right?
[31:38] The root cause is -- a good module design
[31:40] is free of side effects and item potent
[31:42] and you can require the thing over and over again,
[31:44] but because we didn't have any tests,
[31:45] we kind of got into the habit
[31:47] of having all these side effects everywhere,
[31:48] 'cause everything was only required by one thing.
[31:50] So like, again, root cause, write better modules.
[31:54] Don't just knock out reality left and right in your test.
[31:56] So unless you're open to the idea
[31:59] that writing isolated unit tests
[32:01] is going to inform your design,
[32:02] and that you're going to improve your design as a result,
[32:04] don't even bother writing them.
[32:06] Write some other kind of test.
[32:08] Another rational use, but dubious one,
[32:11] that I see a lot is when people use tests
[32:13] to facilitate overly layered architectures.
[32:17] One thing that I've learned in like lots of years
[32:20] of test writing, development testing,
[32:22] is that people who write a lot of tests
[32:24] tend to feel pushed towards making smaller things.
[32:27] So instead of one horse-size duck,
[32:28] we have a hundred duck-size horses,
[32:29] and if you've got a big order.js normally,
[32:33] and you start writing a lot of tests,
[32:34] it wouldn't be surprising at all to find
[32:37] you have an order router controller,
[32:38] and yada yada, lots of small tiny things.
[32:41] But it's really easy, especially up on the stage,
[32:44] to say this big, naughty mess of code is really bad,
[32:47] and maybe it's even provably bad,
[32:49] but it's also important to know that smaller isn't better
[32:52] just by virtue of being smaller.
[32:54] It has to be focused as well.
[32:55] It has to be meaningful.
[32:57] 'Cause like, look at this case.
[32:59] Where we got this whole stack
[33:00] of all these different units.
[33:02] If every single feature that we do
[33:03] has the same six cookie cutter things
[33:05] that we have to create, then all we're really doing
[33:08] is creating that large object over
[33:10] and over again with extra steps.
[33:12] Now there's more files and direction,
[33:14] but we're not actually designing code better.
[33:17] So, you might ask, what's unsolicited
[33:20] code design advice have to do with mocking?
[33:22] Well, if we have a test of one of these layers,
[33:25] and we mock out all the layers beneath it,
[33:27] then what we can do using that tool
[33:30] is create like a skyscraper, infinitely many layers,
[33:32] never having to worry about the fact
[33:34] that if something down at the bottom changes,
[33:36] it'll break everything above us.
[33:38] And so you tend to see teams who use a lot of mock objects
[33:40] create really highly layered architectures.
[33:43] And I get it, right.
[33:45] Because layering feels a lot like abstraction.
[33:49] You're doing a lot of the same motions.
[33:50] You're creating a new file.
[33:51] It's a small thing.
[33:52] It's got a really clear purpose.
[33:53] But it's not actually necessarily the same as
[33:57] thoughtful design of the system.
[34:00] Instead, I'd focus on generalizing the concerns
[34:03] that are common across the features,
[34:05] instead of just creating a checklist
[34:07] of we do these six things for every story in our backlog.
[34:10] So for instance, have a generic router,
[34:12] and controller, and builder, that's very adept
[34:15] and can handle all of the different
[34:16] resources in your application.
[34:17] And then, you know, when you need
[34:20] some custom order behavior,
[34:22] treat the controller like an escape patch,
[34:24] like a main method.
[34:25] So this is just plain old JavaScript
[34:27] that's focused on nothing other than
[34:28] whatever's special about orders,
[34:30] as opposed to just building another stack
[34:32] and increasingly broad application.
[34:34] So yes, make small things,
[34:36] but make sure that they're meaningfully small,
[34:38] and not just arbitrarily small.
[34:39] The last dubious thing that I see people do with mocks
[34:42] is over-reliance on verification
[34:45] or verifying that a particular call took place.
[34:48] And I'm a firm believer that how we write assertions
[34:53] in our tests, especially if we're practicing
[34:55] some kind of test first methodology,
[34:56] will slowly and subtly steer the design of our code.
[35:00] So let's say you run a petting zoo,
[35:02] and you were given a copy of testdouble.js for your birthday
[35:06] (audience laughs) and you're really excited,
[35:08] because you love petting zoo,
[35:10] and you can finally verify every pet.
[35:11] So, you know, somebody pets the sheep,
[35:13] it was pet one time.
[35:15] Somebody pets the llama, pet one time.
[35:16] Sheep again, now we can verify two times.
[35:19] Really exciting.
[35:20] Sorry, nobody pets the crocodile.
[35:21] Sorry, crocodile.
[35:23] But you could write a test for it.
[35:24] And there's a problem in your petting zoo,
[35:26] which is that kids' hands are dirty,
[35:28] and they make the animals dirty,
[35:29] but the pet function doesn't say how dirty,
[35:32] and so we just have to guess,
[35:33] and we clean them daily with a 10 p.m. chron job
[35:36] that hoses down all the llamas.
[35:38] (audience laughs)
[35:39] It's hugely inefficient and wastes water.
[35:43] How did we get here?
[35:44] Well, take a look at this test.
[35:45] So we have a few stubbings where we ask
[35:48] if the kid likes the sheep.
[35:49] Yeah, they like the sheep.
[35:50] We ask if they like the llama.
[35:51] They do.
[35:52] They don't like the crocodile.
[35:54] Pass all that into the subject,
[35:55] and then we verify the sheep was pet,
[35:57] and the llama was pet, but the croc wasn't.
[36:00] And that's a real tidy looking test.
[36:01] And the subject almost writes itself as a result.
[36:04] We have those two dependencies.
[36:05] It takes in the kid and the animals for each of the animals.
[36:08] If the kid likes the animal, we pet the animal, great.
[36:11] Passing test.
[36:12] But nobody, because the mock library
[36:15] made it so easy to verify that call,
[36:17] nobody thought to ask what should pet return.
[36:21] If we didn't have a mocking library,
[36:22] it would have to return something
[36:23] for us to be able to assert it,
[36:25] but we didn't have to, because we faked it out anyway.
[36:27] And it's an important question to ask.
[36:29] And I love this, because it gets
[36:32] the fundamental point about tooling generally,
[36:35] because tools exist to save time
[36:37] by reducing the need for humans to think things,
[36:40] and take action, in order to get a particular job done.
[36:43] And that's fantastic, unless it turns out
[36:45] that those thoughts were actually useful.
[36:47] So I'm always on guard against any tool
[36:50] that can reduce the necessary and useful thoughtfulness
[36:54] as I'm doing my job, and that's one example of it.
[36:57] So I've been critical of snapshot tests
[36:59] because a lot of teams,
[37:00] the median number of tests on a JavaScript project
[37:04] has been and remains zero.
[37:07] And so when you tell people like,
[37:08] "Hey, here's the snapshot testing tool,
[37:10] "and it'll test stuff automatically."
[37:12] People were just, "Sweet, I'll check that box.
[37:15] "And then that means I never have
[37:16] "to worry about testing again."
[37:17] And so, because that's a very obvious form of abuse,
[37:21] I'm critical of snapshot testing tools.
[37:23] That said, if you're a highly functional team
[37:25] and you know this nuanced fuse case,
[37:27] where you're only using it to make sure that
[37:29] your dependencies don't break underneath you.
[37:31] Great, but that's like one percent.
[37:34] 99 percent are just abusing them.
[37:35] And I feel the same way really
[37:38] about most uses of mock objects.
[37:40] Being able to verify calls may end up discouraging
[37:44] a lot of people from writing pure functions
[37:45] when they otherwise would.
[37:46] And pure functions are great
[37:47] 'cause they don't have side effects,
[37:49] and things are more composable.
[37:50] So we should be writing more of 'em.
[37:51] So if you do use mock objects
[37:54] when you're isolating your tests,
[37:55] just be sure to ask, "What should values return?"
[37:59] And I'll always default to assuming
[38:00] that things should return values.
[38:02] Because it just leads to better design.
[38:03] And in this case, when we call pet,
[38:05] and we pass in an animal,
[38:07] what could it return but a dirtier animal,
[38:09] and then we could use that information
[38:10] to figure out when to wash our animals.
[38:12] So taking this same example,
[38:14] let's set these stubbings instead of the verifications.
[38:17] So when we pet the sheep, we get a dirtier sheep,
[38:19] and when we pet the llama, we get a dirtier llama.
[38:21] And then we get a result back now from our subject,
[38:24] so we can actually assert, and we end up
[38:26] with a dirty sheep and a dirty llama and a clean crocodile.
[38:29] So now the change here,
[38:30] first we're gonna get rid of this forEach.
[38:32] Anytime you see forEach anywhere in your code,
[38:35] it means side effect, because it doesn't return anything.
[38:38] So we're gonna change that to a map.
[38:39] So we're trading one array for another.
[38:42] And then in the code path where
[38:43] the kid doesn't like the animal.
[38:45] Excuse me, first in the code path
[38:47] where the kid does like the animal,
[38:48] we'll return whatever pet returns.
[38:49] And else, we'll just return the animal as it was.
[38:53] And now we got that test to pass.
[38:55] So the benefit here is now we know
[38:57] who to wash and when, saving on water.
[38:59] And that's really great.
[39:01] There's just one little problem remaining,
[39:03] which is that when you run this test,
[39:04] you're gonna get this big nasty paragraph
[39:07] that I wrote three years ago,
[39:08] that says, "Hey, yo, you just stubbed and verified
[39:12] "the exact same method call.
[39:13] "That's probably redundant."
[39:15] And so that's a little bit quizzical.
[39:17] So just to explain.
[39:17] We've got all of these verify calls down at the bottom,
[39:20] but they are almost provably unnecessary
[39:22] 'cause we're stubbing the same thing
[39:24] and also asserting the return value.
[39:27] The only way for them to get the dirty sheep
[39:29] is to call that method exactly that way,
[39:32] and a lot of people like a llama at a petting zoo,
[39:35] just can't let of verifying
[39:37] the hell out of every single call.
[39:38] Trust me, you don't need to.
[39:39] Just delete it.
[39:40] In fact, I only generally verify calls
[39:44] to the outside world at this point.
[39:46] So if I'm writing to a log,
[39:47] or if I'm scheduling something
[39:48] in a job queue or something like that,
[39:50] where it doesn't give me any kind of response,
[39:53] or I don't care about the response.
[39:54] Then like invocation verification might be worthwhile,
[39:58] but usually if I'm designing my own private APIs,
[40:00] I always want to be returning values.
[40:01] The common thread between all three of these things
[40:04] is that there's a habit, I think,
[40:06] of neglecting tests' design feedback,
[40:08] when we're using mocks.
[40:10] And the whole purpose of mock objects,
[40:12] the reason they were invented,
[40:13] the reason these patterns exist,
[40:14] is to write isolated unit tests to arrive at better designs.
[40:18] It was not just to fake out the database.
[40:21] So if that's why you use mocks,
[40:22] spoiler alert, you've been doing it wrong.
[40:28] I hate to say that, but like it's
[40:30] really depressing ...
[40:35] how they have been misused.
[40:36] But I'm all done talking about that now.
[40:38] Except to say that when a test inflicts pain,
[40:43] people tend to blame the test,
[40:45] 'cause that's the thing that you're looking at.
[40:46] It's the thing that you feel like it's causing pain.
[40:48] But the root cause is almost always in the code's design,
[40:51] and hard to test code is hard to use code.
[40:53] So we're all done talking about these different abuses.
[40:57] I want to move on to the one good use.
[40:59] Finally the positive, the happy way
[41:02] that I love using mocks.
[41:03] The reason that I maintain a library about it.
[41:05] And it all comes back to this thing I call
[41:08] London-school test-driven development.
[41:10] I use this phrase because it's based on the work
[41:12] of Nat Price and Steve Freeman
[41:14] in their really seminal book
[41:16] "Growing Object-Oriented Software Guided by Tests."
[41:19] It's called London 'cause they're members
[41:21] of the London extreme programming group.
[41:23] Some people call this outside in test-driven development.
[41:26] Some people say test-driven design.
[41:28] I call it discovery testing,
[41:30] because I've changed a few things.
[41:31] It's very important that I brand everything that I do.
[41:35] And what it does is it solves --
[41:38] It helps me deal with the fact
[41:40] that I'm a highly anxious and panicky person.
[41:43] I'm a really, really bad learner, for example.
[41:48] I seem to take every single wrong path
[41:50] before I end up at the right ones.
[41:53] And I gave a whole talk just about this.
[41:56] How we're all different people
[41:57] and how developers can customize work flows
[41:59] to suit their particular traits,
[42:02] called "How to Program," last year.
[42:04] And it's sort of the ideology
[42:06] that undergirds this particular presentation.
[42:09] Because earlier in my career, I was full of fear,
[42:12] like blank page syndrome.
[42:14] I was just afraid that staring at my IDE,
[42:18] that I'd never figure out how
[42:19] to make code happen inside of it.
[42:21] And that fear led to really uncertain designs,
[42:25] big, knotty complex stuff with tons of conditionals
[42:28] and comments and stuff,
[42:30] and as soon as I got anything working,
[42:32] I would just publish it immediately
[42:33] for fear that any future changes would break it.
[42:35] And complete doubt that if anyone asked me,
[42:37] "Hey, could you finish this in a week?"
[42:39] I just had zero confidence that I'd be able to do it.
[42:41] But where I am now is I have a certain ease about myself
[42:45] when I approach development because I have processes
[42:47] that give me incremental progress.
[42:50] I'm gonna show you that in a second.
[42:51] And confidence, because through that process,
[42:54] I've realized that coding isn't nearly as hard
[42:57] as I always thought it was.
[42:58] And doubt, because I'm just really self-loathing individual.
[43:02] But I like to think that I'm doubting
[43:03] about more useful things now than I used to be.
[43:06] So let's say, suppose that you write talks,
[43:08] but it takes you way too long to make all these slides,
[43:11] and so you decide we're gonna automate it.
[43:12] We're gonna take something that takes our notes,
[43:14] and runs it through sentiment analysis,
[43:16] to pair it up with emoji,
[43:17] and then create a keynote file.
[43:20] So we start with the test,
[43:22] and at the beginning of the test,
[43:23] we don't know how we're gonna do this.
[43:25] It seems almost impossibly ambitious.
[43:27] So we just write the code that we wish we had.
[43:30] I wish I had something that could load these notes.
[43:32] I wish I had something that could pair
[43:34] those notes up with emoji and give me slides back.
[43:36] And then I wish I had something that could create
[43:38] a file given those slide objects.
[43:40] Then of course, I've got my subject.
[43:42] And the test can just be a simple.
[43:44] I probably only need one test case.
[43:45] Creates keynotes from notes or something.
[43:48] So I run my test.
[43:49] It errors out, says load notes doesn't exist,
[43:52] but it's just a file.
[43:53] I can create a file.
[43:54] I run my test.
[43:54] And this other file doesn't exist.
[43:56] So I touch it, run my test.
[43:58] This third file doesn't exist.
[43:59] Touch it, run my test.
[44:02] And now my test passed.
[44:03] Now, this is really, really, really tiny steps.
[44:07] It's just plumbing,
[44:07] but to me, it's the difference between
[44:10] getting nothing done through analysis paralysis,
[44:12] and just having incremental forward progress
[44:14] throughout my day kind of being baked into my work flow.
[44:16] Feels like paint-by-number.
[44:18] And you can design work flows that
[44:19] actually give you the messages to tell you what to do next
[44:22] and prompt and guide your actions in a productive way.
[44:26] So here, so far where we're at,
[44:28] you know, we have this entry point.
[44:30] And we think we maybe could break things down
[44:32] into these three units.
[44:34] But let's continue with writing the test itself.
[44:36] So I'll start with some notes.
[44:39] I know that I'm gonna need notes,
[44:40] so I invent right here a note value object,
[44:44] and then I say, "Okay, well."
[44:45] And I call load notes, I'd probably need to pass
[44:47] this string to search for topics.
[44:49] I'll call back with these notes,
[44:50] and then I need some slides,
[44:53] so I invent a slide object.
[44:55] And when I pass my notes to this pair emoji thing,
[44:57] it should give me those slides back.
[44:59] My subject then, I pass in that topic,
[45:02] and probably a file path to save the document,
[45:04] and so I'll verify finally that create file
[45:07] was called with slides and a file path.
[45:09] Run my test, and now, of course,
[45:12] you get a different failure.
[45:14] It says load notes is not a function.
[45:16] This is an artifact of the fact
[45:17] that the default export in node.js
[45:19] is just a plain object.
[45:21] So I can go in and just export a function, instead,
[45:23] and I can see the other two coming.
[45:25] And so I'll go ahead and export functions
[45:27] from those files as well.
[45:28] Run my test again,
[45:30] and now what it says is it expected
[45:32] to be called with an array of this slide
[45:34] and with this file path, but it wasn't called.
[45:38] And so finally, finally after all this work,
[45:40] we get to write some real code.
[45:42] And it turns out though, that writing this code is
[45:44] an exercise in just like obviousness,
[45:48] because we've already thought through
[45:49] literally everything it does.
[45:50] We know that we have these three dependencies.
[45:52] We know that our exported API is
[45:55] gonna have these two arguments.
[45:56] We know that load notes takes topic
[45:58] and then calls back with notes.
[46:00] We know we pass those notes to pair emoji,
[46:02] which gives us slides.
[46:03] We know that the create file method
[46:04] takes slides and a path, and then we're done.
[46:07] So we run our test, test passes, and that's it.
[46:10] And so you might be looking at it
[46:12] and be like that was a lot of talking
[46:14] to write a five line module,
[46:15] and you'd be right.
[46:17] It was a lot of talking, but those five lines --
[46:21] I think they belie the amount
[46:23] of stuff that we just accomplished.
[46:25] Right?
[46:25] We decided pretty clearly through usage
[46:28] what our customers need to provide us
[46:30] to implement this thing.
[46:32] We figured out that if we pass a topic into this thing,
[46:35] we can get some sort of value type back.
[46:37] We also identified a data transformation
[46:39] converting those notes to slides.
[46:41] And finally, we are confident that if we pass slides
[46:43] and the file path to something,
[46:45] we'd be further along in the story
[46:46] of automating this work flow.
[46:48] Job number one, the subject is done.
[46:52] That top layer, even though it's really short,
[46:54] very rarely will I ever have to go back and change it again,
[46:57] unless the requirement significantly changed.
[47:00] Number two, the work has now been broken down.
[47:03] So instead of having in my working memory
[47:05] the entire complexity of my overall system,
[47:07] I have this outside in approach
[47:09] where it's like I've got these three jobs remaining,
[47:11] and I can do them in any order,
[47:12] and they don't have to know about each other,
[47:13] and it's much easier to understand and think about.
[47:16] And third, all these contracts are clearly defined.
[47:19] I know what goes in and out of each of these things,
[47:22] so I have no risk of squirreling away
[47:23] and building a bunch of objects
[47:24] with complexity that ends up not being necessary
[47:27] or maybe an API that doesn't fit quite right
[47:30] with the thing that ultimately needs it.
[47:32] So playing things ahead a little bit,
[47:35] I got these values on note and slide,
[47:38] and those exist off to the side
[47:40] because they're just passed in
[47:41] as arguments back and forth through the system,
[47:43] but if I play forward how the rest of this tree would flow,
[47:47] I imagine that to load my notes
[47:49] I'd probably need to read a file,
[47:50] parse that outline to some sort of logical set,
[47:54] and then flatten all the points out
[47:55] so that the story is sequential just like a slide deck.
[47:58] This first thing is I/0, so I'd wrap it
[48:01] with a wrapper like we talked about earlier.
[48:02] The other two are pure functions,
[48:05] which means I can test them,
[48:06] delightfully, with no mocks needed.
[48:08] The pair emoji job would probably need
[48:11] to tokenize those notes,
[48:12] pass them to something that does sentiment analysis,
[48:14] and then convert those to slide objects.
[48:16] The first thing would be a pure function.
[48:18] The second thing would probably wrap
[48:20] any of a dozen npm modules that do sentiment analysis.
[48:24] The third thing would be another pure function.
[48:26] Real easy.
[48:27] The third job, creating that file.
[48:30] We'd probably want to take those slide objects
[48:32] and like indicate layout and text up here, emoji down here.
[48:35] Probably want to generate AppleScript commands
[48:37] in some sort of structured way
[48:39] so we can rifle through a set of them
[48:41] to create the presentation.
[48:44] And then finally something to automate Keynote.
[48:45] The first thing, again, is a pure function.
[48:48] So is the second item.
[48:49] And then the third one, we'd probably just like --
[48:51] we'd shell out to osascript binary,
[48:54] and just wrap that and pass all those commands on through.
[48:58] What this approach has given me as I've developed it,
[49:01] and mapped my personal work flow to this one,
[49:05] over the years, is reliable incremental progress
[49:08] at work every day, which is something
[49:10] that I didn't have earlier in my career.
[49:12] Also, all of the things that I write
[49:14] have a single responsibility,
[49:16] just sort of shakes out that way.
[49:17] They're all small and focused.
[49:18] And they all have intention revealing names
[49:20] because all of the things that I write
[49:22] start out as just a name and a test,
[49:24] so they'd better say what they do clearly.
[49:26] It also leads to discoverable organization.
[49:29] So a lot of people are afraid of like
[49:31] oh man, too many small things in one big file,
[49:33] I'll never find anything.
[49:35] But because I visualize everything as an outside in tree,
[49:38] I sort of just tuck every subsequent layer
[49:40] of complexity behind another recursive directory.
[49:42] So if you were interested in how this thing works,
[49:45] and maybe only at a cursory level
[49:46] you look at that first file,
[49:48] but if you want to dig in,
[49:48] you know that you can dive
[49:50] into the directories underneath it.
[49:51] Separates out values and logic,
[49:54] and what I found is that by keeping
[49:58] my data values off to the side,
[50:00] and my logic completely stateless,
[50:02] things tend to be more maintainable.
[50:04] And what I end up with at the end of the day
[50:06] is a maximum number of simple, synchronous pure functions
[50:10] that are just logic, that don't need to know anything
[50:11] about promises or call backs or anything like that.
[50:13] And so this has made me really, really happy.
[50:16] Okay, so that's all I got.
[50:17] You may mock me now.
[50:19] I know that you guys have been super patient.
[50:21] This was a long talk.
[50:22] There was a lot of slides.
[50:23] Again, I come from a company, Test Double.
[50:27] We, if your team is looking for senior developers
[50:29] and you care a lot about improving,
[50:31] and this is like one of the ways
[50:32] you might be interested in improving,
[50:34] myself and Michael Schoonmaker are here today.
[50:36] Wave, Michael.
[50:38] Yeah, he's up in the front row.
[50:39] We'd love to meet ya tonight, and hang out.
[50:43] You can read more about us here or contact us.
[50:46] We're also always looking for new double agents.
[50:48] If you're interested and passionate about this stuff,
[50:50] and you want to do consulting,
[50:51] check out our join page and learn
[50:53] what it's like to work with us.
[50:55] Quick shout out to an even less popular library
[50:58] that we wrote called teenytest.
[51:00] All of the code examples and the test examples in this
[51:02] are real working tests.
[51:03] This is our zero API test runner
[51:06] which we really love using for small projects and examples.
[51:08] The only other time I've been in San Antonio,
[51:11] I gave another talk about testing.
[51:12] I apparently have like a niche.
[51:13] (audience laughs)
[51:15] It's entitled how to stop hating your tests,
[51:17] and if you liked this talk,
[51:19] I think that would be a really good companion.
[51:21] 'Cause it's about more than just mocking.
[51:24] So finally, would love all your feedback,
[51:27] would love your tweets, and whatnot.
[51:29] I'm just excited to meet as many of you as I can today.
[51:31] Got a lot of stickers and business cards for you,
[51:34] so that's it. I'm all done.
[51:36] Thanks a lot for your time.
</pre>
