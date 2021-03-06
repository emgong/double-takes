---
title: "How to program."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
video:
  url: "https://player.vimeo.com/video/216068726"
  type: "vimeo"
reddit: false
---

The [video above](https://vimeo.com/testdouble/how-to-program) was recorded as a
keynote at [RailsConf 2017](http://railsconf.com). It was also presented at the
inaugural [DeconstructConf](http://deconstructconf.com), which means the talk's
design benefited richly from my fear of disappointing the masterful [Gary
Bernhardt](https://www.destroyallsoftware.com/talks).

## The Premise

Programmers are really good at talking about what programs are. Most people will
invest a decade just to get a handle on the massive compendium of jargon and
metaphors we have created for describing the structure and behavior of
finished programs.

But you know what programmers aren't so practiced at articulating? *How* they
program.

Specifically, we don't have very evolved ways to convey clearly the details of
the countless actions, feelings, and thoughts that go into writing software.
We're simply not used to talking about _how_ we code (short of pointing to a
prescribed principle or process that we do our best to imitate). My favorite
Computer Science professor liked to say, "be wary; any major that has 'Science'
in its name, _isn't_".

Surely, the fact we struggle to ask and answer "how" questions about programming
has tremendous implications affecting how we learn programming, the nature of
our work, the colleagues we keep, and even impacts broad industry trends. It
seems obvious that we should make an effort to get better at understanding,
improving, and sharing our various programming workflows. As a humble beginning,
this talk lays out an approach for:

1. Identifying your unique disposition as a programmer
2. Introspecting how you act, feel, and think in a variety of contexts
3. Using that introspection to capitalize on or mitigate those actions,
   feelings, or thoughts
4. Sharing your personally-tailored workflow with others, so they might find
   aspects that would be useful in their own practice

## The Searls-Briggs® Type Indicator™

A conceit of the talk is that I'm filling out a goofy little survey that
establishes four buckets of, for want of a better phrase, "programmer
personality types". The quiz is a bit of a joke and not scientific
at all, but despite this was very popular (things that could also be said of its
[namesake](https://en.wikipedia.org/wiki/Myers–Briggs_Type_Indicator)). If you
like, you can take the quiz at [testdouble.com/salt](http://testdouble.com/salt)
and have your result e-mailed to you.

In the first weekend after I performed the talk, the quiz had over **4000**
respondents, so clearly there is an untapped demand for this sort of inquiry.
Here's a breakdown of your predelictions, in aggregate:

### Trait #1 - Fearless vs. Sensitive

<figure>
  ![Fearless - 61.5%, Sensistive - 38.5%](/img/salt/f-vs-s.svg)
</figure>

As you can see, there's a healthy distribution between the two. In the talk, I
identify as *sensitive*, meaning emotions play a really strong role in my
work (both helpfully and not), which leads me to more introspection and empathy,
but at the cost of lacking much courage under fire—much less excitement amid
volatile circumstances.

I'm a bit envious of the majority of respondents who identified with more
fearless markers, especially the 67% who prefer to hear all requirements
up-front without worry of feeling overwhelmed.

### Trait #2 - Inventive vs. Aesthetic

<figure>
  ![Inventive - 39.3%, Aesthetic - 60.7%](/img/salt/i-vs-a.svg)
</figure>

This bucket is a rough analogue for where folks land on the spectrum between
order and chaos. Inventive types are the ones who eagerly try out the
latest and greatest languages & frameworks, whereas aesthetic-leaners (like me) tend to
roll their eyes at how each subsequent cohort of new programmers insists on
reinventing [MVC](https://en.wikipedia.org/wiki/Model–view–controller) every six
months.

In the talk, the aesthetic archetype is summarized as valuing consistency and an
idyllic vision of how code _ought_ to be structured, even if those ideals are—to
an extent—subject to the fashions of the moment. Inventive types, meanwhile,
will gladly trade purist ideals for the opportunity to cover a wide breadth of
tools & frameworks if it yields more novel interesting experiences while writing
software.

### Trait #3 - Naive vs. Leery

<figure>
  ![Naive - 84.1%, Leery - 15.9%](/img/salt/n-vs-l.svg)
</figure>

Being leery myself, I was not surprised to see the majority of respondents
rated "Naive". Both are negatively-connoted words, but don't take offense—this
bucket measures bad habits at both extremes.

Naive developers tend to assume things like "software is good", "metrics are
useful", and "following the process is valuable". Leery developers are more
likely to worry software is becoming more fragile over time, that metrics
without context lead to abuse, and that rigid processes can create more waste
than not.

### Trait #4 - Economical vs. Thorough

<figure>
  ![Economical - 13.1%, Thorough - 86.9%](/img/salt/e-vs-t.svg)
</figure>

This was the most extreme result, and a few [Test Double
agents](http://testdouble.com/agency#agents) suggested that the skew is partly
because this talk was presented before a predominantly Rubyist audience. Ruby
and Rails, each being well over 10 years old, are at a state of maturity where
thoroughness is both typical and important to long-term success. Had we
presented this at a Node.js or React conference, where a larger proportion of
the audience's lived experience was at an earlier stage of the ecosystem
maturity curve, we probably would have seen a different outcome.

What this bucket measures is the extent to which a developer insists on baking
in code "quality" (whatever "quality" means) even if it slows them down, as
opposed to preferring to get code out the door as quickly as possible by
shedding affordances like tests and buy-in from others. As with the other
buckets, there's no correct answer. Economical developers are who you want for
rapid-prototyping or when the code's primary value is to solicit feedback.
Thorough programmers, meanwhile, are well-suited for deftly navigating complex
systems that can't afford a "move fast and break things" approach.

## Next steps

If this talk resonated with you, I'd encourage you to spend some time tuning
the same sort of feedback loops in your own work. After you've had some time to
reflect and tweak your process, share it with others! I'd love to hear about it
via [email](justin@testdouble.com) or [twitter](https://twitter.com/searls).

If you're at a point in your journey where you need to find an employer who'll
trust you with the level of autonomy needed to take these steps, that's, well,
why we created Test Double in the first place! We'd be happy to talk to you
about [joining our team](http://testdouble.com/join).

## Transcript

A transcript of the presentation follows:

<pre class="transcript">
[00:00] - My name is Searls, my non-Twitter name is Justin,
[00:03] feel free to call me either.
[00:05] This is what my face looked like in 2011
[00:07] and thanks to how social media branding works
[00:09] I'm now stuck with it forever.
[00:12] I work for a company called Test Double,
[00:14] we're a software agency who's on a mission
[00:17] to improve how the world writes software.
[00:19] You can learn more about us up at that URL.
[00:23] The title of this presentation is How to Program,
[00:27] and it's a rumination on a word workflow,
[00:29] two-part word, work being what programs are,
[00:32] their structure and behavior,
[00:34] flow being how we program our thoughts and actions.
[00:38] And when I look back on my experience learning
[00:41] as a computer science student,
[00:43] they taught me things like data structures
[00:45] and P vs NP and Big O analysis and cryptography,
[00:48] and not very much about how to think or how to work.
[00:52] And bootschools nowadays are actually analogous,
[00:55] even though there are more market practical skills
[00:57] like web standards, and system tooling,
[01:00] and languages and frameworks, not so much how to think
[01:02] through problems and solve stuff, and really write code.
[01:06] And you might think that's the job of thoughtleaders,
[01:08] 'cause the word thought is right there, but really,
[01:10] thoughtleaders, when they're talking about design patterns
[01:12] or SOLID principles, even when they talk about Agile
[01:14] and Test-Driven Development,
[01:17] those are nice 'cause they describe work activities
[01:20] but it's pretty discreet and mostly about
[01:22] how people interact,
[01:23] not so much how to think through things.
[01:25] So it's reasonable to ask when do we actually learn
[01:29] flow as programmers, who teaches us how to think?
[01:32] And if you're lucky, 10 years into your career,
[01:35] you'll stumble upon, or somebody will show you
[01:40] the only productivity tip
[01:41] that any of us have ever been taught,
[01:43] the Pomodoro technique,
[01:45] (audience laughing and applauding)
[01:48] where you work for 20 minutes
[01:49] and then you take a three minute break, it's really awesome,
[01:52] but honestly it kinda feels like you put 10 years
[01:54] of hard service in to get a $4 plastic pin,
[02:00] it's kinda insulting that that's the best
[02:01] that we have to offer.
[02:03] So sure, somehow we all learned what programs are,
[02:07] but I'd hazard a guess that most of us,
[02:09] nobody ever really taught us how to program.
[02:12] Look no further than a Google search, how to program,
[02:15] and you get a whole bunch of terrible results,
[02:18] starting with the traditional way
[02:19] of teaching people how to program.
[02:21] You start with nothing and then somebody shows you
[02:23] a completely finished example, the finished product,
[02:25] what the program should be,
[02:27] and then as for connecting it it's good luck, have fun.
[02:30] And every single computer science assignment
[02:32] that I had in college really resembled
[02:35] the How to Draw an Owl comic,
[02:37] where you start with two circles and then
[02:40] go draw the rest of the owl.
[02:41] (audience laughing)
[02:45] And I spent entire weekends cooped up in a lab
[02:47] trying to figure out, staring at a blank editor,
[02:51] and no idea how to write code.
[02:53] And it was that moment that I realized
[02:54] that programming's almost a philosophical activity
[02:57] that happens mostly in our heads.
[03:00] Of course we've now innovated quite a lot
[03:02] in programmer education since I was in college,
[03:05] now we, instead of just one big finished example,
[03:09] we've broken it up into two or three steps
[03:11] over the course of a book or a screencast,
[03:14] but very rarely does the prose or the explanation
[03:17] actually explain the thinking
[03:18] of how to make that thing more real.
[03:22] It might take years before you're able to imitate
[03:25] even an example application from a book.
[03:28] But that word imitation stands out
[03:29] because I think that most of us
[03:31] are just imitating other programmers,
[03:33] we see somebody successful or well-known,
[03:35] and we just try to do things
[03:36] like they seem to be doing things,
[03:38] and that's how we learn and get by.
[03:41] You can see that this is endemic in our society
[03:44] as programmers because we're really bad at how questions.
[03:47] If I ask how do I know when to create a new method,
[03:49] when should I break this thing up
[03:50] into more than one thing?
[03:52] You get really unsophisticated responses,
[03:54] like, "Methods should be about three lines long."
[03:56] (audience laughing)
[04:00] And when my wife, she likes telling this story,
[04:05] when she was in first grade, Becky,
[04:08] she was told by a teacher that sentences were two lines long
[04:13] and so then dutifully, for the next several years
[04:16] until she was corrected,
[04:17] she just stamped a period at the end of every other line.
[04:20] (audience laughing)
[04:22] And that's funny 'cause she's not an adult,
[04:25] and yet here we are with these unsophisticated ideas like,
[04:28] "eh, methods should be about three lines long,"
[04:30] and no ability to communicate above and beyond that.
[04:33] But let's say in spite of all of this,
[04:34] somehow you write a really good program one day
[04:37] and you're really proud of it, and really happy.
[04:39] And I ask you, okay, so what actions were productive
[04:43] or unproductive that led you to that point?
[04:47] Or what thoughts led you there,
[04:49] which thought processes were successful or unsuccessful,
[04:52] would you be able to answer those questions?
[04:54] Most of us wouldn't be able to,
[04:55] and it leads to rampant insecurity
[04:57] from how we educate programmers, to the work that we do,
[05:00] to the colleagues that we keep, and the overall industry.
[05:03] Now 99% of the work that I have done
[05:05] as a professional programmer could be boiled down as
[05:08] a business person trying to get a spreadsheet
[05:10] onto the internet.
[05:11] (audience laughing)
[05:13] And yet it's taken me 10 years or so
[05:15] to even become a merely competent programmer,
[05:18] clearly something's wrong
[05:19] in how we teach people to program.
[05:21] And this industry is 60 or 70 years old,
[05:24] but we're still searching for silver bullets,
[05:26] we always are externalizing the problem
[05:28] and hoping the next language, or framework,
[05:29] or library, or process is gonna suddenly
[05:32] make programming explicable, and it never works out.
[05:36] And think about that situation
[05:40] where everyone's either making stuff up as they go
[05:42] or pretending they understand it,
[05:44] who's gonna succeed in that environment?
[05:45] It's genuinely brilliant people
[05:47] and people with the overconfidence of having been told
[05:50] that they're brilliant their whole lives.
[05:52] So imagine that you don't look like other programmers
[05:55] and you walk into a room, and you lack that privilege
[05:57] of having been told that you're brilliant by society,
[06:00] this is a terrifying line of work to walk into
[06:02] 'cause no one can actually explain how to program.
[06:05] And I think that if you wanna make programming
[06:07] a more diverse and inclusive industry,
[06:09] we really need to solve this.
[06:12] (audience applauding)
[06:18] And it's obvious that the industry has no idea
[06:21] how software works, because they're constantly
[06:24] analogizing it to literally any other industry,
[06:27] like construction, or design, or manufacturing.
[06:33] And because of that they control the handful of things
[06:37] that they do understand, like estimates,
[06:39] and when people work, and where they work,
[06:41] instead of the true nut of it
[06:43] which is how we think as software developers
[06:45] and how we solve problems.
[06:47] And so how do we fix it?
[06:50] Well fortunately, yesterday at Keynote
[06:51] DHH offered us one solution.
[06:55] (audience laughing)
[06:58] But I'm gonna talk about a different one,
[07:00] I'm gonna talk about feedback loops,
[07:01] because programmers, through compilation,
[07:03] and through testing,
[07:04] we're used to establishing feedback loops
[07:06] to make forward progress, and we can do the same things
[07:09] inside of our heads improving as developers.
[07:12] We're gonna practice this today
[07:14] by reflecting on the actions we take
[07:16] and whether they're successful or not,
[07:17] and how to improve our actions.
[07:19] You can do the same thing for feelings
[07:21] and actually reflect on your emotional state
[07:23] so that you can reinforce positive emotions
[07:25] or mitigate negative ones.
[07:27] And, spoiler alert, you can actually think about thinking,
[07:32] (audience chuckling)
[07:33] and produce better thought processes
[07:35] that turn out to be more productive.
[07:37] This is really the path to programmer enlightenment,
[07:41] but I realize that we're starting from scratch here,
[07:43] we gotta walk before we can run,
[07:45] and ask yourselves what do we do with teams
[07:48] that are still emotionally immature
[07:50] they struggle to even talk about feelings?
[07:53] Well, we hand them crappy personality tests
[07:56] like the Myers-Briggs Type Indicator.
[07:58] If you're not familiar with the Myers-Briggs
[08:00] just know that it's the worst type system.
[08:02] (audience laughing)
[08:07] The reason we rag on it is 'cause it puts people
[08:10] into these silly buckets like ENTJ and ISFP,
[08:13] and the implication is that there's only
[08:14] 16 types of people out there,
[08:16] but we know that there's much, much more.
[08:18] But when you're starting from zero,
[08:20] 16 starts sounding pretty good,
[08:23] so that's why today I am pleased to announce
[08:25] the Searls-Briggs Type Indicator.
[08:27] (audience laughing)
[08:29] And instead of pontificating to you today
[08:32] about how to program,
[08:33] and dictating that this is the magical way,
[08:35] this is the silver bullet,
[08:37] instead I'm just gonna humbly take my own test,
[08:39] show you how I feel and my inclinations
[08:41] and my personality, and what I've done
[08:43] over the course of my career
[08:45] to reflect and improve, and result in better outcomes
[08:47] as a programmer.
[08:49] To do that we need an example feature,
[08:51] so let's make one up.
[08:52] Like I mentioned, I work at a company Test Double,
[08:54] and we have always been a distributed company,
[08:57] but we're still learning that that does not mean
[08:58] evenly distributed.
[09:00] So if you've got a flat organization
[09:02] you might think that there's all these
[09:03] spontaneous relationships that form,
[09:05] but of course that's not accurate.
[09:07] We all have our assigned pairs
[09:09] and we all phone home to an account manager.
[09:11] Our org chart looks like one of those
[09:12] 1980's suction cup ball things,
[09:16] but there's nothing wrong with that per se,
[09:18] unless, say two people on the team
[09:19] both really wanna learn Elm.
[09:21] But there's nothing systemically
[09:23] that's gonna get those two people
[09:24] talking together necessarily,
[09:26] so somebody raised the idea,
[09:27] why don't we have virtual coffee dates on the team,
[09:29] and just randomly assign people to talk to each other
[09:32] that otherwise wouldn't be.
[09:35] There's actually an expression from math though,
[09:37] it's called The Handshake Problem,
[09:38] which just calculates the number of potential relationships
[09:41] of any group of people,
[09:43] and you see that there's just tons of them.
[09:45] And so what the system should do
[09:46] is just send an email every week
[09:49] to pair up people who might not otherwise
[09:51] be talking to one another,
[09:52] and tell 'em go spend 15 minutes
[09:53] on this Google Hangout URL and chat about something,
[09:56] it doesn't have to be about work.
[09:58] And so we're gonna put my test to the test
[09:59] and build this feature together this morning as a group.
[10:02] And the first bucket that I'm gonna put us in
[10:04] is Sensitive versus Fearless,
[10:06] and the first question is,
[10:08] I prefer hearing all requirements up front,
[10:11] even if I can't tackle them all right away.
[10:14] I strongly disagree with that,
[10:15] I get overwhelmed really easily.
[10:17] Two, adding to a long function
[10:19] feels like more code just won't fit.
[10:22] Absolutely, once I hit a certain amount of complexity
[10:25] I can't imagine adding another case.
[10:28] Three, I look forward to being assigned
[10:29] to new projects and teams.
[10:32] No way, new projects give me night sweats.
[10:36] Four, I often feel paralyzed
[10:38] while staring at a blank editor screen.
[10:40] Yeah, I already admitted to that.
[10:43] So does that make me Sensitive or Fearless?
[10:45] Pretty obvious in this case, I'm Sensitive,
[10:47] a big part of being Sensitive
[10:48] is that I get overwhelmed easily.
[10:51] So think about this feature and all I've gotta do,
[10:53] create pairs, great, that's not so hard,
[10:55] but I do have to go and send the email,
[10:57] and I also have to look up all these people
[10:59] from a database.
[11:00] But I gotta be careful not to repeat
[11:02] so I gotta randomize the pairings,
[11:04] and I gotta not repeat week to week either,
[11:06] which means I also have to persist them.
[11:08] So it's a lotta work, so I don't wanna think about all that,
[11:11] I just wanna focus on the core problem.
[11:13] So my inclination is to just do that,
[11:15] put a unit around it, think hard about the problem,
[11:17] I could do my little Test-Driven Development thing,
[11:19] and I'm feeling really good about that unit of code,
[11:21] so then I go to the controller that's gonna call it,
[11:24] and I realize that the method signature
[11:26] doesn't quite line up.
[11:27] Or somebody else might say, hey, this unit you just made
[11:30] is doing all this extra redundant work
[11:32] that's actually handled elsewhere.
[11:34] My inclination was to overcome that paralysis that I felt
[11:38] and find some productivity by just putting on blinders.
[11:41] And I fell into that rabbit hole often enough
[11:42] that I had to think and reflect,
[11:44] and actually have inverted how I work as a programmer.
[11:46] So what I just showed you is often called
[11:48] bottom-up programming, but now I practice top-down,
[11:51] it works better for me.
[11:52] You might also call it outside-in,
[11:55] where I think from the perspective of the controller,
[11:57] at the top level entry point, and I start there,
[11:59] and I ask what do I need?
[12:01] Well I need something to create these pairs,
[12:02] and when your brain is focused that way,
[12:05] the caller knows exactly what inputs are available,
[12:07] what output it's gonna want,
[12:09] and it's also a way to minimize waste,
[12:11] because it has the broader context in terms of
[12:15] what guard clauses need to be inserted
[12:17] or can be omitted.
[12:19] The other aspect of being Sensitive
[12:20] is that I'm really afraid of failure,
[12:22] and when you work outside-in,
[12:23] you do have to juggle all these different concerns at once
[12:26] which can, again, be overwhelming.
[12:28] And so what I try to do is just rush into solving it,
[12:32] my inclination is just to open up an editor
[12:34] and prove that I can write this code,
[12:36] so I start with a module, and I make a method,
[12:38] I go load up a bunch of users, I loop over them,
[12:41] I skip anyone who's already had their hand shaken,
[12:43] otherwise I'll go an add a tuple
[12:45] to represent a pairing, and then I'll go
[12:47] and slam it through some mailer,
[12:49] and now I feel really good,
[12:50] 'cause I just proved I could do it.
[12:52] And someone will remind me,
[12:53] remember you gotta randomize it,
[12:55] and you don't wanna leave out the 15th person every week,
[12:58] and you've also gotta prevent repeats from happening
[13:01] week to week, and now I'm terrified because
[13:03] this is already really dense,
[13:04] I don't know how I'm gonna make it more complicated.
[13:06] And I'm very familiar with this corner of the room
[13:09] as a result.
[13:11] So I keep painting myself into this corner
[13:13] and the root cause is fear, I'm afraid of failing,
[13:16] I'm afraid of big things
[13:17] that I don't know how to break down.
[13:19] So my solution is avoid that fear
[13:21] by breaking things down in a systematized way,
[13:23] give myself some help.
[13:25] And I've been practicing over the last few years,
[13:27] iterating on an approach to Test-Driven Development
[13:29] that I call Discovery Testing,
[13:31] and it's really an effort in breaking big, scary problems
[13:34] into smaller, more manageable ones.
[13:37] It works with, I start with just a test
[13:39] of that top level thing.
[13:41] So I write a single test case, I invoke the thing,
[13:43] and then I ask myself a crucial question,
[13:46] what's the code that I wish I had,
[13:47] that I could defer and hand this work out to?
[13:50] Well something to find these hands,
[13:51] something to determine who shakes whose hand,
[13:53] something to mail them and then persist them.
[13:56] Then I use my test double library,
[13:57] which in Ruby is "gimme",
[13:59] so it creates these four fake things,
[14:01] and I set up a stubbing,
[14:02] so I say, hey, when finds_hands is called
[14:04] it gets you this thing to symbolize the hands,
[14:07] and if I pass that to thing that determines the shakes,
[14:09] another stubbing'll give me these handshakes.
[14:12] This is all the test set-up I need
[14:13] to be able to actually assert
[14:15] that I mail out all those handshakes
[14:18] and that I persist them.
[14:19] Now this is an unusual-looking test
[14:20] to a lot of you I'm sure,
[14:22] but what it does is it perfectly specifies
[14:24] the behavior of that top level unit.
[14:26] And so I get this test to pass,
[14:28] and I never have to worry about that top level again.
[14:31] In fact, if you list out all the files that shake out
[14:33] from just getting that test to pass,
[14:34] now I have a pretty clear work cut out for me,
[14:38] I know exactly what I need to do,
[14:40] I can start making forward progress.
[14:42] So I start off with a big, scary thing,
[14:44] but as I build that test I identity the units
[14:46] that I would need to actually carve out the work,
[14:49] and instead of one big scary thing,
[14:50] I now have four more digestible problems
[14:53] that I can focus on, and if any of them are scary,
[14:55] I now have in my back pocket a tool that I can use
[14:58] to reduce and break things up even further.
[15:04] The second bucket I'm gonna talk about
[15:05] is Inventive versus Aesthetic,
[15:07] so there's some quiz questions to determine my type.
[15:11] Question one, it's more important to build the right thing
[15:13] than to build the thing right.
[15:15] Eh, these are both important,
[15:16] but I'm more implementation-focused.
[15:19] Question two, I love experimenting with new tools,
[15:21] frameworks, and build systems.
[15:23] Not at all, I do spend a lot of my time
[15:25] in open source here, but it's expressly
[15:26] so I don't have to worry about it at work.
[15:29] Question three, I strive to write visually appealing code,
[15:32] down to syntax and symmetry.
[15:34] Absolutely, I don't know why,
[15:35] but I really like pretty, symmetrical code.
[15:39] Question four, it's boring when all the code in a project
[15:41] is structured similarly.
[15:43] I disagree, I really like consistency in code.
[15:46] So does that make me Inventive or Aesthetic?
[15:48] Well I think it makes me a little Aesthetic.
[15:50] And one part of being Aesthetic is I have refined taste.
[15:54] Now the problem with taste is that nobody knows what it is
[15:58] (audience laughing)
[16:00] until somebody on your team says, you know what,
[16:02] I'd prefer a 300-line function
[16:04] to all these well-named little small units
[16:06] that you keep creating.
[16:07] And then my face looks like this.
[16:10] (audience laughing)
[16:13] That's taste.
[16:14] (audience laughing)
[16:17] And so why do programmers develop taste, well it's obvious,
[16:20] when you're staring at a blank editor screen,
[16:22] there are infinitely many ways to solve any given problem,
[16:25] we need something to constrain ourselves,
[16:28] some patterns to follow to just not be stuck
[16:30] in analysis paralysis forever.
[16:33] And that's why I think that prose is a much better analogy
[16:36] to writing software than construction is.
[16:39] In fact, I think of programming as just communication
[16:41] to the next developer who's gonna pick it up,
[16:44] and it's just hard because it has to happen
[16:47] through this filter that's just formal enough
[16:49] for an interpreter or a compiler to understand.
[16:51] And so when I hear this feedback I reflect,
[16:54] and I take it to mean as a critique,
[16:57] that maybe I'm writing code that's meant to be read
[17:00] by myself as opposed to another human,
[17:02] because the other developer, they're not in the room,
[17:04] so I tend to write code that I think that I would wanna read
[17:07] and this leads to self-centered design.
[17:10] So if I just write a book on design patterns
[17:12] I'm gonna create a bunch of units like services,
[17:14] and factories, and repositories,
[17:16] and I'm gonna feel really brilliant having done all this,
[17:18] but then somebody else could list out
[17:20] all of the files I just created in one big listing.
[17:24] From their perspective, it's gonna be inpenetrably complex,
[17:27] it's a forest of all these objects,
[17:29] no idea how things are gonna work.
[17:31] And so now when I hear that critique,
[17:33] they've got a pretty good point.
[17:35] And I found this happen on team after team,
[17:37] and what it made me realize is
[17:38] I gotta start working differently
[17:40] to make my code more discoverable and approachable
[17:42] for other developers, and now I do things much differently.
[17:47] It started with realizing programs are directed graphs,
[17:50] so all of these units are really kind of nodes in this graph
[17:53] and all of the edges or vertices are function calls.
[17:56] So the Locator calls the Service,
[17:58] which calls this Repository, which calls this Mapper,
[18:00] which instantiates Hands,
[18:01] Service also calls this Factory,
[18:02] which calls that thing and that thing.
[18:05] And we already, 'cause we think of programs this way,
[18:07] we have some taste, we have some constraining principles
[18:10] that we share.
[18:11] Like for instance, if this Repository
[18:13] were to call this Service, we would all,
[18:15] wait a second, that's a dependency cycle,
[18:17] we realize there's a risk of an infinite recursion
[18:20] or stack overflow there.
[18:22] And so most of the programs that we write as developers
[18:24] try to by acyclic diagraphs.
[18:27] And remember my purpose here is just to prove
[18:29] that I'm right, I wanna tell this person, no,
[18:32] small units is better than 300 lines objectively,
[18:35] and to do that I thought maybe
[18:38] there's a liberating constraint,
[18:39] maybe if I refine my taste further I can solve this problem.
[18:43] And where I landed was, I want to express all of my features
[18:46] not as just general graphs, but as trees,
[18:49] because a tree is just a special subtype of a graph,
[18:52] you can take this exact same menagerie of units
[18:54] and organize it in a tree shape
[18:55] where you have your value objects on the left
[18:58] and the feature behavior on the right.
[19:00] And now if it's true that I have any needless indirection,
[19:03] it stands out in a tree 'cause it's just got one child,
[19:06] so that service locator, yeah,
[19:07] I can probably get rid of that.
[19:09] And if somebody asks, if what they're looking for
[19:11] is how to compare two hands,
[19:13] they can search the tree much more easily and quickly
[19:16] than just a gigantic directory of files
[19:19] and find what they're looking for,
[19:20] so it's more discoverable.
[19:23] The other aspect of my Aesthetic is I'm a minimalist,
[19:25] so when you look at our app you see it's car,
[19:28] it drives, you think about what its function is
[19:31] and why it exists.
[19:33] When I look at our app,
[19:34] all I see is the clutter and the mess.
[19:36] (audience chuckling)
[19:38] And as a minimalist, my productivity goes up
[19:40] when things are tidy and symmetrical and terse,
[19:43] and it goes down when things are cluttered or inconsistent.
[19:46] And what the software's supposed to be doing
[19:50] is its essential complexity,
[19:52] everything it actually does is its incidental complexity,
[19:55] the other stuff,
[19:56] think of everything that goes into writing a program.
[19:59] You're writing deploy tooling and app config,
[20:01] and dependencies, and framework appeasement.
[20:04] Then of course there's whatever the app was supposed to do,
[20:07] there's style rules, continuous integration,
[20:09] build systems, and then of course unnecessary stuff.
[20:12] As a minimalist, I'm the person on the project
[20:14] who's always chiseling away to try to minimize the amount
[20:17] of incidental complexity in the system,
[20:20] and trying to maximize the time that the team spends
[20:22] on whatever's really important.
[20:24] That means I'm always tweaking my code style,
[20:27] like maybe I'd start writing a feature behavior
[20:29] inside of my model objects,
[20:31] but then separate them out into separate units,
[20:33] but then maybe make them cullables,
[20:35] but maybe ultimately land at module methods.
[20:37] These are all fine, you can debate the finer points,
[20:40] but at the end of the day they're really six of one,
[20:41] half a dozen of the other kinds of arguments.
[20:44] And they represent a sort of trap,
[20:46] because earlier I said style rules, debating style,
[20:49] is a type of incidental complexity
[20:51] 'cause style is subjective,
[20:53] and so it changes around arbitrarily.
[20:55] And arbitrary decisions breed inconsistency,
[20:58] and, oh it turns out that inconsistency
[21:00] is another form of incidental complexity.
[21:03] And so, oops.
[21:06] Because if on Monday I organize code this way,
[21:08] and on Tuesday this way, and Wednesday that way,
[21:10] and then by Thursday I've decided this is the best way
[21:12] to organize code, everyone's gonna get mad at me,
[21:15] because I've just littered 36 custom little styles
[21:18] all throughout the system.
[21:20] So my temptation to continuously be improving stuff
[21:23] actually breeds inconsistency
[21:25] and creates bigger messes elsewhere, so I reflected on how,
[21:28] I think what was happening is I'd chase
[21:30] the local optimization at the expense
[21:32] of the global optimization
[21:34] of what's best for the overall project.
[21:36] And I had to learn to avoid this oscillation
[21:39] in my design, and it really required me to just realize
[21:42] I'd spend the entire project spinning my tires.
[21:46] And so instead I decided
[21:48] I need to just lock in these decisions,
[21:50] and say we're just gonna do things this style,
[21:52] whether or not it's better or worse, it doesn't matter,
[21:54] so we can try to carve out time to be productive.
[21:56] And as I got better at that, at flexing that muscle,
[21:59] I could recognize where I'm spinning my wheels earlier
[22:02] and spend more of my time being productive,
[22:04] it was a way for me to both be a minimalist
[22:06] but also really consistent in my applications,
[22:09] even when it meant hewing really strongly
[22:11] to arbitrary decisions of things
[22:12] that didn't really matter.
[22:14] And when you do that,
[22:15] especially with your incidental complexity,
[22:18] it brings the essential complexity into sharper relief,
[22:21] so you can all as a team really just focus,
[22:23] spend more time on what your app really needs to do.
[22:27] The third bucket is Naive versus Leery.
[22:30] Question one, publishing metrics like code coverage
[22:32] is always a good idea.
[22:34] Eh, I think radical transparency often backfires.
[22:38] Question two, writing good commit messages today
[22:41] will pay off in the future.
[22:43] Secret, I don't actually read commit messages, so eh.
[22:48] Three, software teams will make smarter use of time
[22:50] under pressure, disagree, I think pressure kills cognition.
[22:56] Four, software is generally improving over time
[22:58] and we are not doomed.
[23:01] (audience laughing)
[23:05] Pass, so does that make me Naive or Leery,
[23:09] I'm starting to realize this is a pretty obvious test,
[23:11] in my case I'm Leery.
[23:13] It all starts with my distrust of all of you.
[23:16] (audience laughing)
[23:18] Because most teams operate in a pressure cooker.
[23:21] They're under pressure to get as much stuff done
[23:23] as fast as possible, and as a result their brains turn off,
[23:27] and it results in really, really bad outcomes.
[23:30] In fact it's not very fair to pressure cookers
[23:32] because pressure cookers serve a useful purpose.
[23:35] (audience chuckling)
[23:37] So I'll find another analogy.
[23:39] (audience laughing)
[23:43] Where we're just being squeezed for all of the Ruby
[23:46] and JavaScript that we're worth,
[23:48] and again, not being creative, not resulting in good code.
[23:54] One person on teams I don't trust
[23:56] is I don't trust product owners,
[23:57] I love 'em, but I don't trust 'em.
[24:00] Back in the Waterfall days, a product owner
[24:02] would be able to specify 300 bullet points
[24:04] of everything that they ever wanted
[24:05] and then foist them upon us, and we'd say,
[24:07] hey, this is awful, but in a way at least it was honest,
[24:10] they got to articulate everything that they wanted up front,
[24:13] it was just us who didn't know how to handle
[24:14] that much complexity.
[24:16] Scrum and Agile stuff gave us a little bit of a backbone
[24:20] and we said, no sir, you only get one index card at a time,
[24:23] and in fact that's gonna be 20 points,
[24:25] and I made up what points mean.
[24:27] (audience laughing)
[24:30] So naturally, then it becomes a debate of,
[24:32] no, I think it's five points, and any system can be gamed,
[24:37] and really savvy product owners I know
[24:39] are really good at this.
[24:40] Like oh, you know, this is not that complex,
[24:42] it's just a little cartoon whale,
[24:43] you guys can do that right, you have time.
[24:45] And we'll say, oh yeah sure, we can do that,
[24:47] and then we realize it's much more complex
[24:49] than we really thought, and by then they're out to lunch
[24:52] and we're left holding the bag.
[24:55] So I don't trust product owners.
[24:58] Of course someone I trust even less than product owners
[25:00] is other developers, and it's because
[25:03] on day one of a feature we neglect to realize
[25:05] a very basic fact; our brains can only hold
[25:09] so much stuff in them at once.
[25:11] And so I think the developers have this biased
[25:13] towards size and features to just whatever number of things
[25:16] they can hold in their head at a time,
[25:18] and naturally, the conclusion that we draw
[25:20] about how big our objects and methods should be,
[25:23] is the same size, 'cause then that way
[25:25] we can just put all of the things in one place,
[25:27] it seems like the simple solution.
[25:30] But then a month passes and somebody says,
[25:32] hey, you need to add a couple additional aspects
[25:34] to this feature, it has to do this and this as well.
[25:38] Well, that means that the other stuff,
[25:40] our brain is finite, we can't keep it all in our heads
[25:43] at once anymore, but units,
[25:44] we can make files as long as we want, and so we just,
[25:47] even though we're incurring a paging cost,
[25:50] we can slam in those additional attributes to the feature.
[25:54] But it creates a blindspot for us where
[25:57] now that we're not thinking about the persistence,
[26:00] bugs can creep in through that door.
[26:03] And if you work this way, a year passes,
[26:05] and pretty soon your units are just gigantic,
[26:07] and they look like this and they're riddled with bugs.
[26:09] And normally day 400 is the day and I get a phone call
[26:11] saying, hey, can you help improve our tests?
[26:15] Of course this isn't a testing problem right,
[26:17] it's a complexity management problem,
[26:19] and it's hard for me when I see this cycle repeat
[26:21] over and over again, to let that distrust
[26:25] grow into cynicism, and that's not good.
[26:28] And in fact, if I'm empathetic I realize
[26:29] that at the root of this industry,
[26:31] all of us really struggle to predict
[26:33] how complexity is gonna change,
[26:35] and to guess the complexity of stuff,
[26:37] and I do it too.
[26:39] And so what I wanna do is change the question,
[26:42] and instead focus on how to prepare myself and other people
[26:45] for the inevitable increase of complexity,
[26:48] 'cause on any maintained system, almost any of them,
[26:51] complexity's gonna go up over time,
[26:52] it's just a matter of what that graph looks like.
[26:55] And so like Pascal, I made up Searls' Wager in my head,
[26:59] where sure, complexity might remain constant,
[27:01] or it might go up.
[27:03] And yeah, we could keep writing these brain-sized units,
[27:05] or much smaller ones.
[27:07] And if complexity doesn't change, no harm no foul,
[27:10] it doesn't really matter how we factor our code,
[27:12] but if it goes up, we have a lot of evidence
[27:14] that these larger units cause problems.
[27:16] And the nice thing about small ones is that
[27:18] they can actually accommodate some additional complexity
[27:20] without too much pain.
[27:23] And that's why on day one of every feature
[27:24] I break things up into itty bitty tiny units,
[27:27] to the point where people criticize me.
[27:29] And if you think that my units are too small, don't worry,
[27:32] because I trust that you're gonna go
[27:33] and make 'em bigger later.
[27:35] (audience laughing)
[27:37] It'll work out.
[27:39] It's a great way, if you struggle with trying to make,
[27:42] follow the Single Responsibility Principle
[27:44] and have every object do one thing,
[27:45] this makes it really, really easy,
[27:47] in fact, this is what the tree of functionality
[27:49] shook out as in this example,
[27:51] and every single unit serves exactly one purpose,
[27:54] and they all follow one of three rules
[27:56] that I've observed over the years of practicing this.
[27:59] The parent nodes are delegator objects,
[28:01] they don't really have any logic or branching,
[28:04] maybe just one if condition or something,
[28:07] they mostly just break up the work
[28:08] and hand it off to other things.
[28:11] And the way that I happen to do that
[28:12] is I use this Test-Driven Design
[28:14] where I use test doubles to identify and think up
[28:17] what's the code I wish I had
[28:18] that would actually do the real work?
[28:21] What you wanna try to maximize is these leaf nodes,
[28:24] so this is where the core logic of the application is,
[28:26] it takes inputs and transforms into some kinda output,
[28:30] these are pure functions so you don't need test doubles,
[28:32] you just are actually testing real logic,
[28:34] these are the kinds of unit tests
[28:36] that everyone likes to write.
[28:38] And it's sorta like functional programming
[28:39] for people who wanna think too hard
[28:41] about functional programming.
[28:43] It makes it very accessible
[28:44] because you can still do it in Ruby,
[28:46] you don't have to change languages or something.
[28:49] On the left are my values, and value objects,
[28:52] they just wrap a little bit of data,
[28:54] maybe they just hold onto a hash or an array,
[28:57] and the methods on them are only allowed
[28:58] to elucidate the data and answer questions about the data,
[29:01] as opposed to doing feature work,
[29:03] they're not there to actually build features.
[29:05] Instead I think of them as the sludge
[29:07] that flows though the pipes of my feature code,
[29:09] they're the types in those method signatures.
[29:13] And even if all this abstraction doesn't ultimately pay off,
[29:16] and even if that feature doesn't change a lot in the future,
[29:19] the very worst case, I've got a very discoverable system
[29:21] of carefully named things that are obvious,
[29:23] and small and comprehensible,
[29:25] so it's not the worst outcome in the world.
[29:29] The third aspect here is that I distrust myself,
[29:33] even more than all of you.
[29:35] It's because I worry about the future,
[29:37] and even though I'm not super confident
[29:38] in Today Me's skills, I'm even more worried
[29:41] that my future self won't be able to program either
[29:44] for some reason.
[29:45] And so when I'm writing a feature,
[29:46] somebody says, build this thing,
[29:48] I'll think about how to build it,
[29:49] and then I'll build a message in a bottle for myself
[29:51] in the form of better tests and documentation
[29:54] and commit messages, things to try to help.
[29:57] And my future self, who's wearing sunglasses,
[29:59] is told to change that feature, he gets really frustrated,
[30:02] because what those tests mean is
[30:04] now he's got a bunch of other stuff to do
[30:05] every time he wants to make a change,
[30:08] and my future self would much rather just start fresh
[30:10] and be able to write new code.
[30:12] And so I kept trying to do myself favors
[30:15] by writing a lot of extra tests,
[30:17] and adding in all this quality at the beginning,
[30:19] but it would actually tie my hands,
[30:21] and so I had to reflect how do I bake quality
[30:23] into my applications without creating an undue burden
[30:27] for my future self,
[30:29] and so I started working a little bit differently.
[30:31] Because if this is our tree of functionality
[30:32] and our manager comes in and says, new requirement,
[30:35] thanks to some HR fiasco all handshakes have to happen
[30:38] between three people...
[30:40] (audience chuckling)
[30:42] the traditional way to solve this
[30:43] is to carefully read the existing code,
[30:46] add, remove, change tests, change the code,
[30:49] and then try to make as small of a mess as possible,
[30:52] and I say small mess because any time the purpose
[30:57] of a piece of code has been two things,
[31:01] whenever we change a unit,
[31:03] it carries with it technical debt,
[31:05] it confuses the story of why it existed
[31:08] because it's changed over time.
[31:10] So instead I've been trying to make my code disposable,
[31:13] and what that means is that when I look at this tree,
[31:17] I search for all of the affected units by the change,
[31:19] these are two units that are gonna change,
[31:22] and so then I find the smallest sub-tree
[31:23] that encapsulates that change,
[31:25] and so there it is right there.
[31:26] And then I do something unusual, I blow it all up,
[31:30] I just knock it out, 'cause I trust that my future self
[31:32] is gonna be able to see that top level thing
[31:34] and understand what the contract is.
[31:37] So there he is, he's gonna drive out a new solution.
[31:40] And as opposed to just changing these old units
[31:42] that implemented the logic the old way
[31:44] and thus wrack up technical debt,
[31:46] instead I trust him to drive out a new solution.
[31:48] And in fact, future us is gonna have more experience
[31:52] than present-day us,
[31:53] they'll probably have a better understanding
[31:54] of the business, they'll be able to write better units
[31:57] in the future than we ever could hope to today,
[32:00] so this is a healthy way to work.
[32:02] It does mean that I try not to reuse code too much
[32:04] in my feature code because any code reuse,
[32:06] like if you have a method that's called in nine places,
[32:09] it's really hard to change that method,
[32:10] 'cause you have to consider nine different placed callers
[32:13] and what they need.
[32:14] It's also really hard to throw it away and replace it,
[32:17] so I try not to reuse too much code.
[32:19] And it also forced me to let go of this idea
[32:21] that maintainable code has to live forever.
[32:23] In fact, as opposed to that, this incremental,
[32:28] rewriting the small as part of your process,
[32:30] is a way to pay technical debt
[32:32] without saving a rainy day fund
[32:34] for when you finally get to refactor.
[32:36] And in doing that, I actually made myself happier,
[32:40] 'cause future me does not want his job to be
[32:43] fixing all of Justin's old janky tests
[32:45] every time that he changes something.
[32:48] It wants to be able to write code for a living,
[32:50] and so this process by making death a part of life
[32:54] while we're working through features,
[32:55] is a great way to keep your teams happy I've found.
[32:59] The last bucket here is Economical versus Thorough.
[33:02] The question one, better to ship code quickly
[33:05] than wait until everything is tested.
[33:07] Eh, I feel like I'd just be bailing out water in that case.
[33:11] Two, design principles are useful,
[33:12] but most teams waste too much time on them.
[33:14] It's possible for sure, but few teams are at risk of this.
[33:19] Three, most teams lack a sufficient understanding
[33:21] of their dependencies.
[33:23] Absolutely, 90% of us have no clue
[33:26] how most of our code works in our applications.
[33:29] And four, it's okay for everyone on a team
[33:31] to maintain separate coding styles.
[33:33] I actually strongly disagree,
[33:34] 'cause this leads to siloed development,
[33:36] it's kinda like a Conway's Law of style.
[33:39] So does that make me Economical or Thorough?
[33:41] Well of course it makes me Thorough.
[33:43] Some of you are noticing that this spells salt,
[33:47] (audience laughing)
[33:49] that's because when you make up the quiz
[33:50] you can make it spell whatever you want.
[33:52] (audience laughing)
[33:55] It's gonna surprise a few of you to learn today,
[33:56] I have a confession to make,
[33:57] I'm a bit of a control freak,
[34:00] and that means I'm dubious of free stuff.
[34:03] So when you see a sign that says free puppies,
[34:05] all I read is extra work, and another thing
[34:09] in our industry that makes me think extra work
[34:11] is open source.
[34:13] And so just keep that in your head
[34:15] next time you're on GitHub asking for free labor
[34:18] from an open source maintainer,
[34:19] imagine you're yelling at a puppy instead,
[34:21] because who yells at puppies, you jerk.
[34:24] (audience laughing)
[34:27] And open source isn't free because just like puppies
[34:29] we have to learn how to use it,
[34:31] we have to learn how it's changing and follow it,
[34:33] and it's not just this panacea
[34:37] that we can pull off the internet
[34:39] instead of having to build stuff ourselves.
[34:42] And if that open source has a bug,
[34:45] in theory sure, we can fix it ourselves,
[34:47] but in practice we're not gonna understand all that stuff,
[34:49] we're probably gonna have to rely on a maintainer
[34:51] or an expert to come and fix it later.
[34:54] And finally, if we have a,
[34:56] let's say this is our graph of objects,
[34:58] and it's all very consistent everywhere,
[35:01] and we slam in some third party API,
[35:03] that's gonna create a certain amount of friction and pain
[35:06] because it's going to look like all of our other objects.
[35:08] In fact, third part dependencies
[35:10] have this really nasty habit of leaking references
[35:13] all over our code base, which makes it really hard to change
[35:16] or replace or upgrade those third part dependencies
[35:19] over time.
[35:21] So my temptation of all these negative things
[35:23] about open source and puppies, is to,
[35:25] well I don't have a puppy first of all,
[35:27] again, much to my wife Becky's consternation,
[35:30] but two, I try to avoid using open source.
[35:33] That's what my gut tells me to do,
[35:35] but that's increasingly untenable these days
[35:38] 'cause I'd be reinventing wheels constantly.
[35:40] So I had to change how I thought about open source instead
[35:42] to maybe protecting myself from its blast radius,
[35:46] as opposed to avoiding it entirely.
[35:48] And the way that I do that is I write wrappers
[35:50] of all of the third party code that I write.
[35:52] In fact we already have one up on this tree,
[35:53] it's that Finds Hands unit on the left.
[35:56] So this is a wrapper object,
[35:57] and it starts as just a well-named delegator,
[35:59] it's a no-op, it doesn't do anything interesting.
[36:02] But it comes to encode all of our understanding
[36:04] of that dependency, it is the carpet under which we sweep
[36:07] all of the stuff that we have to do
[36:08] to make that third party dependency happy.
[36:11] And I integration test it
[36:12] but only in proportion to how suspicious I am
[36:14] of it breaking, otherwise I trust
[36:15] that it itself is tested well.
[36:18] And it might feel like needless indirection,
[36:20] but I need you to trust me that it's not.
[36:22] Of course, if this is where we're calling Finds Hands
[36:25] in our top level code,
[36:27] and I just told you not to trust other developers,
[36:29] so you don't trust me,
[36:31] you assume that that wrapper is unnecessary let's say,
[36:33] and instead of using that call
[36:35] we're just gonna call it User.all instead.
[36:37] That way it's much more direct,
[36:38] we got rid of that needless indirection,
[36:40] which means we have to update our test.
[36:42] So this is our original test,
[36:44] we can get rid of that fake finder
[36:45] and instead have an array of real users
[36:48] that we create in the database.
[36:49] Of course, validation failed,
[36:51] so now I have to add a birthdate,
[36:53] some incidental other arbitrary thing
[36:55] to make this work.
[36:57] But I can also get rid of this stubbing here
[37:00] and pass real users into the other stubbing,
[37:02] and I gotta make an integration test
[37:04] as opposed to a unit test.
[37:05] And ask yourself now, what did we just do,
[37:09] 'cause the value of this test used to be crystal clear,
[37:11] its purpose was to break the work up
[37:13] into four clear responsibilities,
[37:15] and now what is it?
[37:17] It's calling through to the database
[37:18] so it's making sure that the thing works,
[37:20] but only when three quarters of the code pads are fake?
[37:23] That doesn't seem right, that seems wrong to me,
[37:26] and it really becomes obviously wrong
[37:29] when this becomes more complex,
[37:30] 'cause if we add a couple scopes
[37:32] like only search for full time and active employees,
[37:35] then our test isn't enough anymore,
[37:37] 'cause those scopes are like branches,
[37:39] so now we need two or three test cases to cover everything.
[37:42] And now it's abundantly obvious
[37:44] that we sliced things wrong.
[37:46] So when I hear teams complain you have too many abstractions
[37:49] or too many objects, typically I think that's,
[37:52] it's not wrong, it's not that you're making
[37:55] too many abstractions so that no abstraction
[37:57] is somehow better,
[37:58] it's that you're probably mixing
[37:59] the levels of abstraction in your system,
[38:01] because life with wrappers is much easier.
[38:04] If I look at that same thing
[38:05] and dive into what that wrapper looks like,
[38:07] yes, on day one, in looks like needless indirection,
[38:09] but on day two when it gets more complex,
[38:13] it's easy to write a test for this,
[38:15] there's a place for that complexity to go.
[38:17] And over time it might become a little bit more complicated
[38:19] as you distance yourself further here
[38:21] with a transformer to a type that you own,
[38:24] as opposed to an ActiveRecord user.
[38:29] So let's say our boss comes in and says
[38:31] we're gonna change from ActiveRecord to the Sequel gem.
[38:34] Traditionally this would really panic
[38:36] everyone in the room because you're gonna have
[38:38] a billion references to ActiveRecord
[38:39] all over your system,
[38:41] but when you're writing wrappers carefully
[38:42] of your third party dependencies,
[38:44] you're actually preparing for yourself
[38:47] an adapter interface that's minimal
[38:49] and specifies exactly how you use that dependency.
[38:51] So you can even answer questions like
[38:53] would it be possible to switch to this third party thing?
[38:55] And if you did, you could create an alternate implementation
[38:57] and run both in parallel for awhile.
[38:59] It's a much, much better way to work,
[39:01] and what I found is it's a way to maintain,
[39:04] still have all that convenience of open source
[39:06] and sucking in these useful libraries
[39:08] while maintaining control over how you work.
[39:12] So when you're as introspective about this stuff as I am
[39:16] you run the risk of explaining the universe
[39:18] through yourself.
[39:20] In fact if you ask anyone who's ever worked
[39:22] on a project with me what my favorite way to write code is,
[39:25] it's my way, and I'll fight you for it.
[39:30] So my inclination is to just work really hard
[39:32] to convince you all that my way is best,
[39:34] and I'd love to say that that's an altruistic thing
[39:36] and I want you all to be better programmers,
[39:38] but it's not, it's selfish.
[39:40] What it really is is I'm afraid
[39:41] I'm gonna have a manager someday
[39:43] tell me that I can't write code my favorite way anymore.
[39:47] And when I reflect on that,
[39:48] even if I were to come up with a perfect way to write code
[39:51] and hand it to you, I run the risk of robbing you
[39:54] of that same autonomy, and so that wouldn't be good either,
[39:57] and so that's why I'm getting out
[39:59] of the silver bullet business.
[40:00] So even though I talked a lot today
[40:02] about how I program, I'm not here to sell you on that,
[40:06] I mean I hope you find some of it useful,
[40:07] but what I really am here to sell you on
[40:09] is the idea of pausing an introspecting
[40:11] about how you act, feel, and think while you're programming
[40:15] so that it becomes more explicable to you,
[40:17] and then you could articulate it to other people,
[40:19] and improve, and share.
[40:21] And you might ask yourself, hey,
[40:22] if we all start thoughtleading ourselves,
[40:24] won't that just create chaos on our teams?
[40:26] And I think that's actually a valid concern,
[40:29] so let's spend a minute to talk about that.
[40:31] Because earlier I said if you lock down
[40:33] all those arbitrary decisions up front
[40:35] you can spend more time being productive,
[40:37] that's true individually, but it's also true as teams,
[40:39] and that's why when you have disagreements
[40:41] with other people on a team,
[40:42] you should aggressively pull this forward,
[40:44] because the earlier you have that discussion
[40:46] and say okay, we'll use these semicolons,
[40:49] or we'll follow this style,
[40:50] if you can agree to that stuff early and lock it in,
[40:52] you'll as a team be more productive,
[40:54] and in fact if you look at the average team,
[40:56] remember what I said earlier,
[40:57] we're all just imitating other programmers,
[41:00] so most teams actually like the idea of normalizing.
[41:03] In fact, some of them like it too much,
[41:05] where if you have a creative idea
[41:07] of doing things differently,
[41:08] oh, I don't wanna rock the boat,
[41:10] I don't wanna do my own thing off here,
[41:13] or go off the reservation, quote unquote,
[41:15] so instead we tend to just gravitate
[41:18] towards the lowest common denominator on a lotta teams,
[41:20] and that's not good.
[41:22] But that's not you anymore right,
[41:23] 'cause after today you're gonna be thinking
[41:26] about how the actions you take could be improved,
[41:29] your feelings, improving your thought processes,
[41:32] and on your next team when you join a team
[41:34] of all enlightened Hugh Jackmans,
[41:36] (audience chuckling)
[41:37] some of whom will be SALT,
[41:39] and some of whom will be FINE,
[41:40] which is literally what the other four traits spell.
[41:42] (audience laughing)
[41:45] And some will be SALE and some will be FALT,
[41:47] when you look at this team, yeah sure,
[41:49] they all have very strongly held opinions
[41:51] of different ways of doing things,
[41:53] but the one thing they have in common
[41:54] is when they're approached with a new idea,
[41:56] they have a system for testing it
[42:00] and figuring out whether to adopt or reject it,
[42:02] and so they're not afraid of trying new things.
[42:05] And that's why I think that really introspected developers,
[42:07] when they're on a team, they might just look like
[42:09] they're talking at the whiteboard all day,
[42:10] but they can actually have a multiplicative impact
[42:12] on each other as they grow.
[42:14] And that's really my dream today,
[42:16] is that if we can, as an industry, normalize the concept
[42:20] of metacognition, and self-improvement,
[42:23] so that we can explain how to program
[42:25] this whole place might start making a whole lot more sense.
[42:31] And that is how to program.
[42:33] (audience chuckling)
[42:35] So I appreciate your time here today,
[42:38] if you're looking for a company to work with
[42:41] that's gonna support you on this kind of journey,
[42:43] I hope you'd consider checking us out,
[42:45] that's our page explaining what it's like
[42:46] to work with us at Test Double,
[42:48] and if you're a company that is looking
[42:50] for additional developers on your team,
[42:52] I hope you'd consider working with us.
[42:53] We join other teams just as additional developers
[42:57] with an interest in helping everyone get better as we go,
[43:01] and you can learn more about us on our site.
[43:04] By the way, I really made this quiz, it's a real thing,
[43:06] I actually printed out 100 copies and I have it in my bag
[43:10] so you can get a special commemorative edition today,
[43:12] if you come up and say hi to me I'll hand you one,
[43:14] I also have a lotta Test Double stickers.
[43:17] If you don't wanna say hi to me in person
[43:19] you an actually go to testdouble.com/salt
[43:22] and fill it out, we made a Google Form,
[43:24] and then two of our agents yesterday actually
[43:27] figured out how to automate Google Form
[43:28] so it'll calculate your programmer type
[43:32] and email you right away,
[43:33] so I hope you go check that out too.
[43:35] But most importantly of all,
[43:37] I'm really thankful for this opportunity
[43:38] and for your time this morning.
[43:40] Thank you.
[43:41] (audience applauding)
</pre>
