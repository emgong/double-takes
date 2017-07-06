---
title: "Looking for Failure"
description: "An experiment exploring psychological biases to get better at dealing with failure"
author:
  name: "Steve Jackson"
  url: "https://twitter.com/stevejxsn"
video:
  url: "https://player.vimeo.com/video/217241625"
  type: "vimeo"
reddit: false
---

Failures are interesting. They tend to teach lasting personal lessons, but we
are loath to share them. These lessons have profound impacts on our habits
and viewpoints, but they're difficult to recount.  We need to get comfortable
talking about failure.  Unfortunately, our brains are wired to screw this up.
When confronted with a failure, we are conditioned to ignore it, make ourselves
blameless, or create elaborate strategies to avoid the possibility of failure
altogether. I’d like to present another alternative: embrace failure. It will
happen. That’s ok.

How can we challenge our natural human bias? I've spent the last couple years
digging into "pop" psychology and thinking about how books like "Thinking Fast
and Slow", "Antifragile", "Drive", "Blink", and "Outliers" apply in a software
development environment. I'm most excited about the idea that if we can make
failure "safe" then we can use it to learn things that we would otherwise be
tempted to avoid and ignore because it might go badly. A focus on failure, both
deliberate and accidental, has been beneficial in moving my projects beyond the
no defects, 100% test coverage type focus and towards finding innovative ways to
detect and quickly reverse failure.

