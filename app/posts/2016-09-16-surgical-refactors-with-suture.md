---
title: "Surgical Refactors."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
video:
  url: "https://player.vimeo.com/video/182947603"
  type: "vimeo"
reddit: false
---

The [video above](https://vimeo.com/182947603) was recorded as the Day 2 keynote
at [Ruby Kaigi](http://rubykaigi.org/2016) on September 9th, 2016.

## Background

I've been occasionally criticized since my [Make Ruby Great
Again](http://blog.testdouble.com/posts/2016-05-09-make-ruby-great-again.html)
talk that it's been a while since I'd contributed much to the Ruby community. I
was thinking about this when I was asked to design a talk for Ruby Kaigi (Japan's
national Ruby conference) that was about something other than testing or
feelings. (This forced me to consider whether I knew anything other than testing
and feelings.)

I sat on the idea for a while before surmising that the greatest risk facing
Ruby teams' continued use of Ruby was not only whether Ruby was [fast
enough](http://engineering.appfolio.com/appfolio-engineering/2015/11/18/ruby-3x3)
or [concurrent enough](http://www.atdot.net/~ko1/activities/2016_rubykaigi.pdf),
but whether their existing applications were *maintainable enough*. The most
common reason I've seen teams leave Ruby for has been the lack of tools and
education needed to work effectively with large, complex applications. (New
languages are appealing, but new languages with which you don't yet associate
with tremendous pain are even more appealing!)

Regardless of language, when saddled with a hard-to-change codebase,
the grass of a total rewrite will seem greener. But Ruby's dynamic nature gives
us fewer tools than some other language ecosystems for successfully managing the
invetible accretion of incidental complexity that every long-lived system faces.
Is there anything we can do to make legacy Ruby more maintainable?

That question led me to this talk. In it, I introduces a new gem that we designed
to help wrangle legacy refactors. It's called
[Suture](https://github.com/testdouble/suture), and along with providing some
interesting functionality to make refactoring less mysterious and scary, it also
prescribes a clear, careful, and repeatable workflow for increasing our
confidence when changing legacy code.

We hope you'll watch the talk and try out Suture in your projects! Please
[tweet at us](https://twitter.com/testdouble) or [open an
issue](https://github.com/testdouble/suture/issues/new) if you have any
questions.

## Transcript

<pre class="transcript">
[00:00.355] This talk is called surgical refactors
[00:03.895] Could we bring the lights down so that we
[00:06.292] can see the screen better? All right, cool!
[00:08.597] Good morning, let's start.
[00:10.755] So, my name is Searls. That's me on
[00:15.035] Twitter, @searls. That's what I look like
[00:17.677] on Twitter, if you've maybe seen my face
[00:20.527] before. If you want to send me a message
[00:23.593] at justin@testdouble.com.
[00:25.947] My last name, I katakana-ize usually as
[00:30.915] サールズ (saaruzu) if you want to call me
[00:32.807] that, but the pronunciation is difficult,
[00:34.894] so in Japanese you may call me Juice.
[00:39.220] Yes, like "Apple juice".
[00:41.276] I come from a company called Test Double
[00:45.346] We're software consultants. If your team
[00:48.892] is looking for additional developers that
[00:51.570] are really good at Ruby, JavaScript, and
[00:53.788] testing, and refactoring, we would love
[00:56.360] to work with you. And if you're okay with
[00:59.449] people who mostly speak English you can
[01:01.627] send us an e-mail at hello@testdouble.com
[01:05.395] So, first, a little bit about me. This is
[01:08.725] me eating some Yaboton misokatsu in Nagoya
[01:12.271] last week. I talk very fast when I'm
[01:15.587] nervous. And I'm always nervous, so please
[01:22.263] forgive me. Everyone, I'm sorry. Please
[01:24.017] try [to keep up].
[01:25.717] We have plenty of time today, so if I'm
[01:31.503] speaking too fast, it's okay to shout
[01:34.095] "please go more slowly". That sort of
[01:37.411] thing is fine. Speaking of me being
[01:41.484] nervous, I was very nervous about screen
[01:43.945] size with the projector here this morning
[01:46.202] I didn't know if it was 16:9, or 4:3. But
[01:49.796] I think we landed okay, but it actually
[01:52.971] gave me an idea because Matz yesterday
[01:55.875] was talking about Ruby 3x3 and how
[01:58.313] difficult it will be to solve so I think
[02:00.439] can solve it here today really easily
[02:02.718] here it is [a 3:3 aspect ratio Ruby].
[02:06.405] That was a lot easier than he made it
[02:07.703] sound. Speaking of Ruby it's a massively
[02:10.465] successful language, right? And in the
[02:13.857] early days, success looks like a lot of
[02:16.962] happy people, they're building stuff for
[02:19.549] fun. People give us a lot of positive
[02:22.684] attention. I remember when I started
[02:24.731] learning Ruby, everyone I knew who wrote
[02:26.679] Ruby was really cool. And in the early
[02:30.218] goings of any language, the marker for
[02:32.496] success is if you're able to make it easy
[02:35.903] to make new things. And one of the best
[02:38.273] things about Ruby is that building
[02:40.343] something new is very easy. It does that
[02:42.323] very well. But later success is very
[02:45.831] different, because people are more
[02:47.600] critical. Now that it's popular, it's an
[02:51.019] incumbent, people are more critical in how
[02:53.380] they analyze the language. They're more
[02:55.796] serious because people use it for work
[02:57.955] And as time goes on, more and more money
[03:01.113] is involved in the existence of the
[03:03.416] programming language. And so the mood is
[03:05.926] very different with an older programming
[03:07.943] language. And I think the key to later
[03:09.659] success for a programming language is
[03:11.349] making it easy to maintain old things
[03:14.319] And nobody likes maintaining old things
[03:16.803] But my question for today: can we make
[03:19.634] it easier to maintain old Ruby code? And
[03:23.230] so I sat and I thought about this for a
[03:26.196] while. So, today as an exercise, we're
[03:29.223] going to refactor some legacy code. The
[03:31.244] word refactor stands out, you might define
[03:35.711] the word refactor—if you're not familiar—
[03:38.063] is to change the design of code without
[03:41.049] changing its observable behavior. So we
[03:43.532] change the internal implementation, but
[03:45.823] it still behaves the same way. How I think
[03:48.179] of refactoring is to change in advance
[03:51.400] of a new feature or a bug fix, in order to
[03:54.294] make that feature or that bug fix easier
[03:56.913] later. Legacy code is the other phrase in
[04:01.518] this sentence and legacy code has many
[04:04.535] definitions. Here are a few legacy code
[04:06.236] definitions. First: old code. Or some
[04:11.352] people say, legacy code is code without
[04:14.102] tests. Usually, we say legacy code just
[04:16.782] to mean a pejorative. It's code we don't
[04:19.002] like. But today I'm going to use a
[04:22.155] different definition of legacy code. I'm
[04:24.410] going to say that legacy code is code that
[04:26.680] we don't understand well enough to change
[04:29.059] confidently. So today, let's refactor some
[04:32.718] legacy code. Now, whenever anyone says
[04:36.389] "refactor" and "legacy code" in the same
[04:38.146] sentence, I feel like refactoring is
[04:40.450] really hard, because you have to take
[04:42.512] something that exists and then make the
[04:44.459] design better and that just takes a
[04:46.663] certain amount of creativity I don't
[04:48.526] always have. But refactoring legacy code
[04:50.550] is very hard, because it tends to be very
[04:53.602] complicated. And as a result, it's easy
[04:56.366] to accidentally break existing
[04:58.673] functionality for users, and so it feels
[05:01.170] dangerous. As a result, legacy refactors
[05:03.993] on teams often feel unsafe. They make us
[05:07.822] nervous. Additionally, legacy refactors
[05:11.678] are hard to sell to our managers and to
[05:14.890] businesspeople. If we were to chart
[05:17.248] business priority of our activities as
[05:19.111] developers against the cost and risk of
[05:21.814] what we're doing, in the top-right corner,
[05:24.649] in that quadrant: new feature development
[05:26.732] Obviously high priority, but also very
[05:29.355] expensive. In the top-left you'd put bug
[05:32.096] fixes. High priority, but relatively less
[05:35.177] expensive. In the bottom-left, low
[05:38.276] priority from the perspective of the
[05:40.089] business, but still relatively low cost is
[05:41.591] testing. And what's down here in the
[05:44.805] bottom right? I think refactoring goes
[05:46.721] here. So new features, we don't have to
[05:49.958] sell the business on new features. If
[05:51.260] they're paying you a salary, they've
[05:52.773] already decided they want to invest in new
[05:54.325] features. Bug fixes are normally easy to
[05:57.189] sell, because the cost-to-benefit is good
[05:59.184] Sometimes, we succeed at selling testing,
[06:02.020] we usually do nowadays. But we don't
[06:04.255] always, because it's not always seen as
[06:05.985] very important. Selling refactoring is
[06:08.509] very hard, typically in my experience.
[06:10.890] In general, refactoring is just difficult
[06:14.064] It's difficult to estimate it's going to
[06:17.398] take because you don't know how much work
[06:19.919] it's going to be or how risky it is. From
[06:21.204] the business's perspective, it's invisible
[06:23.868] right? If to refactor code is to change
[06:25.900] its implementation, and not its observable
[06:27.952] behavior, they don't know what value
[06:30.045] they're getting out of the refactor. And
[06:32.496] typically, because we're changing
[06:34.229] something that's very complex, we have to
[06:36.301] put a stop on all other work on that area
[06:38.359] of the code because it would be difficult
[06:39.931] to merge in multiple changes, so we're
[06:42.387] stopping everything now. As complexity
[06:46.571] of that legacy code increases, it probably
[06:49.189] means that it was more important, right?
[06:51.647] The business needs something about that
[06:53.942] code to have 500 "if" statements and all
[06:56.117] sorts of complexity, so it's probably a
[06:58.156] very important piece of code. And so
[07:00.958] therefore changing it is less certain. And
[07:03.852] in general, more costly. So today as part
[07:08.126] of my "Make Ruby Great Again" series of
[07:10.101] talks, I want to make refactors great
[07:12.714] again. Of course I thought about that line
[07:15.500] for two seconds before I realized
[07:17.114] refactors have never been great, and so I
[07:19.718] just want to make refactors great for the
[07:21.302] first time, is my goal today. So in
[07:25.415] looking at this quadrant and looking at
[07:27.396] refactoring, there's really two ways we
[07:29.562] could make refactoring easier. On this
[07:31.244] axis, on business priority, we could try
[07:32.767] to sell refactoring to businesses, so they
[07:35.036] view it as a higher priority. Now when we
[07:38.794] sell refactoring to businesspeople, the
[07:41.046] image in their mind is typically like
[07:43.143] road construction. We're going to stop
[07:45.360] everything, no traffic is going to get
[07:47.833] through, but money is going to continue to
[07:49.880] fly out the window at the same velocity
[07:51.396] that it normally does. It's not a very
[07:54.349] attractive image to our managers. So we
[07:58.166] have a few tricks that we use to sell
[07:59.962] refactoring. The first one is that we try
[08:01.977] to scare them into it. We say, "hey, if
[08:04.449] you don't let me refactor this right now,
[08:06.281] someday we'll need to rewrite everything"
[08:08.443] But that's far in the future, that's
[08:10.823] difficult to prove. We might say your
[08:13.794] maintenance costs in the future will be
[08:15.588] much higher, but that's difficult to
[08:17.433] quantify. It doesn't feel real.
[08:19.482] Secondarily, we might try to absorb the
[08:23.454] cost, through discipline and
[08:25.381] professionalism. Maybe these are our new
[08:27.644] feature activities normally. We plan. We
[08:30.691] develop. We write tests. Maybe we just
[08:33.170] grow the pie and spend a little bit more
[08:36.032] time on each new feature by baking in some
[08:37.729] time for refactoring. And this is
[08:40.029] fantastic, but it requires immense amounts
[08:42.235] of discipline that most people don't have
[08:43.986] And, as soon as there's any time pressure,
[08:47.175] refactoring is going to be the first
[08:48.695] practice that we drop. And most teams
[08:51.200] experience a lot of time pressure, so
[08:52.956] that's not very effective either. Another
[08:55.877] strategy teams use is to take hostages
[08:58.128] The business sets the backlog priority
[09:00.682] saying I want feature 1, 2, 3, 4. But the
[09:04.006] team says, "No no, we're going to do some
[09:07.371] refactoring after feature 1 and before you
[09:09.810] get feature 3, we're going to do some more
[09:11.596] refactoring. And this is problematic
[09:13.530] because it's adversarial. Basically, we're
[09:16.643] blaming the business for rushing us and
[09:18.440] telling them that "no, we need to go
[09:20.312] slower. We need to do 'our stuff' now"
[09:21.720] It erodes the business's trust in the team
[09:24.801] because they're paying us a lot of money
[09:26.850] to write code and if the message that
[09:29.361] we're sending them is that we're so bad at
[09:31.065] it that we have to stop and fix it every
[09:32.680] now and then, they're going to think that
[09:34.684] we're less competent at our jobs. So yeah,
[09:38.581] refactoring is hard to sell. We're all
[09:40.755] programmers, we all believe in it, but
[09:42.971] we're probably not going to successfully
[09:44.840] change the culture today. So that's
[09:48.484] probably not where the solution is in the
[09:50.425] short-term. If we look at the other axis,
[09:53.247] why is refactoring so expensive? Well,
[09:56.868] whenever I refactor code I feel a lot of
[09:59.371] pressure. There's a lot that I have to
[10:01.465] keep in my head at once. I have to get
[10:04.867] a lot done, but in a short amount of time
[10:06.672] because other people are waiting on me to
[10:09.851] maybe merge in my changes; because it's
[10:12.483] low-priority so it doesn't get afforded
[10:14.865] very much time to work on it. And my tools
[10:18.862] in general, we don't have a lot of tools
[10:20.797] that help us refactor code. Most open
[10:22.031] source tooling is about creating new stuff
[10:24.022] because that's more exciting and that's
[10:25.296] what we want to think programming is, but
[10:27.943] most of us are getting paid to maintain
[10:29.525] old code, so you'd think we'd have better
[10:31.872] refactoring tools, and we just don't. So
[10:35.656] for me refactoring is very scary, and I'm
[10:38.096] on a mission to find everything that's
[10:40.034] scary about software and try to find a way
[10:42.624] to make it less scary, because I'm so
[10:44.430] anxious and scared all the time. In fact,
[10:47.808] if you're like me and you're scared all
[10:49.899] the time you should buy my book that I'm
[10:51.665] working on, it's called "The Frightened
[10:53.314] Programmer". It's not a real book, because
[10:56.981] I'm too afraid to write a book. So what
[11:01.029] can we do to make refactoring less
[11:03.611] expensive? Well, we do a few things
[11:06.421] already. Like this book by Martin Fowler,
[11:08.637] Jay Fields. And they're explicit
[11:13.920] operations like "extract method" or "pull
[11:16.464] up", "push down", or "split loop". They
[11:19.315] have names, because if you follow the
[11:21.242] procedure carefully enough, it's safe to
[11:24.069] undergo certain refactoring operations
[11:27.196] And it's safer still if you have good
[11:29.030] tools. Easily my favorite thing about
[11:32.105] Java programming language is that with
[11:34.029] Java, it's so not-expressive, that you're
[11:36.539] able to get all these automated
[11:38.172] refactoring tools in your IDE with a
[11:40.453] relative guarantee that you're not going
[11:42.280] to break anything. But they're also not
[11:46.568] very expressive of operations, either. You
[11:48.984] couldn't possibly take a complex design
[11:51.456] and then make it into a good design if
[11:53.665] you only follow that advice. If you only
[11:55.386] follow those operations. Second, a
[11:58.294] technique called characterization testing
[12:00.161] was made popular in the book "Working
[12:02.399] Effectively with Legacy Code" by Michael
[12:03.953] Feathers. And that's still, I think, the
[12:05.525] best advice a lot of people have about
[12:08.970] legacy rescue. Basically, you treat the
[12:12.336] code as a black box. And then you put a
[12:15.601] test harness around it, and you send it
[12:17.339] some input and you get back an output.
[12:18.713] You send an input. You get back an output.
[12:20.647] You send all the inputs that you can
[12:22.719] imagine into the black box and you just
[12:24.671] record the output no matter what it is
[12:26.257] without understanding, without judgment
[12:28.544] There's not wrong answers. The goal is
[12:30.856] simply to create a harness by which you're
[12:34.515] pretty sure that if you change stuff, as
[12:36.911] long as the test passes, the change was
[12:38.463] safe. Once you zoom in and you have that
[12:42.064] test harness, then you can begin to
[12:43.406] aggressively refactor the code into new
[12:45.687] units and new objects and then when you're
[12:48.124] done with that, you can backfill in new
[12:50.161] unit tests that can understand what the
[12:52.514] code is doing and that can have clear
[12:53.902] intention behind them. And that's a lot
[12:56.991] of testing, right? We have to write all
[12:58.765] these characterization tests, that takes
[13:00.565] a lot of time; we have to write new units
[13:02.000] and then we have to write tests for those,
[13:03.224] that's a lot of work. And the next step
[13:05.543] is actually to delete a test. After we're
[13:07.899] done with the refactor, we're supposed to
[13:09.597] delete our characterization tests, but if
[13:11.992] you have a lot of legacy code in your
[13:14.446] codebase, you probably want all the code
[13:16.863] coverage you can get and if you just spent
[13:18.898] a lot of time on a test, the last thing
[13:21.117] you're going to want to do is delete it
[13:22.673] And it's tempting to quit halfway through
[13:25.786] because it's a time-consuming, exhausting
[13:27.865] process, and that's not good. More
[13:29.492] recently, a technique has been popular
[13:33.791] with legacy rescue that resembles A/B
[13:36.363] testing. Basically, if you have the old
[13:38.802] code over here and you write a new
[13:40.735] implementation over here, then you just
[13:44.368] put a router in front of it. Maybe you
[13:46.427] send 20% of the traffic to the new code
[13:48.190] 80% to the old code. I think her name is
[13:54.091] Jesse Toth, I think she's here today.
[13:56.074] Jesse, are you here? Yeah! There's Jesse
[13:59.227] Jesse's working on this awesome gem from
[14:01.456] GItHub called Scientist and what it
[14:03.533] requires is you're on-your-own for how you
[14:10.913] rewrite that new code path and a lot of
[14:14.810] sophisticated monitoring and logging and
[14:16.857] data collection that scientist produces is
[14:19.027] necessary to figure out whether or not the
[14:21.442] changes are safe. And finally, it's only
[14:24.289] really appropriate for business domains
[14:26.600] where it's safe for transactions to fail
[14:28.854] It might work for GitHub, but it may not
[14:31.683] work for a bank that's handling financial
[14:34.668] transactions. So if you think of it as a
[14:37.692] spectrum on one end with characterization
[14:40.448] testing on one end and scientist on the
[14:42.833] other end, you can look at Michael
[14:45.132] Feathers' book and say that's good for
[14:46.798] development, it's kind of painful for
[14:48.302] testing, and it has no solution for
[14:50.685] staging or production environments. If you
[14:53.531] look at Scientist on the other side, it
[14:56.139] doesn't have a lot to say about
[14:57.758] development or local testing, it's really
[15:00.800] obviously beneficial for a staging
[15:02.958] environment, and if anything in production
[15:05.269] the amount of data that it produces is
[15:07.471] overwhelming, it's really cool. But what
[15:09.952] if we had a tool that was actually good at
[15:13.352] all four stages of the life of a refactor
[15:16.474] from planning to completion and what would
[15:20.304] that look like? And so that was the
[15:22.917] question that I posed to myself when I
[15:24.549] submitted to speak at this conference
[15:27.256] And then months passed by and I still had
[15:29.113] no good answer and eventually I said "Oh
[15:31.261] no, I have to give a talk on this" and
[15:32.562] being frightened, like usual, I thought
[15:37.527] about it and thought about it and I had an
[15:40.994] idea and I decided that instead of writing
[15:43.123] a lot of slides today explaining how to
[15:45.339] refactor well, I'll just write a new gem,
[15:47.862] because even though I speak English and
[15:50.671] my English may be hard to understand, our
[15:53.304] common language is Ruby and so let's talk
[15:55.781] about Ruby for the rest of the talk. I
[15:58.462] used TDD, so this is a TDD talk. Based on
[16:04.074] that explanation, TDD stands for
[16:05.938] "Talk-Driven Development"
[16:10.112] I like this practice, I'm going to try to
[16:11.967] rely on it more. The tool that I wrote is
[16:15.465] a new gem called Suture. Sutures are the
[16:17.844] stitches that you make when you're closing
[16:20.264] a wound after a surgery, so I think it's
[16:24.340] a good image for surgical refactoring,
[16:27.485] it's up on our GitHub at @testdouble, up
[16:30.558] here; the page looks like this. You can
[16:34.590] install the gem, just like any other gem
[16:37.263] You know how to install gems, I'm sure
[16:39.251] The metaphor here is to treat refactors
[16:41.743] like surgeries. Now surgeries, they all
[16:45.280] serve a common purpose—to help us get well
[16:48.223] We want to take a scary thing, and make it
[16:50.648] feel safe. They require careful, up-front
[16:53.542] planning. They require flexible tools
[16:57.121] Because, you can imagine, this refactor is
[17:00.264] going to be loaded with roughly the same
[17:02.873] information and that same information can
[17:04.510] be used to make development, test, staging
[17:06.297] and production all easier. And we want to
[17:09.880] follow a consistent process, because there
[17:11.859] are already more than enough variables in
[17:13.913] all of our legacy code, because it can
[17:15.519] look all sorts of different ways. So if we
[17:17.695] make the process consistent, then we can
[17:19.615] feel a little better. And we take multiple
[17:22.608] observations. Initially, we need to be
[17:25.292] very up-close to our refactor, but after
[17:28.109] we've initially developed it, we can step
[17:29.821] further back and eventually just assess
[17:31.858] based on logging the health of the
[17:33.482] refactor before we've decided that it's
[17:35.574] complete. So we're going to talk about 9
[17:38.356] features or workflow steps that are
[17:41.150] built into Suture. First, how to plan.
[17:43.665] Second, how to identify a seam that we're
[17:47.058] going to cut. Third, how to record the
[17:49.922] interactions of the old code path and then
[17:54.775] how to automatically in a test environment
[17:57.418] validate that we're able to reproduce all
[17:59.702] of those recordings. Finally, we get to
[18:01.765] refactor the code (or reimplement it).
[18:04.001] Then we verify that the new refactor
[18:08.336] behaves the same way against the same
[18:10.125] recordings. In a staging environment, we
[18:12.743] can compare that both the old and new code
[18:14.761] paths behave the same way, even if they're
[18:18.045] getting input that's different from what
[18:19.705] we've gotten before. And in production, we
[18:21.942] can use the same information as a fallback
[18:24.398] mechanism to rescue any errors in the new
[18:26.703] code that we didn't otherwise anticipate
[18:29.862] Finally, the last step of Suture is to
[18:32.303] delete Suture. Just like you have stitches
[18:35.309] removed, Suture shouldn't be in your
[18:38.138] Gemfile forever, only when you're doing a
[18:40.039] legacy rescue.
[18:41.396] So, a little about planing. Today in this
[18:44.811] exercise, we're going to do two bug fixes
[18:47.500] The first bug fix is we have a calculator
[18:50.154] service and this calculator service has an
[18:53.136] add route but it doesn't add negative
[18:56.920] numbers correctly. It's a pure function
[18:59.366] so if you look at this controller method,
[19:01.784] we create a calculator, we call add with
[19:04.157] two operands, and then we set it to result
[19:06.241] Just like a Rails controller method
[19:09.047] If you look at the implementation, you can
[19:11.972] see we've got the declaration of the
[19:14.942] function and then for whatever number of
[19:17.023] times, the right operand is, like 8 times
[19:20.434] it'll loop over 8 times add 1 to the left
[19:24.514] and return the left, now that's where the
[19:27.669] bug is obviously because it's only
[19:29.487] positive. And yeah, this legacy code is
[19:31.996] really ugly, but I'm sure your legacy code
[19:34.993] is really ugly, too, so that's the idea
[19:38.102] So if we zoom back out, we're going to
[19:41.892] create our seam here. This is going to be
[19:44.660] the point at which we want to branch
[19:46.821] between the new code and the old code
[19:48.757] because it's the call-site, it's the most
[19:50.415] common-sense place for us to cut it. The
[19:53.269] next one, from a planning perspective, the
[19:55.882] next bug is: we have a tally service where
[19:59.421] we can invoke the calculator multiple
[20:03.111] times and then ask it what the total sum
[20:04.738] of all the numbers that we called it with
[20:05.864] was. And this is a different type of
[20:07.997] function, because it's going to require
[20:09.172] mutation of an object over time. Here's
[20:11.981] what that method looks like; we again
[20:13.744] create a calculator and then over an array
[20:16.330] of numbers, for each of them we call a
[20:18.561] tally function. Finally, we take the total
[20:20.155] from the calculator and set it to the
[20:22.932] result. When we zoom in here, this is an
[20:25.865] even more ridiculous-looking function, we
[20:28.193] instantiate a @total instance variable,
[20:31.626] and then we count down from whatever was
[20:34.612] passed to 0, and if it happens to equal
[20:37.699] exactly half of what's sent, then we add
[20:40.687] double it, and this is really ugly, but
[20:44.134] it was a way to introduce the bug, right?
[20:46.070] So this will only work for even numbers,
[20:48.054] it'll have no effect if we pass it an odd
[20:50.332] number and we want to fix that, that's
[20:52.506] our story today, to fix that bug. We zoom
[20:54.700] back out, obviously that's our call-site
[20:58.006] just like before, but it's bigger than
[20:59.866] that, because we also depend on the value
[21:03.070] of that @total instance variable, and so
[21:06.003] this seam is going to be more complex
[21:07.558] It's going to require a little bit more
[21:09.571] work. Next, let's talk about how to cut
[21:13.383] those seams. So in the pure function case,
[21:17.224] what we do is we use Suture's API, so
[21:20.447] zooming out a little bit, instead of
[21:22.210] calling calc.add directly, we're going to
[21:23.892] create a Suture. We're going to say
[21:25.561] Suture.create a seam called :add, and
[21:28.591] then we're going to pass it the same
[21:29.698] arguments as an args option, as an array,
[21:32.361] and we're going to pass it a reference to
[21:34.855] the callable add method. Now, this could
[21:37.783] be any callable, it could be a lambda, a
[21:39.827] Proc, it could be a reference to a method
[21:41.986] like this, it doesn't matter as long as it
[21:43.682] can be called with `call`
[21:45.725] And at first, what I've just done here is
[21:48.182] a no-op; I'm going to write exactly this
[21:50.938] much and then go to the page and make sure
[21:52.436] that I did this correctly, but it's not
[21:54.515] going to take any further action, it's
[21:56.226] just going to call through like it
[21:57.444] normally would. In the mutation case,
[21:59.966] this is going to be more complicated. So
[22:02.641] let's zoom out again, give ourselves some
[22:04.396] space to work and I'm going to change that
[22:07.583] tally call to another Suture, creating
[22:09.086] :tally and the args here, I'm going to
[22:12.604] say are the calculator and the number, and
[22:14.680] you might say to yourself, "wait, tally
[22:17.244] just takes this one argument, how is that—
[22:18.864] —what's going on?" Well, to design a seam,
[22:22.103] we need to think in terms of the impact of
[22:23.933] the function. Pure functions are really
[22:26.474] easy, right? We treat them like a black
[22:28.413] box, we pass in a couple of arguments, we
[22:31.604] get a return value. We pass in the same
[22:34.891] couple of arguments, we know we're going
[22:36.635] to get the same value. They're repeatable
[22:38.594] input and output. And recording a bunch of
[22:40.844] those is going to be safe and make sense
[22:42.915] Mutation is a lot more difficult. In the
[22:46.199] case of this tally function, if I pass it
[22:48.083] 4, I get 4. But if I pass it 4 again, I'll
[22:50.706] get 8. And so if you think more broadly,
[22:53.231] it's because this instance variable is
[22:56.227] changing and so the real argument of this
[22:59.563] is two-fold. First, there's the calculator
[23:03.644] and what's the state of the calculator and
[23:05.439] then there's the number we're passing to
[23:07.667] it. And so if we fix both of those
[23:10.195] invocations to pass in the calculator at 0
[23:12.864] then we'll actually get back to a
[23:15.579] repeatable input and output. So if you
[23:16.888] think of it that way, we're just
[23:20.010] broadening the seam of the cut that we're
[23:21.883] going to make and here we're just going to
[23:23.833] pass an anonymous lambda, and in that
[23:26.200] lambda we're going to call tally on the
[23:28.398] calculator that gets passed in for the
[23:30.877] number that gets passed in , and then also
[23:32.766] we're explicitly returning the total so
[23:34.678] that we get a clear input and a clear
[23:36.994] output. That'll make our recordings more
[23:38.885] valuable. Once we've recorded we want to
[23:43.452] make sure—oh, excuse me, got ahead of
[23:45.610] myself—now we've got to record the
[23:47.332] interactions at the seams that we just
[23:51.469] made. So, in the pure function's case, all
[23:54.694] we have to do is add this option that says
[23:57.236] record_calls: true and because in legacy
[24:00.888] environments, often-times we might want to
[24:02.844] deploy code and not actually make code
[24:04.547] changes to our Ruby files, almost all of
[24:06.343] Suture's options can also be set with
[24:07.884] environment variables like this. And to
[24:11.560] record some calls, all we have to do is
[24:13.348] call the thing. You could use the command
[24:15.144] line. You could just set some params,
[24:17.607] call show, that's going to record an
[24:19.751] invocation. Set different params, call
[24:21.847] show, that'll record. And so on and so
[24:24.971] forth. You can also record via the browser
[24:27.250] if you've got a route, you can just go to
[24:29.681] the browser and keep refreshing the page,
[24:31.677] those will record as well. You can even,
[24:33.854] if you need to, you can record in a
[24:35.730] deployed environment like production and
[24:37.811] pull down both Suture's snapshot and a
[24:40.261] production snapshot to replay off of that
[24:43.325] for cases where you don't have a good
[24:45.572] solid reliable development database. Now
[24:49.746] in the case of the mutation, we're also
[24:52.285] going to set record_calls: true and
[24:54.028] because we already did the hard work of
[24:55.675] identifying a seam, it'll work the same
[24:57.514] way. We can set some parameters and call
[24:59.015] index. That'll record. We can set
[25:02.317] different parameters, call index, and
[25:03.916] repetitively do this to generate some
[25:06.534] recordings. Now, where do those recordings
[25:08.857] go? Well, by default, Suture is going to
[25:11.419] assume you have a database, a SQLite
[25:13.674] database, at db/suture.sqlite3 and you
[25:17.524] don't have to set this up. This is
[25:19.038] invisible to you. You'll just notice that
[25:21.151] a database shows up. You don't have to
[25:23.187] worry about the schema or calling it, it's
[25:24.913] just a place to save stuff. I did this
[25:27.406] because I heard Ruby was getting a
[25:28.709] database yesterday. Matz was talking about
[25:31.530] Ruby 3 and databases so I figured that
[25:34.175] was a good approach. All it really does
[25:37.085] is dumps—using Marshal.dump—the inputs and
[25:40.069] the outputs so we can record the calls.
[25:42.322] So you might ask yourself, "Does this
[25:44.681] scale? Does this work with Rails?" I was
[25:46.875] also curious about this, because I spent
[25:49.004] 100 hours on this gem before checking to
[25:50.810] see if I could use it with Rails. I'm
[25:54.299] going to look at an example, the Gilded
[25:55.938] Rose Kata, this is an exercise for
[25:58.013] practicing refactorings, it's up on Jim
[26:01.237] Weirich's GitHub, here. And here, I
[26:05.372] intentionally put it into a Rails
[26:08.038] controller, and you don't have to read it
[26:10.517] too closely other than to see this is a
[26:12.039] Suture that takes in items and returns
[26:13.705] items after they're updated. So I'm going
[26:17.096] to go to the page. This is the little page
[26:19.648] that I made. This repo, by the way, is
[26:21.023] inside of Suture's repository, and you're
[26:23.079] welcome to pull it down and play with it
[26:24.921] And obviously this is a beautiful web site
[26:27.576] but it's just there as an example. I'm
[26:29.845] going to create a few items. So here's a
[26:32.621] normal item, and another item, and a third
[26:34.053] item, and I'm going to put them in a table
[26:38.154] and then hit this Update Quality button,
[26:40.121] because that's going to invoke the
[26:42.211] function that I want to record. And you
[26:45.330] can see that the table changes, and if you
[26:48.181] look at the SQLite database, there's now
[26:51.206] a few invocations that have been recorded
[26:53.394] And I'll click the button again. And a
[26:54.869] couple more invocations. And if I click
[26:56.239] the button again, a couple more. I keep
[26:58.625] doing this to generate all of the
[27:00.185] different cases I want to get better test
[27:02.007] coverage. So yeah, Rails apparently works
[27:04.247] So that's cool. That's reassuring, because
[27:06.878] there's a lot of us who have legacy code
[27:08.119] have legacy Rails. Next, we have to take
[27:13.531] those recordings and validate that we can
[27:15.651] reproduce them. Otherwise, they won't have
[27:16.987] any value to us later. So in the case of
[27:18.325] the pure function, we're just going to
[27:19.872] write a little test. We're going to test
[27:21.786] that if we create a calculator, and then
[27:24.263] we call Suture.verify with the same name
[27:26.403] that we just recorded everything as, and
[27:29.421] then we pass it the subject method, which
[27:31.479] is the method under test—the old method in
[27:33.510] this case. Once we do that, it's going to
[27:36.824] load the database for that name and then
[27:38.758] go over each recorded call and compare the
[27:41.115] recorded arguments against the return
[27:43.499] value. You can think of it in terms of
[27:47.034] Michael Feathers' book. We just created a
[27:49.101] black box and put some characterization
[27:51.615] tests around it. And you get these tests
[27:54.662] basically, for free. Instead of writing a
[27:57.202] lot of tests, we can just write a few. In
[27:58.937] the case of the mutation, we write a very
[28:00.696] similar-looking test. So here, we pass it
[28:02.849] a lambda, called :tally and we return the
[28:06.445] @total. Note that we want to duplicate the
[28:09.303] lambda exactly, because it needs to behave
[28:11.773] just like the other one in order to work
[28:13.239] with the recordings.
[28:14.640] What's interesting about this is that it's
[28:16.900] actually a really good use for using a
[28:18.832] code coverage tool. So if you look at the
[28:21.415] Gilded Rose Kata, and you look at how Jim
[28:24.233] wrote the initial tests for it, this is
[28:26.674] the initial test file. He had to read all
[28:30.139] the code and then write hundreds of lines
[28:32.394] of tests, understanding all of it. And
[28:34.858] clearly he put a lot of investment into
[28:37.475] writing those test cases. That's a lot for
[28:40.048] a test that you're supposed to delete
[28:41.406] eventually. So, with Suture, you can take
[28:44.326] the exact same codebase and write a little
[28:47.423] test like this one. Pass it a lambda
[28:50.064] Items come in, items come out and Suture's
[28:53.936] smart enough to dump out the arguments at
[28:58.499] invocation-time and then dump them out
[29:00.586] again after invoking the function. Even
[29:02.873] though the items are just mutated here,
[29:05.210] these calls work fine. Additionally, we
[29:08.480] have a fail_fast option, normally it
[29:10.308] aggregates all your errors to give you
[29:11.973] good messages, but here if you expect all
[29:15.994] the recordings to pass, it'll fail fast,
[29:17.531] which is a little bit more performant,
[29:19.169] especially if you've got a lot of database
[29:20.609] interaction.
[29:22.687] Before we call it finished, we can check
[29:25.291] code coverage. If you look at the code
[29:27.168] coverage here, you can see that it's all
[29:28.898] green, but if there was a particular case
[29:30.851] that was yellow or red, I'd be able to
[29:32.466] read that, and then all I'd have to do to
[29:34.572] cover that with a test is to create an
[29:36.840] item that matched those conditions and
[29:39.074] record it. You can get 100% code coverage
[29:42.029] writing no tests at all, which is really
[29:44.266] pretty cool. Now comes the most important
[29:48.951] step, the center of the square. How to
[29:51.379] refactor the code. Unfortunately, I'm
[29:53.294] really bad at refactoring. I don't know
[29:55.439] anything about refactoring, really, it's
[29:57.232] not my forte. That's why I needed this
[30:00.170] tool, to make it more safe for me. If you
[30:02.358] want to learn about refactoring, my
[30:04.143] friends Sandi and Katrina wrote a book
[30:06.812] this year called "99 Bottles of Object-
[30:08.249] Oriented Programming" and it focuses a lot
[30:11.602] on refactoring techniques for Ruby. Unlike
[30:14.643] my book, this book actually exists! You
[30:18.235] can go buy it and enjoy it. In the case
[30:23.857] of the pure function, how we can refactor
[30:25.263] this—it's a simple method, right? It's
[30:26.768] adding. If we remind ourselves of what the
[30:30.017] bug was, which is that it doesn't work
[30:32.045] with negative values. Then we can create a
[30:34.140] new function and do the simple thing,
[30:36.426] right? left + right, that's all it really
[30:38.028] needs to do. We're going to do something
[30:40.048] else, as well. We're going to actually
[30:42.313] reproduce the bug. So we're going to
[30:44.620] return left if it's negative. We want to
[30:48.301] retain all of the behavior that it
[30:51.674] currently has, so it passes against all
[30:53.433] the recordings and the real reason we do
[30:55.645] that is we want to just change one thing
[30:57.037] at a time. We're here to refactor the code
[30:59.836] to prepare ourselves to fix the bug. We're
[31:02.690] not here to fix the bug yet. It would be
[31:05.739] arrogant to try to fix it now, because we
[31:07.794] honestly don't know where else in the
[31:10.284] system, it's actually depending on the
[31:12.624] unintended consequence of the bug. Right
[31:15.962] now we just want to make sure we can
[31:17.673] refactor it safely. In the case of the
[31:20.490] mutation function, you can see this is
[31:23.181] just a total mess, and remember that the
[31:25.250] bug is that it skips all of the odd values
[31:27.937] So we have to be thinking about that
[31:29.615] We're going to create a new tally function
[31:32.333] Here we instantiate the ivar, we add the
[31:35.441] number, and then we return nil, just
[31:38.408] because the other one returned nil, and
[31:40.907] we want it to behave as identically as
[31:42.256] possible. But we want to reproduce the bug
[31:45.001] so if it's an odd number, we'll just
[31:48.005] return as a short-circuit up at the top,
[31:50.340] with a FIXME to remind us that this is
[31:52.301] what we're here to change later. Kent Beck
[31:54.680] said, "make the change easy, then make the
[31:58.265] easy change." So that's the mindset of
[32:01.416] this kind of refactor step. And that's all
[32:03.940] we really have to do to refactor the code
[32:05.637] in this case. Verifying is interesting,
[32:08.270] because now we're going to use the same
[32:09.873] recordings against the new code. And in
[32:12.921] the case of the pure function, we write
[32:15.343] another test and that test is going to
[32:17.201] look exactly like the first test, except
[32:19.176] instead of calling the :add method, we're
[32:21.764] calling our :new_add method. And it just
[32:24.155] passed right away, because pure functions
[32:26.214] are easy—inputs and outputs. In the case
[32:28.722] of the mutation step, we have to again
[32:32.427] replicate the same kind of test, so call
[32:35.025] Suture.verify, we pass it the same-looking
[32:37.269] lambda and it fails. It fails because our
[32:42.407] refactor, actually, there was a bug in it
[32:43.805] So what's going on here? Well, speaking of
[32:47.689] I mentioned Jim Weirich earlier, before
[32:49.925] Jim passed, one of the things he taught me
[32:51.696] is that any library is only as good as its
[32:55.221] error messages are helpful, so I wanted to
[32:58.199] write very helpful error messages. So this
[33:01.470] is an example of one of Suture's error
[33:02.883] messages. It's going to, whenever a
[33:05.060] verification fails, print out a customized
[33:07.915] README to help you fix the bug that's in
[33:10.932] your code, including your progress to date
[33:14.030] If we look at it and we zoom in, the first
[33:16.874] thing it does is it lists out all of the
[33:18.500] failures, just like a test runner would
[33:20.072] and you can see here that it's got ideas
[33:24.008] to fix that thing underneath each one
[33:26.327] In the first case, there's a focus mode so
[33:29.016] you can just focus on one thing by setting
[33:30.874] this environment variable to the ID of
[33:32.679] that recording. Additionally, if you think
[33:34.806] that a particular recording was made in
[33:37.028] error, you can delete it from a console
[33:39.785] I wanted to give good advice about solving
[33:44.280] these failures, so there's advice at the
[33:46.179] bottom of the failures. The first one
[33:49.417] suggests that maybe you want to build a
[33:51.213] custom comparator to compare whether the
[33:53.647] old thing and the new thing's return
[33:55.402] values are comparable. To compare results
[33:58.566] by default, it's very simple. Suture just
[34:01.523] assumes that the thing on the left will
[34:03.726] pass a double-equals test against the
[34:05.434] thing on the right. Alternatively, if that
[34:08.104] fails, it'll also consider things
[34:10.320] equivalent if they Marshal.dump to the
[34:12.220] same string value. You might ask about
[34:15.373] ActiveRecord. It has some custom stuff
[34:18.763] in place in case that it detects that the
[34:20.658] two objects are ActiveRecord and
[34:22.184] essentially what it does is it compares
[34:23.826] their attribute hashes. There's some more
[34:25.744] to this and there's an option that you can
[34:27.962] exclude certain attributes if you want to
[34:29.705] I think by default it just skips
[34:32.057] created_at and updated_at
[34:35.608] But what if, even still, your two things
[34:36.993] don't equal each other? Well, that's not
[34:39.465] good, so I needed to create a way for you
[34:41.821] to have custom comparators. Here you can
[34:44.285] define a comparison however you like. So
[34:45.857] if you look at our calculator example
[34:47.909] Just pretend it had a lot of other fields
[34:50.122] that weren't very important for the
[34:51.885] purpose of our refactor. What we could do
[34:54.374] in the case of, say, maybe we returned
[34:56.366] calculator instead of just the total
[34:58.009] number, we could write a custom comparator
[35:00.077] that would take the recorded and the
[35:01.619] actual values and we would just simply,
[35:03.539] just as if you were writing a custom
[35:05.366] comparator in any other Ruby, or a custom
[35:08.139] equals method, just compare the total
[35:10.201] value between the two in order to get to
[35:12.220] a passing, working state. Classes are also
[35:16.045] a thing, so you don't have to use so many
[35:18.434] anonymous lambdas, you can also create
[35:20.880] your own class. You can even extend our
[35:22.900] default comparator. So you could call
[35:25.415] super and if it passes that, that's fine,
[35:27.306] otherwise call some custom logic. And then
[35:30.008] all you do is pass an instance of your
[35:31.759] comparator into the Suture. So going back
[35:35.150] to the error message, there's a little bit
[35:38.434] more here. All of the tests are run in
[35:39.752] random order by default, and it's got a
[35:41.801] generated seed, so the error will tell
[35:43.678] you what seed it ran at, just in case you
[35:45.666] come across something that was a bug that
[35:48.595] only happens in a particular ordering, you
[35:50.810] can lock it down. If you know you're in a
[35:53.934] situation where insertion order has to be
[35:55.630] the order you call everything in, you can
[35:57.559] also turn off the randomness by setting
[36:00.460] this to nil. And there's other
[36:02.819] configuration options too, and I wanted to
[36:04.420] make those discoverable. So the error will
[36:06.730] list off how this particular verification
[36:09.112] was configured. It'll tell you the
[36:10.847] comparator you're using, where the
[36:12.515] database is, whether you're failing fast
[36:14.331] you can limit things like how many calls
[36:16.554] you test, because maybe it's really slow
[36:18.337] or set an explicit time limit to only
[36:21.390] budget maybe 5 minutes in your build. You
[36:25.340] can also limit how many error messages get
[36:27.018] printed, because you don't need to see a
[36:28.499] thousand error messages typically and it
[36:30.534] will tell you what the random seed was.
[36:32.150] Finally, I wanted to give a sense of
[36:35.087] progress, because if you're refactoring
[36:36.623] something you expect it to always pass,
[36:38.366] but if you're going to reimplement
[36:39.694] something, you start from zero and slowly
[36:41.123] build up. If you look at the bottom, the
[36:43.851] result summary tells you how many passed
[36:45.562] how many failed, the number of total calls
[36:47.721] And a little progress bar at the bottom
[36:49.998] Selfishly, the reason I did this is that
[36:52.307] I wrote a progress bar gem 5 years ago and
[36:54.541] I never had a chance to use it, so this is
[36:56.913] the first thing that uses my progress bar
[36:58.745] gem and that made me pretty happy
[37:00.144] The idea is to give yourself a sense of
[37:03.330] progress over time. Again, I think it's
[37:06.621] really important and a takeaway from this
[37:09.153] talk to think about the messages that your
[37:10.898] gem produces. So all that to say, remember
[37:14.539] our test failed, right? Why did it fail?
[37:17.158] Let's look at the message now. In this
[37:19.263] case you can see expected returned value
[37:22.135] of 0, actual returned value was nil. And
[37:26.664] if you look at the calculator, it's state
[37:27.758] was nil as well. And this is the only case
[37:29.651] that failed. Let's look at our code. And
[37:31.608] what we realize looking at the code is
[37:33.601] that we're too aggressively returning if
[37:35.487] something's odd. In the case that we only
[37:38.293] call with odd stuff, @total never gets set
[37:40.336] so it's nil. The solution is simply to
[37:42.614] move this up to the top of the method and
[37:44.293] if we do that, the test passes. So in that
[37:47.554] case, the test was already a little bit
[37:49.749] useful to help guard against this refactor
[37:52.206] Once we've verified that the new code path
[37:56.778] behaves the same as the old code path with
[37:59.580] the data available to us, an interesting
[38:02.112] thought is what—in English we might call
[38:06.849] this "double-entry accounting"—you do it
[38:09.315] over in the new code path and then you do
[38:11.613] it over in the old code path to make sure
[38:13.127] that it's consistent. Remember, our
[38:15.748] mission here is to make development happy
[38:18.025] testing happy, staging happy, and also
[38:20.584] production happy. And our progress so far
[38:23.663] is that we've only really concerned
[38:25.637] ourselves with development, testing and
[38:27.287] we haven't yet addressed staging or
[38:29.539] production. If we look in the case of the
[38:31.991] pure function, all we have to do is add a
[38:33.957] little parameter called call_both and
[38:35.724] it'll call the new code, and then it'll
[38:38.578] call the old code and make sure that they
[38:40.975] return the same return value, otherwise
[38:42.698] it'll raise an error, which is usually
[38:44.322] safe to do in a staging environment. In
[38:47.558] this case, it just works. But you'll find
[38:50.527] that in practice, in staging and
[38:52.568] production environments, you tend to get
[38:54.338] a lot more interesting data than you can
[38:56.655] generate locally, so my hope is that this
[38:59.658] feature will be valuable to people who are
[39:01.667] trying to get something through a rigorous
[39:03.800] QA exercise. If we look at the mutation
[39:06.781] function, here we just set the same thing
[39:10.424] call_both, but unfortunately it doesn't
[39:13.502] work right away. We get another huge error
[39:15.865] message. This is a MismatchError, and if
[39:19.616] we zoom in, it's telling us that the
[39:22.178] calculator with total 2 and argument 2,
[39:24.726] the new code path returned 2 here, but
[39:27.135] the old code path returned 4. Why is that?
[39:31.825] If you look at it, it's because we're
[39:34.968] passing the calculator in and then
[39:36.301] changing the calculator, so there's an
[39:38.423] additional option when you know that
[39:39.873] you're mutating the arguments where you
[39:41.287] can dupe your arguments—clone them—before
[39:43.955] each invocation. This protects against arg
[39:46.177] mutation. So I set that and I think "OK,
[39:48.481] cool, this will work." But unfortunately,
[39:50.888] it still doesn't work, and the reason is
[39:53.051] now calc is never getting mutated, because
[39:56.281] we're just duping everything before every
[39:57.783] call, so we actually have to update our
[40:00.048] lambda or else total will always be nil
[40:02.482] So we zoom out and now we have to
[40:04.598] reassign calc inside of the lambda in each
[40:07.642] of these cases, and we get back to a
[40:09.316] working state. Now, this is a little ugly
[40:12.367] This is a lot of boiler-plate code
[40:15.420] configuring this thing. You have to
[40:17.457] remember, each of these modes is optional
[40:19.341] Maybe you only use Suture for one of its
[40:21.543] four uses, but keep in mind too that if
[40:24.688] you're genuinely dealing with some very
[40:26.741] nasty legacy code, you have to think of
[40:28.968] the trade-off of do you want to go slow-
[40:31.372] and-safe or is it okay to go a little bit
[40:34.194] faster and potentially make more errors?
[40:37.008] And that's a judgment call that you have
[40:38.725] to make. So that's what it's like in
[40:41.159] staging. In production, I want to be able
[40:44.736] to fall back. One of the reasons that
[40:47.302] refactoring is so unsafe-feeling is that
[40:50.122] I empathize with users. I don't want to
[40:53.069] make a change that's going to produce a
[40:54.953] bad result for people using my software
[40:56.806] What Suture does, is if the new path
[41:00.908] errors out, then you can just try the old
[41:03.968] one; it'll rescue to the old one. In the
[41:05.961] case of the pure function, I change
[41:07.341] call_both here because now I'm going into
[41:08.923] production, I'll set fallback_on_error to
[41:11.032] true. If :new ever raises an unexpected
[41:13.819] exception, it'll just call :old and return
[41:16.487] that instead, and it should be invisible
[41:18.609] to the user. And in this case, because
[41:22.542] this function works, it just works. In the
[41:23.931] mutation case, we already did the hard
[41:27.357] work in the last step to make sure that
[41:29.257] both these things can be called safely, so
[41:31.542] we just change call_both to
[41:33.730] fallback_on_error and that works as well
[41:35.380] Obviously, in production environments,
[41:38.882] it's going to be much faster to just call
[41:40.420] the new one most of the time than trying
[41:42.480] to call both every single time. And
[41:44.723] there's also going to be fewer side
[41:46.938] effects. There won't be any additional
[41:49.967] side effects, except for in exceptional
[41:51.198] cases. So, overall, it should be safer.
[41:53.448] If there's ever a rescued error, Suture
[41:56.967] has its own logging system built-in, and
[41:58.071] you can go check in production and see
[41:59.740] that there's not any logs about unexpected
[42:01.871] errors before you ultimately call your
[42:04.282] refactor "complete." Sometimes, code
[42:07.657] raises errors expectedly, so you can
[42:10.104] register certain error types as being
[42:12.388] expected. That way we'll know not to
[42:13.980] rescue them and we'll allow them to be
[42:15.480] propagated normally. That's about the
[42:18.513] production story. Now the last step is the
[42:20.691] most fun, because we get to delete all
[42:22.811] of my code, so just like stitches, we're
[42:25.744] going to remove Suture completely once the
[42:29.026] wound is healed, once we've decided that
[42:31.447] the refactor is complete. In the case of
[42:33.865] the pure function here, we can look at
[42:36.025] this little tiny test and unlike the
[42:37.924] really long test that I showed before, we
[42:40.094] feel completely fine blowing this away
[42:41.392] The next thing we do is we can open up a
[42:43.953] console and delete all of our recordings
[42:46.268] for that particular seam. And those just
[42:49.470] go away. And we look at our controller
[42:51.800] method and there's a lot of cruft here,
[42:53.588] but if you start looking at it more
[42:55.981] closely you can say "I can kill those two
[42:58.257] things, I can remove this option, I can
[43:00.625] remove all the parameters, and then just
[43:01.985] change this to the method and then shrink
[43:03.639] things back down to look normal again and
[43:06.161] now I'm done removing it from the first
[43:07.805] bug." In the case of the second
[43:10.650] function, it's the same thing, we can
[43:12.089] delete the tests safely, we can delete all
[43:14.784] of our recordings safely, and then—you
[43:16.440] know, this is really ugly here—we can
[43:18.541] start deleting all the stuff we wrote here
[43:20.842] eliminate that. Get rid of that whole
[43:23.419] broadening-the-seam wrapping that we did
[43:25.423] Then just return that and shrink it back
[43:28.217] down to a normal-looking function. So now
[43:31.335] We're pretty much done. We did it! We just
[43:34.519] went through a very very safe and rigorous
[43:35.878] approach this software and it was thanks
[43:38.024] to Ruby's dynamic nature that let us do it
[43:40.460] which I thought was pretty fun. Suture is
[43:44.849] ready to use. This is the first time I've
[43:47.445] ever written a gem and then not really
[43:50.268] shared it with anyone or worked with it
[43:52.868] with anyone prior to release, but as part
[43:56.654] of a talk, so I'd love for all of you to
[44:00.540] play with it and test it. The GitHub is
[44:02.449] again, at testdouble/suture. I've also
[44:06.334] declared today to be 1.0.0, so even though
[44:08.932] it has zero users, I'm going to keep this
[44:11.925] API stable going forward. And together if
[44:15.496] we work together on this, tools like
[44:17.554] Scientist, tools like Suture, different
[44:20.136] ways to think about it, we can make
[44:21.990] refactors less scary and I think that as
[44:25.034] part of the overall theme, we may be able
[44:27.647] to make Ruby more palatable for businesses
[44:30.259] to continue using longer-term, because
[44:32.711] we're making it easier to maintain legacy
[44:35.196] code and that's really important over the
[44:36.597] long lifespan of a language. There is one
[44:41.367] last thing I want to share. Just a little
[44:43.272] story about how I met Ruby. A long time
[44:47.672] ago when I was in college, I lived in Shiga
[44:49.908] prefecture, I lived in the city of Hikone
[44:53.706] If you don't know Hikone castle, then you
[44:57.526] might know Hikonyan. Maybe if you're not
[45:01.568] Japanese, you haven't seen this samurai
[45:03.020] cat mascot who's become synonymous with
[45:07.334] the city of Hikone. This is what Hikonyan
[45:10.396] looks like in person. If you go to Hikone,
[45:14.033] Hikonyan is everywhere. He's all over the
[45:16.483] place. I was in a homestay, and my
[45:22.830] homestay brother, he was a programmer, too
[45:24.541] He had a big bookshelf of Japanese
[45:25.958] techbooks and I thought that was pretty
[45:28.227] interesting. One of them was this year
[45:31.279] 2000 book, Programming Ruby, and I'd only
[45:33.931] just heard of Ruby, because it was still
[45:35.877] very new in America. It was fun to see, to
[45:38.668] flip through the pages of this really old
[45:39.970] book. Of something that I thought of as
[45:41.753] very new. And I talked to my friends back
[45:44.440] home and said "Hey look, there's this
[45:45.968] Ruby language, I'm having a lot of fun
[45:47.498] trying to learn it in Japanese." And they
[45:49.369] called back and said—this was right when
[45:50.938] Rails was 0.7 or 0.8—yeah, this is going
[45:55.731] to be the next big thing. It was a really
[45:57.003] cool experience to have as an American
[45:59.618] living in Japan. Eventually I went home
[46:01.872] and a lot of time passed. I've been doing
[46:04.504] a lot of Ruby and a lot of Rails for a
[46:05.941] long time now, but I have to say, getting
[46:08.559] to come back today to talk with all of you
[46:10.199] about my experience with Ruby is very
[46:13.529] precious to me, so I thank you very much
[46:15.851] for this opportunity. Everyone, thank you
[46:18.116] for the opportunity to share my story!
[46:21.551] I am overwhelmed with appreciation 💚
[46:27.110] Really, thank you very much!
[46:30.766] Again, my name is @searls on Twitter. I'd
[46:31.851] love if you followed me on Twitter, we
[46:33.255] could become friends. Tell me what you
[46:35.733] thought of the talk. I'm also, my wife &amp; I
[46:39.289] are going to be in Kansai all month. I
[46:42.061] think we go, we leave on October 3rd. So
[46:44.646] if you live in Kansai and you want to go
[46:45.937] for coffee or curry in Kyoto or Osaka, we
[46:49.108] would love to meet you.
[46:50.588] One more time, thank you!
[46:53.891] [Subtitles were sponsored by @testdouble]
</pre>

## Slides

This talk's slides are [available on
Speakerdeck](https://speakerdeck.com/searls/surgical-refactors):

<script async class="speakerdeck-embed" data-id="c0f8143c20a84d21815983a9d4e618cf" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

## Related resources

Here are links to a some of things I referenced in the talk, in roughly the order
they appear:

* [Yaboton misokatsu](http://www.english.yabaton.com)
* [Refactoring: Ruby Edition](https://www.amazon.com/Refactoring-Ruby-Addison-Wesley-Professional/dp/0321984137)
* [Eclipse's Java Refactoring Tools](http://help.eclipse.org/neon/index.jsp?topic=%2Forg.eclipse.jdt.doc.user%2Fconcepts%2Fconcept-refactoring.htm)
* [Working Effectively with Legacy Code](https://www.amazon.com/Working-Effectively-Legacy-Michael-Feathers/dp/0131177052)
* [Scientist](https://github.com/github/scientist)
* [Suture](https://github.com/testdouble/suture)
* [Jim Weirich](https://en.wikipedia.org/wiki/Jim_Weirich)
* [Gilded Rose Kata](https://github.com/jimweirich/gilded_rose_kata)
* [Hikone](https://en.wikipedia.org/wiki/Hikone,_Shiga)
* [Hikonyan](https://en.wikipedia.org/wiki/Hikonyan)
