---
title: "Make Ruby Great Again."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
video:
  url: "https://player.vimeo.com/video/165527044"
  type: "vimeo"
reddit: false
---

The [video above](https://vimeo.com/165527044) was recorded at
[RailsConf 2016](http://railsconf.com) on May 5, 2016.

## Background

Only a few days before [RailsConf](http://railsconf.com), I was asked by [Sam
Phippen](https://twitter.com/samphippen) to fill in for his talk because he was
sick and couldn't travel internationally. The only catch: I would have to speak
on his topic, covering the same content, and without much in the way of
ready-to-use prepared content. I stared at my white board for a few hours and
agreed to do it.

The title of talk, as a result, is necessarily "RSpec and Rails 5", but don't
let its name lead you to assume the scope of the talk is so narrow. By using the
upcoming, perfunctory changes to both libraries as a jumping off point, the
discussion quickly broadens to how developers relate to their tools over time,
essentially asking "why should RSpec continue existing in 2016?"

From there, we consider whether the maturity of its tools has lulled the Ruby and
Rails community has into a state of complacency. In an industry that's obsessed
with viewing technical novelty as potential panacea to its much more complex
root cause problems, we have to ask: can a programming language continue to thrive
even after its tools and core libraries are mostly finished? What can the
community do to foster continued growth in such an environment? Whose job will it
be?

Ruby has never been a more productive environment to work in, and as a result
it's never been at greater risk of slipping into irrelevancy. These are important
discussions to have as the dust continues to settle for the tools Rubyists use to
do their job.

## Transcript

<pre class="transcript">
00:00 Alright, so, when you walked in you saw this.
00:05 That's me, that's Justin Searls
00:07 But, you can see how it's written by hand
00:09 on an index card
00:11 There's this story behind that. This is not my talk
00:13 Which is part of why I'm so nervous…
00:16 Please don't leave. You're in the right place at least
00:21 Stay where you are and I'm going to do my best
00:23 …despite this. This is actually
00:25 [Squeals of anguish and defeat]
00:29 Not acceptable!
00:33 I'm being trolled so hard. Ok, so:
00:36 This is not a bait-and-switch
00:38 I've spoken at RailsConf two times before and I…
00:40 intentionally wrote abstracts to get through the CFP and then I
00:42 talked about what I wanted to talk about
00:44 This is not a bait-and-switch like those two
00:47 It wasn't intentionally that. It is now
00:49 This was supposed to be Sam Phippen's talk
00:53 Everyone go follow Sam, he's great
00:55 Sadly, Sam is in the hospital
00:57 So he wasn't able to give this talk
00:59 And that's why I'm here instead
01:02 But it's a British hospital
01:04 So, he's just "in hospital"
01:09 So, send your good wishes to Sam
01:11 Why me? Why am I here? Well…
01:13 Sam likes to give conference presentations
01:15 wearing my company's branded t-shirt
01:18 Test Double
01:19 So people are often mistaking him
01:21 for one of our employees
01:22 such that, he now actually has intro slides
01:24 like "I do not work for Test Double"
01:28 But I love them and also @searls
01:30 I heartily appreciate
01:32 We love you too Sam, that's why we're here
01:34 You're a great member of the community
01:37 So this talk's going to be Phipp'n great!
01:40 Only problem is
01:42 I finally understand imposter syndrome
01:45 I've got a little bit of imposter syndrome
01:47 Because I am a literal imposter today
01:49 in three main categories
01:51 1. I am not British
01:53 As we all know as Americans
01:56 of those of in the room who are American
01:58 Everything out of British people's mouths
02:00 Sounds a lot more intelligent
02:01 So I have that shortcoming
02:03 Therefore, actually, I resolve
02:06 To use fewer contractions
02:07 To speak with authority
02:09 and to drop the rhotic "R"
02:11 So let's practice the sentence:
02:13 "Minitest is not bette' than RSpec"
02:19 Alright
02:20 I feel better already
02:22 2. I lack Sam's glorious mane
02:25 I don't have a big, bushy beard
02:27 Sam, of course, derives his RSpec powers
02:29 from his beard
02:31 This is obvious because why else
02:33 would he have it?
02:36 I have not shaved since I agreed to do this
02:39 7a.m. Friday morning
02:41 I'm scraggles.
02:44 So I now know a few things
02:46 Based on the RSpec-beard powers
02:47 1. Beards are itchy
02:49 2. RSpec
03:00 and 3. what beard oil is
03:04 if anyone—I forgot my razor, true story—
03:06 if anyone has some beard oil on them
03:08 hook a brother up
03:11 3rd thing and 3rd way
03:13 in which I am an imposter today:
03:13 I am not on rspec-core
03:15 Here is a little organizational chart
03:18 Of where I fit in to RSpec
03:20 That's rspec-core & that's me
03:22 Not being in it.
03:25 But you know what, apparently it's just
03:27 not a RailsConf without a talk
03:29 from an RSpec committer about RSpec
03:31 So far, to date,
03:33 The only RSpec thing I have committed to
03:35 is this talk
03:38 I decided to become an RSpec committer
03:41 It sounds like a good idea
03:44 Let's get started, I'm going to
03:45 make my first RSpec commit right here
03:49 "I'm so committed right now…
03:51 …to RSpec"
03:53 Gonna push it up
03:55 access denied!
03:57 I tried everything earlier in the hotel
04:01 Let's try one more time
04:03 This always works
04:07 You know what? You get this error message
04:09 also when GitHub's down, so it's probably
04:11 just that GitHub's down
04:13 So as this talk's resident RSpec committer
04:16 I have some startling announcements to make
04:19 I'm here, ready to announce the future
04:21 of RSpec for you today
04:22 Current version of RSpec is 3.4.0
04:25 I'm here to announce the next major
04:27 release of RSpec: RSpec 5
04:31 RSpec 5 is gonna be revolutionary
04:34 Because we have some really awesome
04:35 headline features that are very convenient
04:38 to me and my purposes
04:40 the first: TurboSpec
04:44 Let me tell you about TurboSpec
04:51 Yup
04:53 TurboSpec:
04:55 Dumps the ObjectSpace into the cache
04:57 into memory, after running every single
04:59 one of your before hooks. It does this
05:01 so that it can cache each nested
05:03 example group's setup code
05:05 So that you don't have to run it across
05:06 all your tests
05:07 If you run the RSpec CLI
05:10 tack-tack turbo-button, it speeds
05:12 up your tests
05:13 TurboSpec is gonna make all of our
05:15 slow RSpec suites way faster
05:17 Warning: it doesn't work if your application
05:19 …has side effects
05:21 But for the rest of us it's gonna be great
05:25 I have another feature for RSpec 5
05:28 that I think is gonna really just
05:30 make true believers of RSpec happy
05:33 Spec Specs
05:36 You just create a Spec of type spec
05:39 and hten you can say things like "Hey,
05:41 …this model Order, I expect it to have…
05:43 5 specs
05:52 I expect order to finish within
05:54 about two hours
05:56 To have 95% code coverage
05:59 To limit the nesting and indentation to
06:01 just three contexts
06:03 To usually pass
06:06 and to be good code
06:08 I don't know why they didn't have this
06:09 in RSpec 3. It's in RSpec 5
06:13 Remember: it's important to spec spec
06:15 your spec specs, people
06:17 Let's not get lazy
06:25 Obama: "I said 'Justin, just give it a rest'"
06:22 Obama's saying things
06:28 [Typing]
06:29 Audio doesn't work anymore because of the shenanigans
06:32 Let's try it one more time
06:33 Obama: "I said 'Justin, just give it a rest'"
06:37 What he said was "Justin, just give it a rest"
06:41 Dammit
06:42 I'm gonna be… now I'm not gonna sleep tonight
06:46 So, thanks audio
06:49 [Nervous stammering]
06:51 I'm not sure if I'm cured or if I'm
06:54 still impostering
06:55 You know, I am not Sam
06:57 If you don't know me,
06:58 This is what I look like on Twitter:
07:00 when I'm getting retweeted for saying
07:02 terrible things
07:03 That's me, @searls.
07:05 I'd love if you became my Twitter friend
07:07 or got me some feedback about how
07:09 things are going… I know it's not great so far
07:12 This is the Justin Searls Marriage Simulator
07:14 Basically, it's just you sitting across
07:17 the table with me looking at my phone and
07:19 making slanted faces
07:22 So we can all empathize with @beckyjoy
07:24 a little better
07:25 This is me on brand:
07:27 I help run a software agency called Test Double
07:30 Our mission is audacious
07:32 We're just trying to make the world's
07:34 software less awful
07:36 I'd love if you got us any feedback
07:37 at hello@testdouble.com
07:40 Alright, so
07:42 Again, talk title:
07:43 back to basics. RSpec. Rails 5
07:46 What's there to know?
07:47 By the way, sidebar:
07:51 Did you know Sam rejected
07:52 my RailsConf talk?
07:56 I just thought I should mention that
07:59 Because, I am supposedly honour-bound to
08:01 cover all this Rails 5 stuff
08:03 because it's important to cover
08:05 for the purpose of the program
08:06 Which, I took with nothing but grace
08:11 So Rails 5 stuff
08:13 My first question to Sam, via text message
08:15 on Friday morning was:
08:17 Will RSpec just work with Rails 5?
08:18 Sam: "No!"
08:21 and he was saying it as an implementor
08:23 He's thinking about all the work
08:25 they need to do
08:26 Because, obviously, if you've ever
08:28 maintained a gem, newsflash:
08:30 Major Rails releases break gems in surprising and myriad ways
08:33 I went and searched for just open GitHub
08:37 issues that are demanding Rails 5 support
08:40 Just search for it and you get a whole
08:42 lot of salty randos, saying "Hey!
08:45 Rails 5 is not supported"
08:48 "No description"
08:51 "Give me Rails 5!"
08:53 "You owe me."
08:54 "C'mon! Gems!"
08:55 "Work. Work. Give me."
08:59 Rails 5's not even out yet, people!
09:03 So if you know a maintainer, go give the
09:05 maintainer a huge, because, seriously
09:08 Rails major release upgrades are big work
09:10 RSpec considers this to be feature work
09:13 They don't want to break, make any
09:14 breaking changes. They want you to be
09:16 able to upgrade very gracefully
09:18 That's why they respect SemVer as much as I don't
09:21 They're at 3.4.0 now, it's gonna be 3.5.0
09:24 which means they have to keep it running
09:26 for older versions of Rails, but also new
09:28 versions of Rails, so I hope that you
09:29 take a moment to thank the RSpec team
09:31 for their thankless work, because everything that
09:33 they're doing here is behind the scenes
09:36 But there is one change that we all have to know about
09:38 which is, is it true that functional tests
09:41 and controller specs are really deprecated?
09:43 Well yes, it actually is true
09:44 They're going away with Rails 5, they're
09:47 deprecated, or at least soft-deprecated
09:49 to which, I say, "Finally."
09:52 If you don't write controller specs,
09:54 by the way, feel free to just play with your phone
09:56 for this portion of the talk
09:57 if you do, it all started when DHH opened
10:01 this issue, saying the mechanism for
10:05 verifying that you assigned a particular
10:07 instance variable in a controller, making
10:09 sure that a particular template was going
10:12 to get rendered, those were testing
10:13 implementation, those aren't really valuable
10:15 let's deprecate functional tests, and I
10:18 feel like he was absolutely right
10:20 that it was a really good point
10:23 And, of course, if you disagree, you might
10:24 disagree just because you write controller specs
10:26 but, here's my beef with controller specs
10:28 This is the testing pyramid here, at the top
10:30 of the testing pyramid is just a way to illustrate
10:32 these are full-stack tests that call through
10:34 everything in reality, and stuff at the
10:36 bottom, these are just unit tests
10:37 Stuff in the middle are difficult to explain tests
10:40 explain test
10:41 and that's what controller specs are, so
10:45 the problem, right
10:47 [Gasps]
10:49 The opportunity!
10:53 Oh my gosh
10:54 [Breathing intensifies]
11:00 Alrihgt
11:02 I'm so glad to be one of those chill
11:04 go with the flow kinda guys
11:08 The problem with controller specs
11:10 at this level is that above that point
11:12 in the pyramid, there are untestable
11:14 things that can break, and so they're only of
11:17 limited value and everything below it
11:20 the messages that you get are going to give you
11:22 unclear reasons why things are going to fail
11:23 because it might be something way way deep below you
11:25 that is actually the root cause of the failure
11:27 and the error messages aren't going to be very helpful
11:29 it helps you in that very skinny way, but I don't know how much
11:31 value that really adds. Another
11:33 thing about controller specs that sucks is that
11:35 they were a lie to begin with; their
11:37 API implies that a request is being made
11:39 so if you've got a controller
11:41 you do `get :index` like
11:43 you're actually making an HTTP request
11:45 and then you have these assertions like you render this template
11:47 or you redirect it, or you have this HTTP status
11:49 "oh, look! I'm making a request"
11:51 Wrong! That's just
11:53 some really sugar of a facade
11:55 and it's just invoking your controller methods
11:57 which means that all this other stuff is not
11:59 happening like middleware's not getting
12:01 invoked. So, your controller specs might be
12:03 passing, but your controller's totally busted
12:05 "But they're faster!"
12:07 And that's why they exist
12:09 And they might be faster at run-time
12:11 but in my experience, they're much slower at fix-time
12:13 they're just a maintenance nightmare
12:15 for all that no-value they provide
12:17 -
12:19 despite the criticism, controller
12:21 specs… SemVer, right?
12:23 So, RSpec is promising not to break our tests
12:25 with Rails 5. The way that
12:27 we are doing that, the way
12:29 that you do that, all that you have to do is
12:31 add this gem to your Gemfile
12:33 calle 'rails-controller-testing', which will
12:35 reintroduce the functional testing bits
12:37 that rspec-rails needs, and then
12:39 meanwhile the RSpec team is doing the hard work to
12:41 make it seamless. It's my understanding Sam
12:43 Phippen is doing a lot of that work
12:45 and I hope that's not what put him in hospital
12:47 so thanks
12:50 to Sam and the rest of the core team
12:52 if you already have a lot of controller
12:54 specs, stop writing those now
12:56 there's stuff that you can do instead
12:58 of controller specs in the future; here's some
13:00 alternatives. 1. you can write full-stack
13:02 feature tests that test that everything's fully working
13:04 when everything's really integrated; you could
13:06 also do nothing.
13:08 I do nothing, I
13:10 have not written a controller spec for 7 years
13:12 You can also
13:14 do request specs, which are
13:16 very similar—we'll talk about those in a second
13:18 Because, request
13:20 specs are like honest versions
13:22 of controller specs, they
13:24 map to Minitest
13:26 integration tests in Rails
13:28 the reason that they're honest is that
13:30 the API look s the same and the assertions look
13:32 the same, except it actually exercises
13:34 the routing, middleware, and the views
13:36 so if something blows up, it's a good blow-up
13:38 Another cool thing, because it's using
13:40 rack-test, you have access to response body
13:42 and you can make assertions on the actual response
13:44 that's generated instead of all this weird
13:46 implementation stuff
13:48 When you to use Request specs instead of Controller specs:
13:50 (Or nothing)
13:52 Specs that assert a complete API
13:54 response, like if you've got a JSON API
13:56 and you can assert everything that it does, cool!
13:58 request specs are probably the right layer to test
14:00 that. Specs that just assert you're
14:02 assigning certain ivars or rendering certain templates
14:04 Ehhh. It's needlessly coupled
14:06 to the implementation; you probably don't need a request spec
14:08 Specs that assert HTML
14:10 that comes out of the response body
14:12 probably not a good idea, unless
14:14 your app has absolutely no JavaScript
14:16 which is probably unlikely
14:19 So that's a bit about request
14:21 specs / controller specs. Third bit
14:24 It was in the abstract
14:26 right? That we're going to learn how to test ActionCable
14:28 So, does RSpec help us test ActionCable?
14:30 No.
14:32 Turns out that ActionCable
14:34 testing isn't built into Rails yet. There's an open
14:36 pull request, and I assume that
14:38 when that ships, RSpec
14:40 will have a wrapper for it, or something
14:42 so just test through the browser for now and make
14:44 sure your website works
14:46 Alright, there you go!
14:48 You are now ready to RSpec with Rails 5
14:50 Thansk very much Sam
14:52 for trusting me with your talk
14:54 There's nothing more for you to see here. You can
14:56 close Skype, Sarah. There's nothing
14:58 I think he's actually maybe here
15:00 I think I see him waving, actually
15:02 Hi, Sam!
15:04 Yeah
15:06 He just looks excited
15:08 Alright, bye Sam!
15:12 So, one time—Aaron Patterson's up in
15:14 the front row—one time I texted
15:16 Aaron something and he tweeted it and got a million
15:18 retweets. And I felt really salty about
15:20 that, because I was like "No, that was my random
15:22 Internet meme that I copy and pasted"
15:24 And he sent me
15:26 this in response
15:28 It's not fundamental attribution error
15:34 It's Internet attribution error
15:36 So, this is my talk
15:44 RSpec & Rails 5
15:46 Why are you here?
15:48 Really!
15:50 Shout it out, somebody tell me!
15:52 Why are you here?
15:54 Audience member: "Searls!"
15:55 No!
15:57 Why'd you come to this talk, especially if you didn't who I was?
16:02 Audience member: "Sarah told me to [inaudible]"
16:04 Something RSpec-related, anyone?
16:06 Audience member: [Inaudible]
16:07 What's that?
16:09 Audience member: "RSpec"
16:10 Okay, thanks
16:12 Audience member: "RSpec"
16:13 Alright, thank you
16:14 Aaron Patterson: "I want to know how to test ActionCable"
16:17 ActionCable! RSpec! Thank you!
16:20 Audience member: "RSpec cable!"
16:22 RSpec cable!
16:23 Well, I had 2 theories because I couldn't make the
16:25 slides after asking you
16:27 1. How the hell do I test ActionCable?
16:29 Sorry
16:31 to those people, because I don't know
16:33 2. I am not happy with my test suite
16:35 Now I have a third theory
16:37 too, like: "I'm new here and what the
16:39 hell is all of this about, because it's just a lot of
16:41 forensics and who are these people"
16:43 I'll focus on the one that
16:45 I can actually address, which is what happens when
16:47 we're still not happy with our test suites
16:49 Well, if you have this motivation
16:51 and that's part of why you came to this talk
16:53 Maybe you were thinking RSpec
16:55 might have a new feature that'll help me
16:57 hate my tests less. Or maybe
16:59 Rails has some new thing that
17:01 or removes a new thing that will help
17:03 make the pain stop; make my test
17:05 suite more sane
17:07 I think that's a natural thing to do
17:09 especially, when you're at a conference where you're going to
17:10  learn about technology; we're searching for tools
17:13 and tools are easy, because we can grab'em off a shelf
17:15 and use them, but they're way easier than
17:17 critical introspection, asking ourselves hard
17:19 questions like, maybe it's our fault
17:21 that we have terrible tests
17:24 There's 2 keys to happiness with
17:26 testing or anything in software
17:28 1. The tools that we use
17:30 2. How we use
17:32 those tools; and it's not
17:34 a 2-step recipe; there's
17:36 if it's a not a false dichotomy
17:38 —it is a false dichotomy to blame one side
17:40 or the other, some people will say "oh, well
17:42 clearly we just need better tools whenever we
17:44 have a problem." And some people have a disposition that
17:46 says, "No, we just have to think differently, we have to
17:48 design harder. If the tool
17:50 is failing us, we're not using it hard enough"
17:54 That's not a good mental model either
17:56 but I like to think of it as first there were people
17:58 thinking, and they were doing stuff
18:00 and then they wrote
18:02 tools to help them do their job and then
18:04 the tools—our actual usage of them—
18:06 informs how we think about the problem, and
18:08 it's this hopefully-virtuous cycle
18:10 this feedback loop. So I
18:12 do believe tools matter. Tools aren't everything
18:14 But tools are important
18:17 We're going to talk about how tools prompt behavior
18:20 Some tools guide us
18:22 in a healthy direction to build good stuff
18:25 some tools enable our
18:27 bad habits, and some tools
18:29 just are written to be relatively
18:31 low-opinion; not very opinionated
18:33 first, I want to talk about a tool
18:35 that enables a lot of bad
18:37 habits. You might have heard of it,
18:39 it's called rspec-rails
18:43 I feel like whoever invented rspec-rails
18:45 was like, "Here's our marching orders: we're gonna
18:47 just do whatever Rails does and then wrap it with
18:49 our CLI and DSL
18:52 as uncriticially as possible
18:54 So, you got controllers?
18:56 Yeah, we can spec'm! Great!
18:58 Without thinking whether that was a good idea
19:00 You got a testing pyramid? We got
19:02 a testing pyramid!
19:04 You want model
19:06 specs and controller specs and helper specs
19:08 and view specs and routing specs and request
19:10 specs? Sure. And have feature tests too
19:12 Why not have all these
19:14 layers, and honestly as somebody who is—
19:16 especially when I was a novice, coming
19:18 in—I was like, "Well, clearly
19:20 our tools are built for good reason, they have a good
19:22 reason for having all these different tests. 'Test
19:24 all the F@&$ing time, that's great'. OK"
19:26 I looked at that and I was like
19:28 "man, I got my work cut out for me to
19:30 live up to this 7-layer nachos
19:32 of testing," and
19:34 What I came to realize over
19:36 through a lot of usage was, well,
19:38 all those integrated tests are very integrated. Every
19:40 single one of them will call through to the database
19:42 and additionally, they're very
19:44 redundant. When I have a new model that I'm writing
19:46 here and I make a change there,
19:48 I have this incidental coverage in all the
19:50 tests above it, so all those tests now have to be
19:52 updated as well. That creates a lot
19:54 of low-value work, just cleaning up
19:56 all my tests
19:58 Here's, protip, how I use
20:00 rspec-rails. This is a secret
20:04 My secret to using rspec
20:06 rails: is I have this whole thing
20:08 and then I blow away all of them except for
20:10 sometime feature specs and sometimes model specs
20:12 and if I have any sort of Ruby
20:14 that's at all interesting, I'll write
20:16 that in Ruby code
20:18 and test it with plain old RSpec
20:20 That's the only way I've been able to find
20:22 sanity with rspec-rails, but
20:24 it's not the tool's fault per se,
20:26 but I had to fight that tool to get to this
20:28 point. I had to fight all the documentation and all
20:30 the blog posts and all of the
20:32 arguments with people about why I was having problems
20:34 and that was not an example of a great tool
20:36 experience. Let me tell you about
20:38 an experience with a tool
20:40 that I thought was really really helpful and great
20:42 It's name is RSpec
20:44 RSpec itself
20:46 is actually really awesome, but I think that a lot of
20:48 people have a hard time with rspec-rails
20:50 and then they turn around and blame
20:52 RSpec, too, and I think that's kind of
20:54 unfair, it's worth it to look at them separately
20:56 So let's talk about what makes RSpec
20:58 kind of cool, first of all: I don't
21:00 believe that RSpec is a test framework, per
21:02 se. I think it's better to think of RSpec
21:04 as a framework for writing bette'
21:06 tests.
21:09 RSpec influences our design
21:11 It was designed to do that
21:13 It was a response to XUnit
21:15 with lots of repetitive methods that were
21:17 all set up, like tons of tests
21:19 setup, an action, and assert
21:21 But, what was cool about nested
21:23 example groups is
21:25 We can see the same symmetry,
21:27 and have very terse tests that
21:29 aren't redundant, but
21:31 we don't lose any clarity through
21:33 DRYing it up. That's my favorite thing about
21:35 RSpec-style testing
21:37 Additionally, I love that the assertions
21:39 guide the naming
21:41 for our methods. If I write this test
21:43 and the thing doesn't exist yet, by using
21:45 this matcher, `be_silent`, it's going to
21:47 assume that there's an instance method called
21:49 `silent?`
21:51 on that class
21:53 which is a really handy way to
21:55 inform that the usage is sensible
21:57 that's a natural name now
21:59 Additionally,
22:01 years ago, when I learned about `let`, I was pairing
22:03 with Corey Haines, and
22:05 Corey is a really smart developer, and I really
22:07 looked up to him and he's like, "`let` is great, because
22:09 it let's you call out your setup stuff
22:11 create a new user and assign it to this method
22:13 and even better, it's lazy—lazily
22:15 evaluated," and I was like, "I
22:17 don't know, Corey, I worship you, so lazily-evaluated
22:19 sounds sweet, that's great, I'm going to use `let`
22:21 for everything, so I'd use `let` a lot
22:23 and then, another feature
22:25 `let!`, which will
22:27 eagerly invoke that block
22:29 -
22:31 It has this interesting thing, because
22:33 people generally find `let!`
22:35 by being like, "well, I want this to run in exactly
22:37 this order. I want to make sure that it
22:39 invokes." And so Jim Weirich and I
22:41 paired, and he looked at my codebase
22:43 and he's like, "Dude, dude, you're doing this totally wrong"
22:45 "Don't just use `let!` for absolutely everything"
22:47 "It's there to draw out
22:49 your attention to side effects
22:51 in your code. It should be minimal. You should have
22:53 very very sparingly. Like if you need
22:55 to have a side effect in order for your
22:57 code to work, that means you have this
22:59 coupling of state, not just to your arguments, but also to
23:01 other stuff happening in the system." So that's
23:03 why there's a `!`, it means don't do it
23:05 So, that was an interesting
23:07 conversation that I never would have had
23:09 if it wasn't for RSpec
23:11 Additionally, RSpec reduces friction. The CLI
23:13 is great, because it's really
23:15 convenient
23:17 easy-to-use, pretty obvious, helps you
23:19 focus on just what you want to run; has good output
23:21 and that's all work that I
23:23 would have to do if I was building my own rake
23:25 tasks and my own testing CLI
23:27 stuff on every project
23:29 And, I love RSpec's
23:31 built-in reporters
23:33 [Applause in the other room]
23:34 Oh my God, we're at 30 minutes because of all the AV
23:36 stuff. Please don't leave
23:38 Ummm, umm, all the
23:40 reporters you need so that you have all
23:42 the CI stuff that you need. There's so many RSpec
23:44 plugins. I love that I get to
23:46 focus on just my tests and not the stuff around
23:48 my tests. Additionally, RSpec fosters empathy
23:50 the API is designed to
23:52 let you have a place to write in what the
23:54 heck you're doing. `describe`, you know, this slide
23:56 and how `it` compliments RSpec
23:58 You have this opportunity in there to tell
24:00 a little bit of your story in a way that's
24:02 congruent with your tests
24:04 another thing I love is that it shifts
24:06 your perspective, so RSpec has a domain
24:08 specific language. It does not look like normal
24:10 Ruby, and that
24:12 is a level of indirection, however
24:14 it forces me to think of my methods not
24:16 just as methods, but outside-in
24:18 what's it like to use them, what's it
24:20 like from the perspective of a stakeholder
24:22 what's it like under a different context
24:24 I really the DSL
24:26 for forcing me out of thinking of just methods
24:28 and classes
24:30 Another tool, talking about tools prompting
24:32 behavior, it's possible to write tools that just don't have
24:34 a whole lot of opinions. Minitest
24:36 is a good example of one such tool
24:38 it has a different priority than RSpec and
24:40 an analogy that I picked up from Aaron
24:42 this week is that you can think of minitest
24:44 as a race car
24:46 (it's why DHH uses minitest
24:48 by the way, if you don't know)
24:50 So it's lean, mean, it's
24:52 essential, it's only what you
24:54 need, to get your test's written
24:56 It's all pure Ruby, except it has these
24:58 hard bucket seats
25:00 versus, RSpec, a luxury sedan
25:02 with a lot of knobs and dials, but it's
25:04 mostly full-featured and quite comfortable to ride in
25:06 so,
25:08 if you want a comfortable seat
25:10 RSpec offers this rich Corinthian leather experience
25:14 that you can just sit in and feel comfortable
25:18 The zeitgeist right now, and by the way if you don't know
25:20 the word zeitgeist, it's a German
25:22 word for
25:24 "Time Snapchat"
25:28 The zeitgeist right now
25:30 is saying that minitest
25:32 is really hot. When I talk to all my friends
25:34 a lot of them have dropped RSpec, started using minitest
25:36 I think it's really popular right now and
25:41 I think one of the reasons is
25:43 people generally fear
25:45 and uncertainty and doubt about RSpec, that it's too
25:47 verbose, it's bloated, it's slow
25:49 there's too much indirection
25:51 it's better to just write pure Ruby. You ain't gonna
25:53 need it.
25:55 I'm here too; I use minitest on a lot
25:57 of my projects. I like minitest just fine
25:59 I like that it doesn't have very many opinions
26:01 and it gets out of my way and I can just write
26:03 just the tests I want, but
26:05 of course I carry with me the fact that I actually
26:07 very finally after years and
26:09 years, I have my own testing opinions
26:11 that I know work very well for me
26:13 and I can write tests without getting myself into too
26:15 much trouble, usually
26:17 But if you're not a testing expert
26:19 and you don't want to be a testing expert, or
26:21 if you're on a team with novices
26:23 what I would suggest is, remember: I learned
26:25 a lot discussing RSpec and grappling
26:27 with its API and its features with past
26:29 teammates, and I think
26:31 that you might benefit from that too if you
26:33 haven't had that experience yet
26:35 So, yeah, on one hand RSpec takes
26:37 longer to learn, but when you learn
26:39 how to use RSpec, you're also learning stuff about
26:41 design and testing, so maybe that's
26:43 not so much a bug as a feature in some
26:45 cases
26:47 So if you're still not happy with your test suite
26:49 I suspect that you might be looking
26:51 for a tool to solve your problems when instead
26:53 we can use our brains and use thinking
26:55 instead and change our approach
26:57 Oddly enough, at RubyConf last year
26:59 I gave a talk on exactly that
27:01 you can find it called: is.gd/stophate
27:04 it's called "How to Stop Hating Your Tests"
27:06 and it's not about tools, it's just about
27:08 thinkin'
27:10 Alright, so
27:12 in the time remaining, I'm going to get a little bit more
27:14 meta
27:16 Why are we here, really?
27:18 The fact
27:20 that anyone came to this talk, worries
27:22 me
27:28 I would not have come to this talk
27:31 Let me explain. Let me back
27:33 up. First of all, giving somebody else's
27:35 talk is a lot like testing their code
27:37 Because, I've had to
27:39 open all of Sam's work and his notes
27:41 to try to understand what he was going to say here today
27:43 So, if you see something
27:45 confusing, when you're looking at
27:47 somebody else's code and you're trying to write tests for it, or
27:49 trying to review it, it's easy to
27:51 think they're obviously a moron
27:53 So it's important
27:55 to assume the author is smart and intelligent
27:57 and had reasons
27:59 Meanwhile, if you see something that's obviously
28:01 awesome, great
28:03 It's still your job to
28:05 put on a critical hat and investigate it anyway
28:07 and ask the hard questions about why we're here
28:09 So let's critique
28:11 this talk
28:13 (Not the stuff that I said, just the Sam stuff)
28:15 the stuff I said is fine
28:20 This is the abstract. I assume you've read it, I won't
28:22 re-read it or anything. This is
28:24 his abstract, this is the first thing I read when
28:26 he texted me to see if I
28:28 could give this talk
28:30 This is my opinion of the abstract
28:34 People like peanut butter. People like chocolate
28:36 Slam'em together: rspec-rails
28:40 This talk, I felt—I read the abstract
28:42 —this could be a 6 paragraph blog post
28:44 and so the next thing I did was I googled RSpec
28:46 Rails 5 and found Sam's
28:48 6 paragraph blog post
28:52 And I was just thinking, I was mad
28:54 I was like, "Why was this talk
28:56 selected here? How
28:58 did this talk fly through the CFP
29:00 process without any
29:02 criticality whatsoever
29:04 that just doesn't seem right
29:06 Now, granted, my talk was rejected
29:08 and I'm a little bit biased, I might be
29:10 a little salty
29:12 but, when I thought about, I think that the reason
29:14 was that this was a safe talk
29:18 this was a comfortable talk
29:20 This is well within everyone's comfort
29:22 zones. I use RSpec, I use Rails, let's find out
29:24 what's new. Great.
29:26 But I feel like that
29:28 comfort should scare us, because
29:30 when we're in a group like this, it's
29:32 mature and we're getting up to major version numbers
29:34 like 5, you know comfort
29:36 can breed complacency
29:38 So, RSpec,
29:40 if we're just content with where
29:42 things are and we're pretty happy with RSpec
29:44 we're just happy to see little
29:46 tiny tweaks here and there, make sure it continues
29:48 to support stuff in the future
29:50 You're not writing blog posts about this
29:52 new RSpec thing. You're not writing new tools
29:54 You're talking about RSpec less
29:56 Even if RSpec does everything you want it to do
29:58 minitest, meanwhile, lately I'm
30:00 —like the zeitgest—I've seen a lot of people talking
30:02 up minitest. Writing more plugins
30:04 Educating people
30:06 a bit more with blog posts. And as a result, it's getting
30:08 a little bit more attention. So a new person
30:10 walks into the room, they're going to see people talking about
30:12 minitest more than RSpec. They're going to tend to go
30:14 towards minitest. Not RSpec
30:16 So, this reminds
30:18 me a little bit of a similar
30:20 dichotomy
30:22 Rails. Rails is pretty mature now. It's
30:24 over 10 years. Solves the problems that it solves
30:26 really well and it's pretty well known
30:28 for what it's good at and what it's not. So people
30:30 talk about Rails a little bit less
30:32 Especially all of us busy, getting-stuff-done
30:34 building things, we're not out there advocating
30:36 Rails anymore, because we get to use Rails
30:38 at work, which is itself fantastic
30:41 However, when you look at jobs
30:43 Rails jobs are on the decline
30:45 They're not just slowing down, it's
30:47 negative growth
30:49 There's this other thing. The technology
30:51 that shall not be named
30:56 Everyone's talking about Node.js like
30:58 it or not, 900% year-over-year
31:00 growth in jobs on Indeed
31:02 There's a lot
31:04 of activity there and it's
31:06 not about—this is not a contest of who's
31:08 the better technology or who solves stuff better
31:10 it's: what's the front page of Hacker
31:12 News? So, my challenge
31:14 is, thinking about this talk and
31:16 why the hell we're giving this talk and why we're here
31:23 That was ironic
31:31 Because, that's one of our options
31:33 The other option, if we're not willing
31:35 to get uncomfortable is we're going to see Ruby jobs start
31:37 to dry up. And there
31:39 might be, you know, fewer people at
31:41 RailsConf 2018 than this year
31:45 Another way to think about this is if you're not familiar with
31:47 RubyTogether is a non-profit
31:49 that pays people to work on Ruby open source
31:53 Another way to think about this is to ask, "what were the
31:55 conditions necessary in order for RubyTogether to
31:57 seem like a necessary and good idea?"
31:59 Well, when an
32:01 ecosystem is popular, everything is easy, because
32:03 there's just
32:05 wave-after-wave of
32:07 person on the Internet who's going to write open source
32:09 for free just for the ego, just for the fame
32:11 to be attributed to the new
32:13 popular thing
32:15 Also easy: sponsored
32:17 stuf like Oracle
32:19 backs Java. Java's not going
32:21 to go anywhere, because Oracle's incentivized for
32:23 Java to be successful. Google
32:25 is not going to drop Go, unless they feel
32:27 like it
32:32 I already dropped a mic but it's
32:34 [Kicks mic on floor]
32:36 JavaScript
32:38 cannot die, because
32:40 multiple vendors have staked their
32:42 businesses on it. Every single browser
32:44 JavaScript
32:46 is not going to go anywhere, so it's a really safe
32:48 bet
32:50 We talk about RSpec, it's mature
32:52 at this point, and I don't mean mature as a 4
32:54 letter word. Mature
32:56 means "mostly done". Bundler
32:58 is mature. Rails is
33:00 mature. Ruby is mature. They mostly
33:02 do what they need to do to do their job well
33:04 but that means
33:06 as a result, when you maintain a popular
33:08 gem like RSpec, it no longer makes you
33:10 rich and famous necessarily
33:12 and the ecosystem, the stuff that they had to
33:14 do just to make RSpec continue working with Rails
33:16 5 is almost all stuff that you don't
33:18 actually see. It's all internals
33:20 like legacy code refactoring. No one really wants
33:22 to do that and so the reason
33:24 RubyTogether needs to exist is because the energy and
33:26 the funding to keep Ruby competitive
33:28 isn't there otherwise
33:30 and that is disconcerting
33:32 Because RubyTogether isn't ever going to be big enough
33:34 to solve that fundamental systemic
33:36 problem. So
33:38 let's talk about my real job:
33:40 Sales
33:42 I spend a lot of time talking to business people
33:44 about software solutions and building
33:46 software apps and stuff
33:48 and entrepreneurs that I talk to
33:50 are always talking about certain
33:52 technologies that they hear about that are
33:54 advised to them like the
33:56 MEAN stack. Mongo, Express
33:58 Angular, and by the way,
34:00 I've talked to multiple business people
34:02 this year who are like "we're going to build it
34:04 a new application, we're going to do it all in Angular
34:06 1.x". Like,
34:08 people are teachnig business-people, "oh you don't want
34:10 Angular 2, just stay on 1 forever"
34:12 Like, I don't get it,
34:14 … just gonna wait…
34:16 …wait it out… and Node.js
34:18 the so called MEAN stack. A lot
34:20 of entrepreneurs are pushing this kind of stuff
34:22 another one: a lot of people are just assuming
34:24 based on trendiness, Node and
34:26 React are just the way to go
34:28 You know who's talking about Ruby and
34:30 Rails nowadays, out in the marketplace?
34:32 That has the ear of
34:34 CTOs and directors of engineering?
34:36 People spreading fear, uncertainty,
34:38 and doubt, because they have their preferred upstart
34:40 technology that's faster or whatever
34:42 and what those businesses are hearing
34:44 is that there aren't enough rubyists out
34:46 there. That the rubyists that do exist
34:48 cost too much. That
34:50 Ruby is slow and that Rails
34:52 doesn't scale—either at runtime or
34:54 operationally
34:56 Now if you're in the room, you're like "noo!
34:58 no no no! Ruby's fine
35:00 it's okay" But I feel like this is a
35:02 real important bit of anecdata
35:04 from the life of Justin Searls we all need to deal with
35:06 to help
35:08 solve my consulting sales problems
35:13 Because I don't like sales
35:17 But that's why it's so frustrating
35:19 Rails is still the best choice for
35:21 entire classes of applications
35:23 But because we
35:25 stopped saying it a few years ago,
35:27 businesses stopped hearing it
35:29 People only share new
35:31 stuff that excites them,
35:33  that's novel
35:35 If you were to discover
35:37 immortality today
35:39 It would drop off the front page of
35:41 Hacker News after a week or two
35:43 People wouldn't be talking about
35:45 it. They'd find some new shiny thing. They'd be talking
35:47 about React Native 1.0
35:50 and not that you just, you know,
35:52 defeated death
35:54 Even though that thing is way
35:56 more objectively better, it's not novel after
35:58 a certain bit of time. So the
36:00 dilemma, right, is that Ruby is no longer new
36:02 Ruby is still good
36:04 We gotta do something
36:06 So Ruby can remain relevant and
36:08 we can keep working on Ruby at work
36:10 What's the "we do something"
36:12 part
36:14 Remember, Ruby is mature
36:16 It does it's job mostly well
36:18 And one
36:20 thing that I think our community
36:22 that technologists need to get comfortable with
36:24 is that it is okay for tools to be
36:26 mostly finished
36:28 It is okay for software to just mostly do it's
36:30 job and be good at what it does
36:32 In any other industry
36:34 it would be ridiculous for us to say otherwise
36:36 Like, oh, well, it's clearly obsolete
36:38 now because it's not super
36:40 active and they're not adding new features. At a certain point
36:42 it just does what it needs to do
36:44 Remember, I said the keys to our happiness were our tools
36:46 We all like Ruby, we like Rails, that's
36:48 why you're here. And how
36:50 we use them. So maybe it's time for us
36:52 as a community to
36:54  de-emphasize the tools and start talking
36:56 more about how we use those tools to
36:58 accomplish really cool stuff
37:00 Because there's all of these evergreen problems
37:02 in software. There's all these problem's we're never going
37:04 to solve. We're never going to solve
37:06 testing. We're just going to get asymptotically
37:08 better each time.
37:10 We're never going to solve design
37:12 Because we're always going to find new ways to design
37:14 code. And human
37:16 issues are never going to be solved either
37:18 Right? How
37:20 our code communicates its intent
37:22 to its reader is never going to be solved
37:24 [Blinking light pounds against podium]
37:28 I swear, I get like 5 bonus minutes, Sarah
37:30 can I have a minute?
37:32 She's nodding very tepidly
37:37 So we can tell stories
37:39 that help people solve
37:41 problems
37:43 in ways that are more than just look at this
37:45 new shiny bauble, and if you
37:47 love Ruby, tell your story in Ruby and
37:49 associate it back with Ruby so that Ruby
37:51 remains known as a community of people
37:53 who really get object-oriented design right
37:55 who get testing right
37:57 who get community and inclusiveness right
37:59 Being known for those things and having
38:01 people talk about those things are
38:03 enough to keep us relevant. And when
38:05 you think about whose job this is, remember
38:07 that most of the people who made Ruby so famous
38:09 in the first place, don't write Ruby anymore
38:11 Their chapter is complete
38:13 Most of them have moved on to other
38:15 ecosystems. Some of them are no longer even with us
38:19 and that means that keeping Ruby relevant is
38:21 not somebody else's job
38:23 I hate to break it to you, but the fact that you show up to a
38:25 conference called "RailsConf" in a
38:27 room that holds just a couple hundred people means
38:29 that you're one of the top couple hundred people
38:31 whose job this is now
38:33 to keep Ruby relevant. If you care
38:35 So my message is
38:36 Make Ruby Great Again
38:38 [Thunderous, sustained applause]
38:42 [[Captioning provided by @searls]]
38:44 [[Who was biased as to how the applause was qualified]]
38:46 [More generous applause]
38:48 [What a great audience, you know?]
38:51 [Whispers] Hashtag: #MakeRubyGreatAgain
38:53 [#applause]
38:56 And tell your story. We don't have the time to
38:58 talk about it today. Use this hashtag and
39:00 tell me something that you could do
39:02 to tell a story that might
39:04 change something. That might have an
39:06 impact on others and might
39:08 convince them that Ruby is a better
39:10 solution
39:12 than the technology that shall not be named
39:14 for whatever it is that you're doing
39:16 Again, my name is @searls, I'd love to be your friend
39:18 I'm going to be here for the rest of the week
39:20 If you want
39:22 to help us in our mission to fix
39:24 how the world writes software, consider joining
39:26 Test Double, we're always hiring great developers
39:28 If your company is looking for senior developers
39:30 and you're struggling to find people to add to your team
39:32 our developer consultants are great
39:34 senior developers who'd love to work on your team with you
39:36 and build stuff alongside you
39:38 If you don't want either of those things but you want a sticker
39:40 I've got stickers too
39:42 And most importantly
39:44 thank you all so much for your time. I really, really
39:46 appreciate it
</pre>

## Related resources

Here are links to a some of things I referenced in the talk, in roughly the order
they appear:

* [RSpec](http://rspec.info)
* [Rails 5](http://rubyonrails.org)
* [Imposter syndrome](https://en.wikipedia.org/wiki/Impostor_syndrome)
* [Beard oil](https://en.wikipedia.org/wiki/Beard_oil)
* [Me on twitter](https://twitter.com/searls)
* [Semantic versioning (SemVer)](http://semver.org)
* [DHH's thread on deprecating functional tests](https://github.com/rails/rails/issues/18950)
* [Controller specs](https://www.relishapp.com/rspec/rspec-rails/v/3-4/docs/controller-specs)
* [The testing pyramid](http://martinfowler.com/bliki/TestPyramid.html)
* [Request specs](https://www.relishapp.com/rspec/rspec-rails/docs/request-specs/request-spec)
* [Pull request for ActionCable testing](https://github.com/rails/rails/pull/23211)
* [The "I made this" meme](http://knowyourmeme.com/memes/i-made-this)
* [rspec-rails](https://github.com/rspec/rspec-rails)
* [Redundant test coverage](https://github.com/testdouble/contributing-tests/wiki/Redundant-Coverage)
* [RSpec's nested example groups](https://www.relishapp.com/rspec/rspec-core/v/3-4/docs/example-groups/basic-structure-describe-it#nested-example-groups-(using-`context`))
* [RSpec's predicate matchers](https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers/predicate-matchers)
* [RSpec's `let` and `let!`](https://www.relishapp.com/rspec/rspec-core/v/3-4/docs/helper-methods/let-and-let)
* [Minitest](https://github.com/seattlerb/minitest)
* [Corinthian leather](https://en.wikipedia.org/wiki/Corinthian_leather)
* [Zeitgeist](https://github.com/seattlerb/minitest)
* [YAGNI](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it)
* [Video: How to Stop Hating Your Tests](2015-11-16-how-to-stop-hating-your-tests)
* [Sam's abstract](http://railsconf.com/program#prop_1682)
* [RSpec's Rails 5 announcement](http://rspec.info/blog/2016/02/rspec-3-5-0-beta1-has-been-released/)
* [Indeed Job Trends](http://www.indeed.com/jobtrends)
* [RubyTogether](https://rubytogether.org)
* <a href="https://en.wikipedia.org/wiki/MEAN_(software_bundle)">The "MEAN" stack</a>
* [React.js](https://facebook.github.io/react/)
* [Hacker News](https://news.ycombinator.com)
* [#MakeRubyGreatAgain](https://twitter.com/search?q=%23MakeRubyGreatAgain)
* [Joining Test Double](mailto:join@testdouble.com)
* [Test Double's Agency](//testdouble.com/agency)