The [video above](https://vimeo.com/217241625) was recorded at
[Agile and Beyond](http://agileandbeyond.com/2017/) on May 5, 2017.

## Transcript

A transcript of the presentation follows:

<pre class="transcript">
[00:00] The title of this talk is
[00:01] Looking for Failure
[00:03] My name is Steve Jackson
[00:04] I'm a Double Agent at Test Double
[00:06] Test Double's mission is
[00:07] to make software better
[00:09] so that naturally means we have to get
[00:10] pretty comfortable with failure
[00:12] If you have any trouble with failure
[00:14] and want to get in touch with us
[00:16] you can email us at hello@testdouble.com
[00:18] We might be able to help
[00:19] This is my personal twitter, @stevejxsn
[00:21] and it's spelled weird
[00:22] because it's really common, right?
[00:24] And then my email, steve@testdouble.com
[00:26] I'm interested in this topic of failure
[00:28] and seeing if it's resonating with people.
[00:32] I'd like to get a conversation started
[00:33] around with this
[00:34] If any of this makes sense to you
[00:35] and you want to share your story
[00:37] I'd love to hear it
[00:39] I love this quote from Thomas Edison
[00:41] It really embodies that
[00:44] ideal of innovation to me
[00:46] That if you just keep pushing
[00:47] if you just keep trying
[00:49] you'll get past all your failures
[00:50] and eventually be a success
[00:52] That's not what this talk is about
[00:55] This is not a talk about perseverance
[00:58] This is a talk about identifying failure early
[01:00] looking it straight in the face
[01:02] and stepping into it anyway
[01:06] What sort of things happen when you look to fail?
[01:10] So I'm a big believer in the Law of Two Feet.
[01:11] I want everyone to get as much value
[01:13] as they can out of this conference.
[01:14] So, what this talk is about
[01:16] is we're going to talk about failure
[01:18] as a learning aid and how we can use it effectively
[01:21] or how it could be used effectively
[01:24] I'm going to talk about some of the reasons
[01:25] why it's difficult to use failure effectively
[01:28] and all the different biases we have in place
[01:30] that make that really hard
[01:32] I'm going to talk about some hypotheses
[01:34] that I'm actively testing to get myself
[01:36] better at dealing with failure
[01:38] And then, I wanna kind of close talking
[01:40] about how we can make it safe
[01:41] for other people to fail and
[01:42] some things maybe we should think about
[01:46] So, we're kinda raised from a young age
[01:48] to believe that if you're getting up early
[01:50] you're doing all your homework
[01:51] you're helping the old ladies across the street
[01:54] eventually you'll be successful
[01:56] But, if you're watching too much TV
[01:58] and doing drugs
[01:59] and hanging out with the wrong crowd
[02:01] You're doomed. No chance
[02:03] We see success as this linear thing
[02:05] We assume that anyone that was successful
[02:07] obviously was successful their entire life
[02:09] and it's just kind of this
[02:10] wonderful golden path
[02:12] But it completely
[02:14] contradicts our own experiences
[02:15] We know we have ups and downs
[02:17] and good days and bad days
[02:18] and that's how the world works
[02:22] Objectively, success and failure
[02:24] are just the effects
[02:25] of an action or a non-action that we take
[02:29] If the effect is positive, we call that success
[02:32] If the effect is negative, we call that failure
[02:35] It's just feedback
[02:38] I got this from Jurgen Appelo
[02:40] This is his Celebration Grid
[02:42] And what I really like about it
[02:44] is it takes these two binary outcomes
[02:45] of success and failure and points out
[02:47] that your mindset and your intent do matter
[02:50] So up at the top here, we have
[02:51] when you're successful by mistake
[02:54] You're "Wow, I managed to get lucky
[02:56] and pull that off anyway"
[02:57] And this is pointing out that there's really
[02:59] not much to celebrate there
[03:01] It wasn't through any particular amazing skill
[03:03] that you did that
[03:04] And then underneath we have your
[03:05] garden-variety failures that we regret
[03:07] and obsess about for the rest of our lives
[03:11] In the middle, if we're in an
[03:13] experimental mindset here
[03:14] then either success or failure are fine
[03:16] We're in a mindset where we can learn
[03:18] So, either way we can find something
[03:20] to celebrate in that
[03:22] We didn't do exactly what we thought
[03:23] but we learned from it and it was good
[03:26] In this last column we have this idea of practices
[03:29] If you succeed by doing the right things
[03:31] then you should celebrate that
[03:32] That's great!
[03:33] But if you don't succeed while doing the
[03:35] right things, well that's just the opposite
[03:37] of that other good luck
[03:38] That's just bad luck
[03:40] And maybe we shouldn't be
[03:41] so down about that
[03:42] Now where I would differ a little bit
[03:43] from the Celebration Grid is
[03:44] I think there is value in these other
[03:46] two types of failure
[03:47] So I'm going to talk about that
[03:49] a little bit more
[03:50] But if you're interested
[03:51] in this sort of thing
[03:52] this comes from Workout
[03:53] This is a great book
[03:55] lots of nice visualizations about working
[03:56] with teams and improving
[03:59] the way that you work
[04:03] Failures are interesting to me
[04:05] They have a certain amount of stickiness
[04:09] that success doesn't seem to have
[04:11] When I succeed at something
[04:12] I immediately look to the next thing
[04:14] I have to do
[04:15] It's a very temporary feeling
[04:16] But a failure, man
[04:17] I can sit there and think about that for awhile
[04:20] Think about that stupid thing
[04:21] I did back in high school. Right?
[04:23] I'll see someone that's successful
[04:26] and you might try to copy their success
[04:28] You want to emulate them
[04:30] But we often miss something in the middle
[04:32] Because again, our brains just assume
[04:33] It's a linear path
[04:34] So we miss the struggle and the growth
[04:36] that they had to go through to get there
[04:39] But, we're really, really good
[04:41] at pointing out other people's mistakes
[04:43] Everyone's like, yes, obviously Mr. Stormtrooper
[04:46] You should check the wash for the red sock
[04:48] We all know that
[04:49] We've all learned that lesson before
[04:52] Successes don't teach us a whole lot
[04:54] except that success is possible
[04:56] But what happens when you fail?
[04:57] You reduce your overconfidence
[05:00] You start rethinking your strategy
[05:02] You question your assumptions
[05:04] You want to redeem yourself
[05:05] You engage
[05:07] You start paying attention
[05:09] Video games have an interesting
[05:11] relationship with failure
[05:14] It's not until you fail that you
[05:15] understand how to play the game
[05:17] I have to go and touch that turtle
[05:18] to find out he's not my friend
[05:20] and I shouldn't do that in this game
[05:22] But what's more interesting to me
[05:24] is that video games have different
[05:25] difficultly levels
[05:26] Now if the point of playing the game
[05:28] is to win
[05:28] Why would you play
[05:29] at anything but the easiest level?
[05:32] And I can imagine, well ok
[05:33] maybe it's not very much fun
[05:34] so we need different levels to
[05:35] challenge you a little bit more.
[05:37] Maybe that makes sense
[05:39] But what I find interesting is
[05:40] a lot of players who play a lot of games
[05:42] start on the hardest level
[05:44] The hardest difficulty level
[05:45] Why is that?
[05:47] What I think it is, is that at easier stages
[05:50] you can succeed by mistake more often
[05:53] You just kinda get by and don't know why
[05:55] But when you play on the harder levels
[05:57] your mistakes are punished more harshly
[05:59] And it's through these mistakes
[06:01] it's through these failures
[06:02] that the right way to play the game
[06:04] is revealed to you.
[06:06] And you learn it much sooner
[06:07] than at the end of the game
[06:10] Now you might say, well that's
[06:12] kind of interesting
[06:13] Maybe I want to look at treating my life
[06:16] like a video game
[06:17] Maybe I want to try to fail fast
[06:18] and get that feedback
[06:19] and use that effectively
[06:21] That's sounds great
[06:22] But unfortunately, we have this problem
[06:24] Our psychology has evolved over the years
[06:27] over the eons to really
[06:29] really dislike failure
[06:31] Because failure used to mean that
[06:33] you were going to get eaten by a tiger
[06:35] So we want to stay
[06:36] very, very, very far away from that
[06:38] We try to stay far away from failure
[06:40] We don't want to deal with it.
[06:42] So there are basically four ways
[06:44] that we treat failure
[06:46] The first one is that we ignore it
[06:50] This is considered a positive thing
[06:52] in basketball, we call this
[06:53] the shooter's mentality
[06:55] Every shot I take is going in
[06:57] I don't ever think about
[06:58] the ones that don't go in
[06:59] We all want to be like Swaggy P here
[07:01] Of course! Money. Every time.
[07:05] And it's common
[07:06] When someone asks you about something and
[07:08] you felt like it was a success
[07:09] and you recount it:
[07:10] Like if you asked me about that
[07:11] angular project, I'll be like -
[07:13] Yeah, we did these cool filterings
[07:14] and our users were delighted about the way
[07:16] we could re-arrange these things
[07:17] We wrote these cool custom directives.
[07:20] And I'll just kind of forget to mention
[07:22] the days I spent
[07:23] debugging lifecycle problems
[07:25] and camel casing attributes
[07:26] and all these other things
[07:28] Our brain just kind of lets those
[07:29] slip from your mind
[07:33] The second thing we'll do
[07:34] is we'll reframe our failure
[07:36] so that it's actually a success
[07:38] We'll lower the bar
[07:40] So as an example
[07:42] say I decide to go running this morning
[07:44] I get my shoes on, I get out the door
[07:46] Get down the road
[07:47] get about 10 minutes in
[07:48] And I hurt. I'm tired. It is cold.
[07:53] I'm going to turn around and go home
[07:55] you know?
[07:56] Then I get to the end of the day
[07:57] I get to my calendar and I have this
[07:59] successive days worked out.
[08:00] I'm like on 70
[08:02] And I'm just going to check today off
[08:04] I got outside, I exercised, I tried
[08:07] And I do this like subconsciously
[08:09] I don't really reflect
[08:10] If I stopped and thought about it
[08:12] I would be like, well my
[08:13] intent was to run five miles today
[08:15] I barely made it one
[08:19] The third thing we'll do
[08:20] if we fail, is deflect
[08:22] We'll find somebody else to blame it on
[08:23] That's usually convenient
[08:25] Or, just as commonly
[08:27] our ego will step in and protect us
[08:29] And then we'll say
[08:30] other people might be able to do that thing
[08:32] but I can't do that
[08:33] I'm not an art person, you can't
[08:35] I can't design that
[08:36] Of course it didn't go well
[08:38] I'm not a people person
[08:40] Why am I talking to customers?
[08:42] That makes no sense
[08:43] I'm not a morning person
[08:44] Why am I up at 7 o'clock in the morning?
[08:46] That's crazy
[08:49] The fourth thing we'll do
[08:50] is we'll try to avoid the failure
[08:52] This gets kind of positive
[08:54] This is were we actually start
[08:56] getting constructive with our failure
[08:58] So we'll come up with strategies
[09:00] When my son was in kindergarten
[09:02] he had to be at school at 7:30 every day
[09:04] It was on my way to work
[09:06] and it was about 20 minutes away
[09:07] so it made sense that I'd get him ready
[09:09] and we'd go
[09:10] So, you know, I've got to get up
[09:11] I got to get ready, got to get him ready
[09:13] got to have breakfast, got to have lunches
[09:14] got to go shovel the driveway
[09:15] All that stuff to make sure
[09:17] we can get to school on time
[09:19] So naturally, I start thinking about ways
[09:20] Well I don't want to be late so
[09:21] I have to get up early
[09:22] So I'll set an alarm here
[09:24] And I'll put my phone across the room
[09:26] And I'll have another alarm there
[09:28] Maybe I'll get stuff ready
[09:29] I've got all these plans to make sure
[09:31] I don't hit that failure
[09:34] I'd like to suggest that maybe
[09:36] there is a 5th option
[09:38] I will fail
[09:40] At least some of the time
[09:43] I don't like that
[09:44] I don't want to say that
[09:47] But, if I start to accept that a little bit
[09:49] an interesting thing starts to happen
[09:51] I start thinking about contingencies
[09:53] Ok, if I fail to get up in the morning
[09:56] What do I do?
[09:57] Am I going to call my kid off of school?
[09:59] Or, maybe I'll decide to drop everything
[10:01] I get him to school, and then
[10:03] I'll come back and get myself ready
[10:05] Or maybe more interestingly
[10:07] I'll decide to change the rules of the game
[10:09] If I can't win
[10:10] I don't want to play that game
[10:12] So instead, maybe I'll find somebody
[10:14] to drive my kid to school
[10:15] Or maybe the problem is getting a
[10:17] five year old ready in the morning
[10:18] I'll hire a nanny to come help with that
[10:20] Maybe I'll decide that we should move!
[10:24] Or switch schools. I mean, 7:30?
[10:26] That's not reasonable!
[10:28] Maybe I'll decide to switch jobs
[10:30] so I don't have to be work until noon.
[10:31] And now it doesn't matter anymore
[10:33] It's no big deal
[10:34] All these options and opportunities
[10:36] don't really occur to me until
[10:38] I accept that I can fail
[10:41] Superhuman effort won't just get me
[10:43] through every time
[10:46] It's just this changing of perspective
[10:49] Switching the lens a little bit
[10:51] opens up new opportunities
[10:54] I learned this technique from Gary Klein
[10:56] This is the premortem
[10:57] How this works is
[10:58] He suggests that if you've had a hard time
[11:00] coming to a group decision
[11:01] You finally come to something and you have
[11:04] a plan in place, here's what he suggests:
[11:07] Imagine it's a year in the future
[11:09] We have executed the plan
[11:10] exactly as we intended
[11:12] And it's gone terribly
[11:15] We've pushed United Airlines
[11:16] out of the spotlight
[11:18] We are the front page of the New York Times
[11:21] What does that newspaper article look like?
[11:26] That's when you start thinking
[11:28] about these things
[11:29] How can it actually go wrong?
[11:31] Our default as humans
[11:32] is to always be optimistic
[11:34] If I'm involved, it's going to go well
[11:37] And this changes that a little bit
[11:39] It also gives you an opportunity
[11:40] There are probably some
[11:41] misgivings about this plan
[11:42] Now they will emerge naturally
[11:44] Ah, that was the thing I was worried about
[11:46] But this can be hard for teams
[11:48] People don't like to be negative
[11:49] especially out of the box
[11:51] So another useful tip is Six Thinking Hats
[11:53] You will come at the problem from a
[11:55] number of different perspectives
[11:57] and kind of try out different things
[11:59] But again, it's just really about changing
[12:01] your perspective a little bit to let in
[12:03] some more options and opportunities
[12:07] So, I don't like failure
[12:08] but I think there's some value
[12:10] in getting better at it
[12:12] So I'm working through some hypotheses
[12:14] And I'm trying to experiment on these
[12:16] and see how they work
[12:17] and how they feel for me
[12:19] The first one is around this
[12:20] idea of Regret Avoidance
[12:22] I learned about regret avoidance
[12:24] from Daniel Kahneman's book
[12:25] Thinking Fast and Slow
[12:27] This is an excellent book
[12:28] if you're interested
[12:29] in finding out all the different ways that
[12:31] your brain is trying to trick you
[12:32] into thinking you're a rational person
[12:35] Very excellent
[12:36] What I realized is that regret avoidance
[12:38] is probably the number one thing
[12:39] that holds me back
[12:41] And here's how I think
[12:42] about regret avoidance
[12:43] So imagine I have
[12:45] 10,000 shares of Luigi stock
[12:47] But, I've decided, you know
[12:49] I want some Mario stock
[12:50] And it happens to be
[12:51] trading at the same price
[12:52] Has been for awhile
[12:53] But, you know, I want something different
[12:55] I want to find some Mario
[12:56] And I find out, hey Todd!
[12:58] Todd has some Mario stock.
[13:00] Hey Todd, would you like to trade with me?
[13:02] And Todd goes, Nah, you know I've had this
[13:04] I'm pretty happy with it
[13:05] It's cool. It's fine
[13:06] Oh Ok, Justin!
[13:08] I hear you have some Mario stock
[13:10] Would you be willing to trade with me?
[13:12] He says, "Sure"
[13:13] Great. Got what I wanted
[13:15] Everything's great
[13:17] Fast forward 2 weeks
[13:18] Luigi stock has gone through the roof
[13:21] It's google + Facebook, greatest IPO ever
[13:23] Justin is a billionaire!
[13:27] It's pretty obvious
[13:29] How does Justin feel right now?
[13:31] Two Thumbs Up
[13:32] He's a pretty happy guy
[13:33] How do Todd and I feel?
[13:36] Well, objectively we'd say we
[13:37] both should probably feel kinda sad
[13:40] We had an opportunity to be a billionaire
[13:42] And we're not
[13:44] But, almost everyone would agree
[13:46] that I should feel worse
[13:49] Because I took an action
[13:51] that put me into this situation
[13:54] Todd just stood pat
[13:57] And that's what regret avoidance is about
[13:59] Regret avoidance is when my aunt calls
[14:01] And I don't know if I want to answer it
[14:03] And I love my aunt!
[14:05] We have great conversations
[14:06] she's a wonderful person
[14:07] But every once in awhile
[14:09] she wants me to fix her computer
[14:11] And so...ummm...
[14:13] maybe I'll let it go to voicemail
[14:15] We'll see
[14:17] So how do I get past this?
[14:19] What I'm trying here is
[14:22] getting ready for failure
[14:24] Priming myself for this failure
[14:26] I've found that if I think something's
[14:28] going to really suck
[14:29] and then I do it anyway
[14:30] it's usually not so bad
[14:32] I can get used to it.
[14:34] Shortly after my son was born
[14:36] my wife and I had one of those
[14:37] rare opportunities to get out of the house
[14:39] for a few hours
[14:40] So we started driving around
[14:42] We come up to the movie theater
[14:44] GI Joe is playing
[14:46] Ok, we'll go see GI Joe
[14:49] I was a little trepidatious about this, maybe
[14:53] Like I knew this was going to be a bad movie
[14:56] And I really really loved GI Joe
[14:58] That's the highlight of my childhood
[15:00] was going to my friend's houses
[15:02] and playing GI Joe
[15:04] So we went and saw the movie
[15:06] And I was right!
[15:08] It was awful
[15:10] But we had such a good time!
[15:12] We cheezed it up, we laughed at
[15:13] all the terrible things they were doing
[15:15] And it was amazing
[15:17] And If I think about this objectively
[15:19] I should have a lot of regret around this
[15:21] This is the one movie we saw all year
[15:23] I wasted it on GI Joe
[15:24] Not Iron Man or any other good movie
[15:26] that came out that year
[15:29] The other place I turn for this
[15:31] is to science
[15:33] So we've all seen
[15:34] the scientific method before
[15:36] You make some observations
[15:37] form a hypothesis
[15:39] to explain those observations
[15:40] You experiment to test the hypothesis
[15:42] Then from those results you
[15:44] change your understanding
[15:45] maybe do more experimentation
[15:48] Lean Startup has really jumped
[15:49] all over this idea of doing
[15:51] hypotheses and experiments
[15:52] We're talking about it all the time
[15:54] So we'll have a hypothesis like:
[15:56] If we add feedback to the application
[15:58] it will help with user re-engagement
[16:01] So we run an experiment
[16:03] we'll add 5-star ratings
[16:05] We expect that 50% users will re-engage
[16:08] with the app in the next couple weeks
[16:10] And I've helped a number of startups
[16:12] work up and think through these experiments
[16:14] What I've found, almost universally
[16:16] is that we always craft the experiment
[16:18] to prove the hypothesis correct
[16:21] Which is the exact opposite of how
[16:23] science runs it's initial experiments
[16:26] You always try to prove the hypothesis wrong
[16:29] Because you don't want to spend
[16:31] the next several months, or years
[16:33] testing and re-testing and refining
[16:35] that hypothesis that has a flaw
[16:37] You want to find those faster
[16:39] You want to fail sooner
[16:40] And the place I'm most comfortable
[16:42] with this is in my development habits
[16:44] I like to do TDD
[16:45] I like to start with that failing test
[16:48] And I think about that as my
[16:49] control in the experiment
[16:51] The universe works the way I think it does
[16:54] And then
[16:55] using my powers of software mastery
[16:57] I change the universe
[17:00] and make my test pass
[17:02] And that feels really good
[17:04] And I'm perfectly
[17:05] comfortable with this failure
[17:07] I love these failures
[17:08] In fact, if these tests pass, I get scared
[17:10] The universe doesn't work the way
[17:12] I think it does
[17:13] and it's a weird and strange place
[17:15] I like these failures
[17:16] I'm fine with them
[17:17] Another place I think we could really
[17:20] embrace failure is around meetings
[17:23] Ok. so how many people in the room
[17:24] have attended a meeting where the
[17:27] key decision maker didn't show up?
[17:30] They're very busy people
[17:33] And in how many cases, did you go ahead
[17:35] and have the meeting anyway?
[17:38] This is common!
[17:39] We make excuses for this:
[17:40] We're going to help
[17:42] We'll get through some of the discussion now
[17:44] We might come to a consensus
[17:45] We won't have to do all this
[17:48] But it never works
[17:49] We end up rehashing the same
[17:50] exact conversation once we get
[17:51] the person in the room
[17:53] Or we rob them of the context they
[17:55] need to make a good decision
[17:56] She can't make a good decision
[17:58] because she doesn't have all the
[17:59] criteria in front of her
[18:01] So I'd like to suggest
[18:02] that if you're in charge of
[18:03] setting up meeting agendas
[18:04] maybe think about defining some
[18:06] failure criteria
[18:07] If you hit the failure criteria the
[18:09] meeting is over
[18:10] Now you can create success criteria too
[18:11] Nobody cares as long as the
[18:13] meeting ends sooner
[18:14] This is all good
[18:17] My next hypothesis is around this
[18:19] problem of reframing
[18:21] It happens so easily
[18:23] It's subconscious
[18:24] How do we keep this from happening?
[18:26] So my thought here is
[18:27] if I can get my goals out there
[18:29] I might be able to do something about it
[18:31] And so for this I steal from Adam Savage
[18:34] He had a great job with Mythbusters
[18:36] essentially blowing stuff up
[18:38] for our education
[18:40] And he says, the difference
[18:41] between screwing around
[18:42] and science is writing it down
[18:44] So, if I write down my goal
[18:46] it's harder for me to subconsciously
[18:48] change what the goal is
[18:50] Now I can still consciously do that
[18:52] That's fine
[18:53] I just don't want my brain
[18:54] doing weird stuff behind my back
[18:56] I want -
[18:56] Let's get up front about this, brain
[18:58] What we're trying to do here
[19:01] My third hypothesis was influenced by
[19:04] Nassim Taleb's book, Antifragile
[19:07] The way I think about that is like this
[19:10] So, for nine years
[19:13] I was a defense contractor
[19:15] and it was very important to us that
[19:17] we had robust systems
[19:18] They needed to handle all kinds of
[19:20] terrible conditions and pressure
[19:22] and everything else and work fine
[19:23] It was very important to us
[19:25] So we wrote in java
[19:27] And what we would do is catch exceptions
[19:29] and try to recover from them
[19:30] try to handle them
[19:31] So you'd be in situation where it's like
[19:33] Oh, I lost connection to the database
[19:36] Tis but a scratch!
[19:38] Oh, my navigation system
[19:40] doesn't have a GPS feed.
[19:42] It's just a flesh wound.
[19:44] Oh, had enough, eh?
[19:46] We spent a lot of time jumping
[19:47] through all kinds of hoops to keep
[19:49] this thing running no matter what
[19:52] We didn't want to let our users down
[19:55] Antifragile has this idea that the
[19:57] opposite of a fragile thing is not
[19:59] actually a robust thing
[20:01] It's an antifragile thing
[20:02] So a fragile thing is something
[20:04] like a wine glass
[20:05] Doesn't take a lot of pressure
[20:06] Doesn't take a lot of change
[20:07] Just a little tiny chip
[20:09] and it's worthless as an object now
[20:12] A robust thing is something like a stone
[20:14] You can throw a lot of things at it
[20:16] It's still stays a stone
[20:18] it's as useful as it ever was
[20:21] It's resilient to disorder
[20:23] But an antifragile thing actually
[20:24] gets stronger when disorder is applied
[20:27] And probably my favorite example
[20:29] from the book
[20:29] was the idea of building muscle
[20:31] When you work out
[20:32] you actually tear your muscle
[20:34] Small micro-tears
[20:36] You cause it to fail
[20:37] And it's from that failure that it
[20:39] grows back stronger than it was before
[20:42] And what's more is
[20:43] if you do not cause your muscles to fail
[20:44] they will atrophy and die
[20:47] This is a system that needs disorder
[20:49] it needs failure, to move forward
[20:52] And when I think about software systems
[20:54] I think about that system, where you fix
[20:57] this bug and this other one pops up
[20:59] And you fix this bug
[21:00] and now this one is over here
[21:01] And you're holding this thing
[21:03] and every time you touch it
[21:04] it seems to crumble in your hands
[21:05] And it's very fragile and terrible
[21:07] So naturally, we want to keep us from
[21:09] changing it
[21:10] So we create these things with
[21:12] change control boards and all this other
[21:13] stuff and that will make it robust, right?
[21:15] Because now we can't let any of the
[21:16] randomness and chaos and bad things
[21:18] into our system
[21:19] Everything will be fine
[21:21] But I feel like this way of thinking
[21:23] is doomed
[21:24] Software has to change
[21:27] Even if you manage to write bug-free
[21:30] perfect software the first time
[21:32] And I'm sure most of you have done that
[21:34] Even if you pull that off
[21:36] the world will change
[21:37] The expectations for your software
[21:40] will change
[21:41] You have to be able to change with it
[21:44] Software maintenance does not mean
[21:46] that your software works the exact same
[21:48] as it did last month
[21:50] If it did, it would be free
[21:52] Software maintenance means that it's
[21:54] at least as useful as it was last month
[21:57] And that requires change
[21:59] So it seems like we need to get better
[22:01] at this sort of thing
[22:03] But, it's easy for me
[22:04] to stand up here and say
[22:05] You know what guys
[22:06] We should fall all over the place
[22:08] We should add more chaos
[22:09] It's going to be great
[22:11] Trust me
[22:11] Who's behind me? Let's go!
[22:14] There are problems with this
[22:15] There are a lot of situations where it's hard
[22:18] to take on more negative things
[22:20] We have debt
[22:21] We feel very vulnerable
[22:24] If I'm barely making ends meet
[22:25] I don't want to talk to you about
[22:27] your startup idea
[22:28] That's terrifying
[22:30] If my system is one of those fragile systems
[22:32] and you want to introduce more failure to it?
[22:34] No. We're not doing that
[22:36] That doesn't sound good to me at all
[22:38] If I'm new to a team
[22:39] or If I've failed recently
[22:41] I'm not going to want to add
[22:42] more failure to my resume or my reputation
[22:46] It's not a good place to be
[22:48] So my thinking starts to shift
[22:50] How do we create safer failures?
[22:52] That don't feel as bad when we're
[22:54] feeling vulnerable?
[22:56] The obvious one here, for me
[22:58] seems to be that if you're gonna fail
[23:00] you would prefer to fail in the small
[23:02] Maybe get good at that
[23:04] and get to larger failures
[23:07] The engineering organization that
[23:09] I feel has really taken this to heart
[23:11] is Netflix
[23:12] They have these tools
[23:14] called the Simian Army
[23:15] Essentially what it does, there are
[23:17] various tools that will take out the
[23:19] things that your application
[23:20] or service depends on
[23:22] So they have things like
[23:23] Chaos Monkey that will take away
[23:25] your dependent services
[23:26] And you're supposed to stay running
[23:28] And by the way
[23:29] they run all this stuff in production
[23:30] They have Latency Monkey
[23:32] which will add time to the request
[23:34] and you still have to give a
[23:35] good user experience
[23:36] And they've built this into their products
[23:38] You know this is going to happen
[23:40] You expect this
[23:40] So they've gotten good enough with this
[23:42] that they have things like Chaos Kong now
[23:44] Which will take down your entire AWS region
[23:48] And Netflix is pretty reliable
[23:49] It works in a lot of places with not very
[23:51] good network infrastructure behind it
[23:55] For me personally
[23:56] This is about pushing out my comfort zone
[23:59] a little bit
[24:00] Like if I can screw up in front of my friends
[24:02] Maybe I can make a mistake in front of
[24:04] my coworkers
[24:06] Maybe I can mess up something
[24:07] for my client
[24:09] Eventually, maybe I can
[24:10] fall flat on my face
[24:11] in front of an audience
[24:14] And yes, as we add and invite
[24:17] more disorder and bad things
[24:18] into our lives bad things will happen
[24:21] But there's also the flip side of this
[24:23] There's good luck that comes with the bad
[24:25] And so, as we open ourselves up to these
[24:27] different opportunities and interactions
[24:29] we get good things
[24:31] I answer the phone
[24:32] and my aunt has playoff tickets
[24:34] Great!
[24:35] I'm glad I took that risk
[24:38] My next hypothesis is that if we can
[24:42] cause a failure to happen
[24:43] and then reverse it
[24:44] like we expect this to happen
[24:46] then maybe we can use those same techniques
[24:48] when the random failures
[24:49] that we don't expect happen
[24:51] Really what I'm talking about here is
[24:53] building undo into everything
[24:54] It's great to be able to just get back
[24:57] to a good state when you're in a bad place
[24:59] Either through undo buttons or
[25:00] git reset all the things
[25:02] Sounds pretty good
[25:03] And I feel like the place where
[25:05] we've really been pushing this forward
[25:06] is in the areas of continuous deployment
[25:08] and continuous delivery
[25:10] Where we're getting pretty good
[25:11] at putting small little experiments
[25:13] out there and trying them
[25:14] And seeing what happens
[25:15] And if they fail they're still kind of
[25:17] small and easy to reason about
[25:18] Rather than the huge mega-releases where
[25:20] we never knew what was going on
[25:22] And again, I'll pick on Netflix
[25:24] I learned about their deployment process
[25:26] a couple years ago
[25:27] Essentially you push a commit
[25:29] That causes a cluster to spin up
[25:31] in production with the new code
[25:33] Then the load balancer starts pushing
[25:34] some amount of traffic to the new code
[25:36] and if it goes well
[25:37] that becomes the new production
[25:39] That's great
[25:39] But if it goes badly
[25:40] it gets dropped out of the load balancer
[25:42] So it feels pretty safe to fail
[25:44] in this environment
[25:45] Your opportunity for screwing something up
[25:48] is pretty small and your infrastructure
[25:50] will save you
[25:52] The place where my brain really started to
[25:54] get twisted on this is when I learned
[25:55] about Erlang and OTP
[25:57] The Open Telecom Platform
[26:00] So the thing about Erlang is that it
[26:01] can run lots of little tiny processes
[26:04] Like millions of them on a tiny laptop
[26:07] And they startup super fast
[26:09] So Erlang has evolved a very different
[26:11] error handling strategy than C-based languages
[26:14] In C, we always try to deal with our errors
[26:16] In Erlang, you just let it go
[26:18] You let it fail
[26:19] You let it die
[26:20] And OTP immediately starts the same
[26:22] exact thing again
[26:24] So again
[26:25] it's very safe to fail in this environment
[26:27] And this twisted my brain
[26:29] because I've spent so much time
[26:31] thinking about recovering
[26:32] from these bad things
[26:33] and How do we handle this?
[26:35] What do we do now?
[26:36] Just let it fail
[26:37] OK
[26:39] We're really trying to get to the point
[26:41] where failure is a non-event
[26:43] It's not, we don't get all the
[26:44] psychological baggage and damage
[26:47] from screwing something up
[26:49] It's no big deal
[26:50] We just revert to where we were
[26:52] Now I wonder about this a little bit
[26:54] I talked earlier about all those
[26:56] benefits from failure
[26:57] We'll slow down
[26:58] We'll reduce our overconfidence
[27:00] Are we still going to do that
[27:02] if we don't have all the baggage
[27:03] that comes with it?
[27:05] And so far, I think it works
[27:07] Because, even though
[27:08] I don't feel devastated
[27:10] I still don't like being wrong
[27:13] And I get a little annoyed that I'm wrong
[27:15] We're finding that a little bit of anger
[27:17] is actually a beneficial thing
[27:19] It's energizing
[27:20] You want to change it
[27:21] I got to fix that
[27:23] it's driving me crazy
[27:24] And if you can just get a
[27:26] little caremad about stuff
[27:27] you can get a lot of things done
[27:29] 90% of my twitter feed appears
[27:30] to be powered by this magical energy
[27:35] So this kind of gives me a framework
[27:37] for exploring things
[27:39] First I set a goal
[27:41] And then, I write it down
[27:43] So I can't reframe
[27:44] And the next thing I do...
[27:46] is I think about failing at it
[27:49] I don't like that
[27:50] Kind of get that taste in your mouth
[27:52] Ok, so what I do at this point is
[27:54] I don't give up!
[27:55] This seemed achievable 10 seconds ago
[27:57] I can do this
[27:59] So I start thinking about the failure
[28:01] a little bit
[28:02] Are there things I can do to make
[28:04] this safer?
[28:05] Can I make it smaller?
[28:06] Can I come up with a way to
[28:08] reset out of it?
[28:09] Maybe if I take some friends with me
[28:11] it won't be so bad
[28:12] And it may be that this failure
[28:14] is just too big
[28:15] It will hurt my friends
[28:16] I'll end up crying in the corner
[28:18] Ok, this isn't a suicide pact
[28:20] This is fine. You can avoid failure
[28:23] But, if it doesn't seem like that
[28:25] kind of failure
[28:25] I'll resolve to try
[28:28] But first, I write down
[28:30] what I think might happen here
[28:32] And I tend to record failure criteria
[28:34] only because I have problems with
[28:35] sunk cost fallacy type problems
[28:38] Where I'll get 80% into the quicksand
[28:40] well I better keep going
[28:41] That's what I should do now.
[28:44] So I try to write down what I think might happen
[28:46] and how I should get out of it
[28:48] And then I'll try
[28:50] So I'll try and maybe it will go badly
[28:53] I'll hit my failure condition
[28:54] and I'll pull myself out of it
[28:56] Ok, I've got to go around this one
[28:57] And that's fine
[28:58] I learned something about
[29:00] in this context, this isn't a good idea
[29:01] I need to do something else
[29:03] Maybe I'll try a different idea next time
[29:05] But usually, I'm done. I tried
[29:07] Let's keep going
[29:09] The second thing that might happen
[29:11] is that against all odds
[29:12] I will succeed!
[29:14] That feels amazing
[29:15] When you know you're going to
[29:17] screw something up and you don't!
[29:19] Man I am awesome!
[29:20] I'm so good at this!
[29:21] This is great!
[29:24] The third thing that might happen
[29:25] is that I will try and I will fail
[29:28] and then I'll realize this failure
[29:30] isn't really that big a deal
[29:32] And maybe I'll come up with a way to fix it
[29:34] In a lot of ways
[29:35] this is what I'm really striving for
[29:37] Because I want to build up this
[29:38] toolset of things to do
[29:39] when things go wrong
[29:41] And so, it helps me feel
[29:42] more comfortable in those situations
[29:44] For instance
[29:45] if a deploy to production goes badly
[29:47] I don't freak out
[29:49] Because, I've broken very many
[29:50] deploys to production
[29:52] And I have a whole set of ideas
[29:53] and tools to get things back to good
[29:56] without freaking out
[29:59] The fourth thing that might happen
[30:01] is I will try
[30:03] and I'll end up someplace
[30:05] completely unexpected
[30:07] This is really interesting to me
[30:09] I still kinda want to go this way
[30:10] I want to get to my goal
[30:12] But I didn't even know this existed
[30:14] as an option
[30:15] So now I'm over here
[30:17] Maybe I should keep going this way
[30:19] Let me see what's this way
[30:20] I have different things
[30:21] But again, if I had just saw the failure
[30:23] and tried to stay away from it
[30:25] I would have never really explored
[30:27] this as an opportunity
[30:32] It's easy to talk about failing
[30:35] when it's just you
[30:36] Nobody notices, it's no big deal
[30:37] Failure in modern society
[30:39] has nothing to do with tigers
[30:41] It has everything to do with people
[30:43] looking at you and saying you screwed up
[30:45] you're the mistake
[30:47] Why did you do that?
[30:48] That's the sort of thing we want to avoid
[30:50] Because, when that happens we naturally
[30:52] want to shell up and hide
[30:53] And not try anything very risky at all
[30:57] I gave this talk at a meetup
[30:59] and a man came up to me afterwards
[31:00] And he said he had one of those situations
[31:03] where he screwed up something in production
[31:05] and everybody freaked out
[31:07] But he and his boss got together
[31:09] and kind of figured it out
[31:10] and got it back to good
[31:12] And they realized that there
[31:13] were some things they could have
[31:15] done differently
[31:15] There were some ways they could
[31:17] improve this and make it safer
[31:18] And so he left for the day feeling OK
[31:21] Not the best day in the world
[31:23] Definitely not the way he wanted it to go
[31:25] But he's going to keep his job
[31:27] and they had a chance to improve things
[31:29] Things were looking good
[31:30] So objectively
[31:31] this is the exact kind of failure I want
[31:33] It was fairly safe
[31:34] It was a learning opportunity
[31:36] No real psychological damage done
[31:39] He comes in the next day
[31:40] and he's kind of excited
[31:42] He's going to make this better
[31:43] This is a good opportunity
[31:45] And a coworker comes up to the cubicle
[31:48] Saddles up and was like
[31:49] That was a boneheaded thing you did yesterday
[31:53] He said: I just froze up
[31:55] I was afraid to do anything for two weeks
[31:57] because I might screw it up
[31:59] All of that imposter syndrome
[32:01] comes roaring back
[32:02] I can't do this thing
[32:03] I can't believe they pay me to do this
[32:07] So how do we get past that?
[32:09] How do we get into a place where it's OK
[32:11] to screw up and we can learn from these things?
[32:15] This is hard
[32:16] We all naturally build up these personas
[32:19] this certainty and confidence that we have
[32:22] And it's very useful for us
[32:23] in an uncertain world to appear certain
[32:26] Doctors understand this
[32:27] If you go to a doctor and he's like
[32:29] I don't really know what's wrong with you
[32:31] We're going to run some tests
[32:33] maybe we'll try this thing...
[32:35] You don't want that doctor!
[32:37] You already feel vulnerable
[32:38] You don't want to talk to this guy
[32:40] You want this guy, who's like:
[32:41] It's going to be fine
[32:42] We're going to run these tests
[32:43] Don't worry we'll figure this out
[32:45] We're in this together
[32:48] I feel this way sometimes as a consultant
[32:50] A client will bring a weird strange problem
[32:52] I've never seen before, and I'm like
[32:54] I don't really know how to handle that
[32:56] But that's not the way I say it
[32:58] I'll be like, well ok -
[32:59] we'll do this to reduce risk
[33:01] we'll try these things to get feedback
[33:02] and don't worry we'll figure this out
[33:04] Because they're feeling vulnerable
[33:06] And I feel like I should help reassure them
[33:08] Everything is going to be ok
[33:10] I realize that I'm speaking from a
[33:12] place of great privilege
[33:14] If I screw up, it might reflect badly on me
[33:18] Maybe it would take my company down
[33:21] That's probably worst case scenario.
[33:23] But certainly nobody would think that
[33:25] some random white guy in Iowa
[33:26] is a screw-up because I messed up
[33:29] But if you feel like you're representing
[33:31] an entire religion
[33:32] an entire race
[33:34] an entire gender
[33:35] Then you're going to have a much
[33:37] harder time being OK with failure
[33:39] You're not going to want to let your
[33:41] shields down
[33:42] You know how hard it is to build
[33:43] this respect and reputation
[33:45] and you don't want to lose any of it
[33:48] I feel like my existing framework of
[33:51] experimentation isn't going to work here
[33:54] I'm ok with doing things to myself and
[33:56] seeing how it feels, and that's fine
[33:58] But I don't want to experiment with
[33:59] other people's feelings
[34:01] So instead, I'm considering some questions
[34:03] and I'd like to invite you to consider
[34:05] them as well
[34:08] So the first question is:
[34:09] What do you celebrate?
[34:12] It seems pretty obvious to me
[34:14] that the thing we're really good at
[34:17] celebrating are those random successes
[34:19] that we're not supposed to celebrate
[34:21] Justin's a billionaire!
[34:22] You won the lottery!
[34:24] We're going to write newspaper articles
[34:26] We're all going to talk about that
[34:27] That's the thing we want to talk about
[34:29] Imagine you had a coworker
[34:31] Just had a successful launch
[34:32] And you found out that she had been
[34:35] working 80-90 hours a week
[34:36] for the last month
[34:37] to pull this off
[34:38] And so naturally, you want to celebrate
[34:40] You want to take her out
[34:41] You want to celebrate all that
[34:43] hard work and effort
[34:44] Wow! Way to go!
[34:46] But imagine this same exact situation
[34:48] the launch had been botched
[34:50] Our natural tendency is to go to correction
[34:53] Well, if you hadn't been so sleep-deprived
[34:55] Maybe you should have asked for help
[34:58] We say that we are celebrating the
[34:59] effort and the action
[35:01] But we have a hard time taking it
[35:04] out of the outcome
[35:06] There's a great story from IBM about
[35:08] Thomas Watson Sr
[35:10] IBM was in a bad place
[35:12] They needed to make some sales
[35:14] Watson was going to lose his job
[35:16] And one of his salesmen
[35:17] blew a million dollar deal
[35:19] So that salesman comes into the office
[35:21] zhe has resignation in hand
[35:22] And Thomas Watson's like
[35:24] Well, what happened?
[35:26] And he kind of explains
[35:27] where the deal went wrong
[35:28] what he should have maybe tried differently
[35:30] And he turns to leave
[35:32] And Watson stops him at the door and says
[35:34] I can't accept this.
[35:36] I just spent
[35:37] a million dollars on your education
[35:41] It's hard for me to imagine being
[35:44] Thomas Watson in that scenario
[35:46] I needed that deal, my job is on the line
[35:49] But I can imagine what it felt like
[35:51] to be that salesman
[35:53] How empowered I would feel
[35:54] How supported I would feel
[35:56] How I would want to redeem myself
[35:58] How determined I would be
[36:00] to prove Watson correct
[36:02] Can we find real, genuine, things to celebrate
[36:06] when things go wrong?
[36:07] Can we celebrate the effort
[36:09] independent of the outcome?
[36:13] What sorts of failure do you acknowledge?
[36:16] it's very easy for us to put stuff
[36:18] under the rug
[36:20] We don't like to talk about failure
[36:22] I've been part of a number of initiatives
[36:24] Where we have the big kickoff
[36:26] We get everybody together
[36:27] This is going to be great
[36:28] We're going to change everything
[36:29] We're going to do it this way
[36:30] And then two months later
[36:31] Nobody is talking about it
[36:34] What happened?
[36:36] Nobody knows
[36:38] So my brain naturally starts
[36:40] filling in details and they're not good
[36:41] The stories I'm telling aren't really great
[36:44] And I feel like we're missing
[36:45] such an opportunity here
[36:47] To talk about how our company works
[36:49] and what we value and what we believe in
[36:51] And maybe that we weren't ready
[36:53] for this particular thing
[36:54] OK
[36:56] And maybe that 90% of the employees
[36:58] really hated the idea
[36:59] So we're not going to try
[37:00] to shove it down anyone's throat
[37:03] Maybe we discovered this is going to
[37:04] be a lot of work and we didn't want
[37:07] everybody working 60-70 hours to
[37:08] pull this off
[37:10] All these things tell useful stories
[37:11] And I think, by having to sort of
[37:14] acknowledge them in the same place
[37:15] that you did the big announcement
[37:17] You have an opportunity to use it
[37:19] as a positive experience
[37:21] And if nothing else, it helps inform
[37:23] our next initiative idea
[37:25] Maybe we should check on these things first
[37:29] Likewise, what sort of things do you
[37:31] discuss in the open?
[37:32] Which ones do you try to hide?
[37:34] I was really impressed with the way that
[37:36] GitLab handled their recent data outage
[37:38] They were open and transparent
[37:40] about the triaging they were doing
[37:41] the entire way through
[37:43] And it felt pretty blameless
[37:44] So much so, the person who did the
[37:46] typing mistake raised their hand
[37:48] and said, yeah it was me
[37:49] That's pretty remarkable
[37:51] Most of us don't want to be singled out
[37:53] in that way
[37:54] And I can contrast this to S3
[37:56] which had an outage not long after
[37:58] and nobody knew what was going on
[38:00] Is everything ok?
[38:01] Yeah, everything fine
[38:02] Are you sure?
[38:03] I'm having a lot of trouble here
[38:04] It took a number of hours
[38:05] for things to get resolved
[38:07] And we would all like for our dependencies
[38:09] And the people we work with to be 100%
[38:11] awesome all the time
[38:12] But that's not reality
[38:14] And I'd really rather work with people
[38:16] who are open and transparent
[38:17] So I know things are being done
[38:19] And maybe I can help
[38:23] What kind of exceptions do you make?
[38:26] And which ones do you never allow?
[38:28] If the product owner can be 10 minutes late
[38:31] to every show and tell
[38:32] But I get slammed if I'm 30 seconds late
[38:34] to a standup
[38:35] I'm going to notice that
[38:36] I'm going to key on that
[38:38] And I'm not saying that everything has
[38:40] to be equal and fair
[38:41] Equitable is a nice goal
[38:44] But, implicit arbitrary rules destroy trust
[38:48] and they destroy any ability to
[38:49] make a place safe
[38:52] So if you're going to have exceptions
[38:53] be explicit about them
[38:54] Be open about the sort of things that you allow
[38:59] What is your own personal tolerance for failure?
[39:03] When I think back on early management
[39:06] and mentorship opportunities I had,
[39:07] I screwed this up pretty bad
[39:10] I was trying to help
[39:12] I would see someone kind of going down
[39:14] the wrong path
[39:15] Don't do that, you want to try this instead
[39:17] No, that seems risky, let's try this instead
[39:21] I'm trying to help
[39:21] I don't want you to feel the pain of failure
[39:24] So I will help you - stay away from that!
[39:26] I robbed them of a learning opportunity
[39:31] Now to be clear, I think you can learn
[39:33] from other people's failures
[39:35] But it requires a lot of context
[39:37] It requires a lot of "Why?"
[39:38] You almost have to - practically
[39:40] step into the problem to understand the
[39:42] lesson to learn there
[39:45] Secondly, I inadvertently made them
[39:48] more dependent on me
[39:50] This was not my intention
[39:51] But if every time you start something
[39:52] someones like
[39:53] No, no, no, don't do it that way
[39:55] You're naturally going to
[39:56] want to clear it with them first
[39:57] So you don't waste your effort
[39:59] Not my intention
[40:01] I wanted them to be independent thinkers
[40:03] I had no interest in
[40:04] command and controlling everything
[40:06] But that was the natural response
[40:07] Because of the way I was acting
[40:10] But the third thing was perhaps worst of all
[40:13] I potentially ruined an opportunity
[40:16] for innovation
[40:17] The amazing thing about novices
[40:19] is they don't know what's impossible
[40:23] I've seen high school students do things
[40:25] that I didn't think could be done
[40:27] All my experience, all my baggage
[40:28] All my context
[40:29] Says you can't get here from there
[40:31] And they did it anyway
[40:33] So not only did I ruin
[40:34] opportunities for their learning
[40:36] I ruined opportunities for my learning
[40:38] And I potentially cheated the world
[40:40] out of an innovative way to look at a problem
[40:42] All because I was focused on keeping people safe
[40:45] and on the nice straight path
[40:46] Where it's ok to go here
[40:51] This is the last question
[40:53] What do you say about people
[40:55] outside your team
[40:57] during challenging situations?
[40:59] I have said some very not nice things
[41:02] about external partners in bad places
[41:05] When everything is on fire
[41:08] And I'll get on the phone with them
[41:10] I'll be very supportive
[41:11] I'm kind - I want to help
[41:13] I just want to get past this thing
[41:15] But when I go back with my team
[41:16] I might tell a joke
[41:18] I might vent a little bit
[41:21] Right, it's safe
[41:22] It's cool, we're all together
[41:24] Think about the kind of message
[41:25] I'm sending though
[41:27] Hey it's ok, that you screwed up
[41:28] We're going to learn from this
[41:30] It's fine
[41:31] What do you imagine I'm saying
[41:32] as soon as I turn my back?
[41:34] We've already established
[41:35] that I have this kind of behavior
[41:37] So, maybe it's ok that S3 goes down
[41:41] Everyone is faliable, it's fine
[41:43] We'll get through this
[41:47] The point of all this
[41:49] is that change and disorder and chaos
[41:51] are the laws of the universe
[41:53] We can't get past them
[41:54] So I feel like we ought to join them
[41:56] and get better at it
[42:00] Change has lasted even longer than taxes
[42:03] It's been around much longer
[42:04] And it will win. Over all other things.
[42:06] And there are opportunities here
[42:08] We can do really amazing things
[42:10] It's is viscerally satisfying
[42:13] to see your vision come out of this chaos
[42:16] into reality
[42:17] It feels so great to do these things
[42:21] If I look at something like wikipedia
[42:23] Conceptually, think of all the noise
[42:25] that goes into wikipedia
[42:26] We don't who you are, what you know
[42:29] what your experience is
[42:30] Everyone is welcome to add their own
[42:31] particular two cents
[42:33] And somehow a tremendous amount
[42:35] of signal comes out of this thing
[42:37] Wikipedia has changed the world
[42:39] it's hard to imagine getting by
[42:41] without wikipedia nowadays
[42:45] Likewise I look at a place like Venice
[42:49] I'm just amazed
[42:50] Venice has been around for millenia
[42:52] It's built on the world's worst
[42:54] possible imaginable building material
[42:57] Water is chaotic and fickle and ever-changing
[43:00] and they have made it work for centuries
[43:04] And then I think about some of our
[43:06] master planned communities
[43:07] that we have out there
[43:08] that got just a little bit of disorder
[43:10] and completely fell apart
[43:15] It is our nature to just want to
[43:17] put things into binary buckets
[43:19] when we think about them
[43:20] Success - Failure
[43:21] Fragile - Robust
[43:24] Republican - Democrat
[43:25] Man - Woman
[43:26] White - Black
[43:27] Waterfall - Agile
[43:30] And we're missing all this interesting
[43:31] stuff that's in the middle
[43:33] because we hang out on the extremes
[43:35] So I'd like to suggest that if you've been
[43:37] a hard-line successist your entire life
[43:40] maybe try on a little failure
[43:43] and see what it's like
[43:44] Because, let's face it
[43:45] if you're not trying new things
[43:47] you're not growing, you're not learning
[43:49] and you're probably not doing anything interesting
[43:52] So I'm really interested in hearing
[43:54] more about this
[43:55] If you have any thoughts or feedback
[43:57] please, come talk to me or send me an email
[43:59] I'd love to hear from you
[44:01] Thank you so much for your time and attention
[44:03] I really appreciate it
</pre>
