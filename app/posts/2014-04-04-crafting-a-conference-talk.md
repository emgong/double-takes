---
title: "Crafting a conference talk."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
reddit: true
---

I recently [gave a conference talk](/posts/2014-04-03-breaking-up-with-your-test-suite) at [Ancient City Ruby](http://ancientcityruby.com). I'd like to share a variety of notes about the process I go through when I develop a new talk.

## Wait for an idea

If I don't have something worth getting excited about, I don't want to waste an audience's time talking about it. I've gone an entire year without feeling like I had anything important to say. Sometimes it's because I'm not solving particularly novel problems, sometimes it's because I haven't been reflecting carefully on my experiences, and sometimes good ideas just don't come.

When an idea for a talk does come, I spend a little time asking myself whether it's generally applicable enough to be worth an audience's time. I like to imagine the size of a typical conference audience, multiply that by $200 per hour and ask myself, "will this talk provide attendees enough value to overcome, say, $20,000 in lost economic activity?" If not, then I disqualify the idea at that point.

Looking back, most of my talks have emerged from insights gained from three-to-six months of client service. I try to prompt myself by asking, "what's new and interesting about this client? Am I learning something that could help others solve meaningful problems that face most software teams?"

Finally, I pitch the idea to my friends. If I can't get my close colleagues excited about expounding on a topic, then I'm probably not going to be able to convince near-strangers to give me a spot in their conference lineup. I probably informally pitch two or three talk ideas a month in passing conversation before investing the time to submit to any calls for proposal.

## Write an abstract

Writing a good abstract has, as far as I can tell, nothing to do with developing a good talk. I am absolutely terrible at writing catchy, interesting abstracts. When I write an honest abstract about what I'm actually going to say, it never seems to be accepted. The kindest defense of abstracts as a selection mechanism I can muster is that highly professional people who carefully craft their talks also tend put in the time to carefully craft their abstracts.

Sadly, it seems like my abstracts are only accepted when I contact an organizer directly, when somebody else vouches for me, or when I invest a lot of time cooking up a crazy-sounding-but-sensational abstract that's at best tenuously-related to the topic I hope to actually cover.

The abstract for the talk I'm discussing today is [on Github](https://github.com/searls/call_for_proposals_2014/tree/master/justin_searls-breaking_up_with_your_test_suite).

## Be accepted

If you get accepted to speak at a conference, take a moment to celebrate! These days, conferences are absolutely inundated with talk proposals. It's not unheard of for a conference to receive 50-80 proposals per spot that's being selected competitively (nearly all conferences [invite a portion](/posts/2013-12-04-calls-for-transparency) of their lineup). It's a huge accomplishment to be accepted to speak at a conference.

If you feel discouraged in the face of frequent rejection, please accept my commiseration: I only get into a small fraction of the conferences I submit to.

## Prepare to prepare

Okay, now that you're done celebrating (like you, I rarely allow myself more than two paragraphs of joy when I receive good news), let's get to work.

I struggle to fill more than three hours per day with good ideas when developing a talk. This is problematic, because I usually spend between 40 to 60 hours on each full-length talk I deliver. That means that I need to start preparing more than a month out. As with all things, my [asynchronous brain solves most seemingly intractable problems for me](http://pragprog.com/book/ahptl/pragmatic-thinking-and-learning), I just have to be mindful to tee it up with the right questions at the end of each (procedural) planning session.

Most of my planning is an exercise in service of these two objectives:

* Persuade the audience that the thing I'm excited about is worth giving a try
* Convey the requisite information they'll need to get started on the right foot

Those goals are the primary source of tension in each of my talks: the former craves novelty, entertainment, and infectious energy. The latter requires clear structure, high information density, and disarming demystification. Because both goals are rightly important, I find myself bouncing back-and-forth between planning and designing—each activity helps inform the other in valuable ways.

## Arrive at a rhetorical structure

By the time you're accepted, hopefully you already have some idea of your talk's desired outcome. My favorite talks build up to a strong call-to-action, giving attendees concrete tools with which to try a new approach or adopt a different perspective. If your talk is technical in nature, I [wrote some opinions on that topic](/posts/2013-08-29-great-technical-talks) late last year.

Structuring the talk well is crucial, but how it ought to be structured is highly dependent on the nature of the message you hope to convey.

If a talk's title is "Top 10 Angular Tips", I'm probably not going to expect anything but a rapid-fire series of "problem-solution" couplets. Nevertheless, "Top #N" talks can be very useful! [Craig Kerstiens'](craigkerstiens) talk on [Postgres performance](https://speakerdeck.com/craigkerstiens/postgres-performance-for-humans) was aided by this structure, because of how densely packed it was with obviously-useful content.

If a talk is presented as a creative narrative, like [Carin Meier](http://twitter.com/gigasquid)'s beautiful "[Once Upon a Time in Clojureland](http://www.slideshare.net/gigasquidcm/fairy-taleclojure)", then the structure has the freedom to adopt any of the myriad forms found in storytelling. This can lead in all sorts of fascinating directions (if anything, the greater risk becomes losing focus on the content itself).

Talks sharing insights gleaned from personal experiences—like my own collection of war stories in [Office Politics for the Thin-Skinned Developer](http://blog.testdouble.com/posts/2013-08-24-office-politics)—can get away with a "here are [three simple stories](http://www.thejakartapost.com/news/2011/10/06/three-stories-my-life-steve-jobs.html)" structure. That may be all it takes to have a huge impact, as the anecdotes themselves will do most of the heavy-lifting. The challenges with such talks aren't structural per se, but it is important that their high-level plan figures out a common design language and clear, grounding theme throughout.

Introductory talks, meanwhile, present numerous structural challenges. First, the speaker must convince the audience that it has a problem in need of a solution. Next, they must convey all the persuasive aspects of said solution. Finally, they must leave enough undiscovered ground to inspire the audience to traverse it on their own, rather than risk sating their curiosity. On this note, I delivered at least five absolutely awful talks about [Lineman.js](http://linemanjs.com) before I gave a good one. There are simply too many competing priorities to get away without carefully planning an introductory talk's structure. When I [rebooted the talk](http://blog.testdouble.com/posts/2013-11-12-1st-class-web-development-with-lineman) for [Oredev](http://oredev.org/), I spent over **thirty hours** before finalizing its rhetorical approach. An intermediate tool I used in that process was a mind map (specifically [MindNode](https://mindnode.com/)), which helped me discover that I could break the content into three well-understood concerns and contrast them before & after my proposed solution.

<figure>
  [![My Lineman talk's mind map](/img/conf-talks/mind-map.jpg)](/img/conf-talks/mind-map.jpg)
  <figcaption>My Lineman talk's mind map (three problems, a pivot, and three solutions)</figcaption>
</figure>

Finally, the testing talk that [I just gave](/posts/2014-04-03-breaking-up-with-your-test-suite) differs from those discussed above because the main thrust is merely an exhortation to say, "let's be more thoughtful". My approach with the talk was to expound on example outcomes that could be reached by way of an increase in thoughtfulness about test suite design. This demanded a structure that supported broad and deep exposition, but with an added hypothetical flair, too. That is to say, I didn't want people to watch the talk and adopt my five test suites; I wanted them to go forth and create their own.

<figure>
  [![Structural planning](/img/conf-talks/structure-notes.jpg)](/img/conf-talks/structure-notes.jpg)
  <figcaption>Structural planning notes</figcaption>
</figure>

I juggled the paper notes above to track things that I wanted to say before I knew when or how I would say them. I recommend resisting the urge to write content straight into Keynote before developing a skeleton of the visual metaphors you'll be using. Once text is in Keynote, I tend to distract myself trying to condense and tweak it. Keynote is great for whittling content down, but its visual tools hinder my ability to think creatively about what I want to say.

## Search for visual metaphors

For my test suites talk, I knew that I had to bounce back-and-forth between high-level architecture (multiple services interacting with one another) and low-level code examples of individual objects. Because it's important that the audience have a visual anchor for understanding the context of what they're looking at, I felt that I needed a metaphor that would allow me to zip around as required by the talk's rhetorical structure.

<figure>
  [![Doodling a visual design](/img/conf-talks/visual-design.jpg)](/img/conf-talks/visual-design.jpg)
  <figcaption>Doodling a visual design</figcaption>
</figure>

After batting around a few examples on paper, I ultimately landed at a Google Maps-esque zoom UI control. Imitating a UI control everyone's already familiar with is a cheap trick, but it's effective when it's apt enough. I even used Keynote's "Magic Move" to tween the animation between the various zoom levels to give the impression that they were zooming in and out in a tangible way.

<figure>
  [![The six zoom levels](/img/conf-talks/zoom-levels.jpg)](/img/conf-talks/zoom-levels.jpg)
  <figcaption>Six zoom levels of an architecture</figcaption>
</figure>

The talk ended up with six zoom levels: one for each test suite, and one for planet earth (both to introduce the metaphor and to give myself a chance to underscore the importance of software's extrinsic purpose).

## Embrace patterns

From this talk's outset, I knew that I was going to be discussing 5 types of test suites. However, it wasn't clear at all that I had 5 points of interest I wanted to share about each test suite. It also wasn't initially obvious that I was going to be illustrating an architecture with 5 distinct "zoom" levels. At some point I started a [slide with a whiteboard](https://speakerdeck.com/searls/breaking-up-with-your-test-suite?slide=45) that just happened to land at 10 desired benefits of testing.

Once my planning started to coalesce, I fortuitously noticed that that the number 5 was appearing often.

I decided to exploit the number 5 by tying together all of the talk's disparate threads. For example, I married off each test suite to a distinct level of the application architecture. I even went so far as to base each test suite's icon on the architecture diagram it was associated with (to help anchor the details about that suite back to the architecture map). Ultimately, it worked because it was effective at answering the question, "what sorts of concerns does this test suite address?"

Once I knew that I was stuck with the number 5, I decided to go whole hog by limiting discussion of each of the 5 test suites to 5 areas of concern.

<figure>
  [![Icons for the concerns of the talk](/img/conf-talks/concerns.jpg)](/img/conf-talks/concerns.jpg)
  <figcaption>Icons for each of the five concerns I covered for each test suite</figcaption>
</figure>

This turned out to be a liberating constraint. I switched from "design mode" to look at my notes and uncover what 5 concerns my planning had best addressed. With those concerns in hand, I was relieved to see that I'd already covered 23 or 24 of the 25 total concerns that this approach would require me to talk about.

Condensed like this, it feels like I was beating a dead horse, but I didn't stop there: I even re-used "5-by-5" in an illustration that called for numbered axes, as an inexpensive way to broadcast the pattern early in the test suite discussion.

<figure>
  [![5x5](/img/conf-talks/5x5.jpg)](/img/conf-talks/5x5.jpg)
  <figcaption>Once aboard the 5 train, I used 5 whenever I had to pick an arbitrary number</figcaption>
</figure>

## Set up the presentation

I use [Keynote](http://www.apple.com/mac/keynote/) for all of my conference talks.

<div class="aside">
  <p>
    The rise of web-based presentation tools—including Keynote on icloud.com—has done nothing to entice me away from Keynote for Mac. Slide decks produced and presented in browsers tend to look bland and forgettable. They are usually drowned with unintentional negative space created by browser-friendly fluid layouts. They don't support custom fonts. Their animation facilities are spastic and unreliable. Their image and shape manipulation tools are universally a complete hassle. As for their "openness", it's also clear that the more robust the tool, the less portable its data format will (can?) be. They rarely reproduce content accurately across various user agents and viewports.
  </p><p>
    If you insist on using any of today's web-based presentation tools, I wish you the best of luck. Please report back with a link if you think your slide deck is going to be the one to convert me from Keynote.
  </p>
</div>

I always start each talk with a fresh Standard (e.g. 4:3) Keynote document in the White theme.

<figure>
  [![The Template Chooser](/img/conf-talks/standard-white.jpg)](/img/conf-talks/standard-white.jpg)
  <figcaption>Creating a new talk</figcaption>
</figure>

Why 4:3? As astonishing as it seems in 2014, the majority of conference setups still run video over VGA connections to projectors that can't reliably reproduce resolutions higher than 1024x768 and against projection screens cut in a 4:3 aspect ratio. As much as I'd love to present higher resolutions in a wide aspect ratio, learning that my talk won't display correctly a few minutes before I'm set to deliver it is a panic-inducing realization that I hope to never again experience.

Next, I delete all the master slides except for "Title - Center". Just like I don't want my talk to have the textures and colors of hundreds of other presentations you've seen before, I don't want to fill it up with generic-looking bullets and image masks, either.

<figure>
  [![Shrink-to-fit text boxes](/img/conf-talks/shrink-to-size.gif)](/img/conf-talks/shrink-to-size.gif)
  <figcaption>A shrink-to-fit text box (above) versus a regular text box (below)</figcaption>
</figure>

The reason I keep the "Title - Center" master slide around (instead of "Blank") is for its text placeholder's precious "Shrink-to-fit" property, which seems otherwise completely absent from Keynote '13. Rather than create text boxes any other way, I just copy-paste this particular box everywhere in my talk so that I can easily resize text by resizing the box, rather than constantly fiddling with the (often comically high) font point sizes.

## Decide on colors

With the Keynote document created, I reflect on colors. My goal is to assemble a palette of a near-black (never black), a near-white (never white), and three or four chief colors to use throughout the talk.

As the slide deck starts to come together, I usually need to introduce some lighter and darker variants of the pre-ordained colors to provide for things like accents, shadows, and borders. However, I actively resist the urge to splash in new colors throughout. In a way, each talk is a branding exercise. By reusing the same colors carefully, viewers will gain affect and imbue meaning without any explicit prompting from the speaker.

My Lineman talk was about a build tool. Developer tools, especially UNIX-based build tools, are typically associated with black and neon green terminal windows. I wanted to approach the topic playfully, so I intentionally plucked vibrant colors instead. I went for colors that reminded me of cotton candy and sidewalk chalk, since I knew there was no risk that my UNIX-based command-line tool would appear insufficiently masculine.

<figure>
  [![Lineman colors](/img/conf-talks/lineman-color.jpg)](/img/conf-talks/lineman-color.jpg)
  <figcaption>A sample slide from my Lineman talk, along with its color palette</figcaption>
</figure>

As you can see above, I actually create an Apple color palette to keep track of my colors as I work on each talk. This is tremendously  helpful for keeping my colors straight, because they're available in every native color picker across the operating system.

<figure>
  [![Test Suite colors](/img/conf-talks/test-suite-color.jpg)](/img/conf-talks/test-suite-color.jpg)
  <figcaption>A sample slide from my test suites talk, along with its color palette</figcaption>
</figure>

For my test suite talk, I knew I'd probably be stuck with needing a green and a red (because testing). I also knew that I'd be presenting in St. Augustine, Florida, which is home to a lot of very old stone and stucco and a lot of very bright sunshine. As a result, I decided on a muted palette of almost washed-out colors with a sand-yellow and stone-gray. I figured that instead of lazily using green and red to symbolize passing & failing tests, I'd use the green to symbolize growth (there are custom weeds on each narrative slide) and red hearts to symbolize relationships.  All of these color choices seemed to agree with my approach, as if helping me say, "there's no clean-cut right or wrong way to do this, only thoughtful relationships borne out of well-worn impulses."

## Find a font

Fonts have varying impacts (and to varying degrees) on different people. I personally don't notice fonts much unless I'm really trying to. I've found that picking a not-too-well-known font increases the memorableness of a slide deck. I also try to maximize the size of my text to fill as much of the screen as I reasonably can, so it's important the font not look too oppressive when it's very large. As a result, I tend to scour [Font Squirrel](http://www.fontsquirrel.com) for thin and [airy sans-serif fonts](http://www.fontsquirrel.com/fonts/Aaargh). [Chunky serif fonts](http://www.fontsquirrel.com/fonts/ChunkFive) are attractive too, but they tend to make better supportive fonts, in my experience. I also like to have a nice [mock-handwriting font](http://www.whatfontis.com/Nanum-Pen-Script-OTF.font) at the ready, because it can be used to layer on an apparent faux-edit to a slide when a point represents a counter-intuitive turn or surprise.

Having a single primary font and at most one secondary font can help establish the talk-as-a-brand, just like restricting use of color can.

One last note on fonts: I don't try to colorize the syntax of my code slides. I've heard syntax highlighting actually *decreases* readability slightly. That's all the justification I need to forgo it, because copying colorized code is a huge pain. Instead, I've found it to be much more effective to build in (and explain) one emboldened line of code at a time to increase its absorption.

<figure>
  [![Code slide](/img/conf-talks/code-slide.gif)](/img/conf-talks/code-slide.gif)
  <figcaption>Building in one line of code at a time, without syntax coloring</figcaption>
</figure>

## Illustrate effectively

Perhaps "a picture is worth a thousand words" and "a word is worth a thousand pictures" can both be true simultaneously, because effective use of both words and images can make a good talk a great one. It's obvious that simple illustrations can be a terrific way of condensing complex ideas in a slide deck. This is intimidating if, like me, you can't draw at all. I can do some basic image manipulation, but simple illustrations are not at all my forte.

One idea: hire a designer! [Marissa Hile](http://marissahile.com) did the best illustrations in my Lineman talk. Her artwork was the visual glue that held the whole thing together.

Another idea: find vector art that's ready to use. I rely heavily on [NounProject](http://thenounproject.com) for almost all of my monochromatic icon needs. Everything on NounProject is either creative commons or public domain, and the site will even help you attribute (or license) the icons you use.

I open the SVG file of each icon I download with [iDraw](http://www.indeeo.com/idraw/) to tweak and colorize it, then paste it straight into Keynote.

## Seek feedback

Once I'm starting to feel confident that my talk is coming together, I pull in my brain trust. Several of my friends give terrific feedback on my creative technical endeavors across a number of specialties. Two people I seek out every time regardless of my topic (and whose feedback has been instrumental to whatever success I've had as a speaker) are [Brandon Keepers](https://twitter.com/bkeepers) and [Kevin Baribeau](https://twitter.com/kbaribeau).

Keep in mind that not everyone who gives terrific talks is necessarily going to be as terrific at giving feedback. I'm certainly not very good at it.

## Reduce duplication with Master slides

Keynote's Master slide facility is a bit finicky and frustrating, but it's preferable to duplicating a ton of visual work all over your slide deck. The test suites talk in particular scared me because I knew I'd want to tweak the various architecture diagrams right up to the moment I gave the talk, but that the "zoom" conceit would require me to duplicate each of the slides at least half-a-dozen times.

Aside from extraordinary circumstances like that, however, I typically wait until I find myself needing to repeat the same action many times before creating a master slide or a custom style. (Of course, even then it's often too late because it's hard to apply a master slide after the duplication exists.) The parallels between slide organization and code organization are not lost on me.

## Sprinkle in variety

The best structure and the best branding in the world won't serve their purpose if they're followed so reverently as to bore the audience. A little breathing room is needed to sprinkle in jokes, asides, and insights to keep the energy level high throughout the talk.

In my paper notes (presented above), I kept a separate sheet of tangential points that came to mind as I worked. I used them as a sort of seasoning to break out of the monotony of my rigid test suite summaries.

One way the tension between inspiring and informing audiences manifests itself is that talks which are too densely packed don't seem to have time for moments of levity. One of the failures of my test suites talk was its ambition: by cramming in so many points over 405 slide builds, I knew I didn't leave any time to establish rapport with the audience. This is something that I think [Aaron Patterson](https://twitter.com/tenderlove) does masterfully in his talks (his intro at [Madison Ruby 2013](http://confreaks.com/videos/2626-madisonruby2013-yak-shaving-is-best-shaving) won the audience over before his "talk" even started).

## Tweak, tweak, tweak

I usually wrap up a start-to-finish first draft of my slide deck while using overly wordy text elements to make my points for me. Obviously, splatting a bunch of meaty paragraphs on the screen would lose the audience's attention in a hurry, but it can be useful for validating the points one wants to make in the context of where one wants to make them. It also helps me remember what to say at a given slide when I'm only starting to memorize the points I want to make.

I may start with thirty words of text on each slide. Whenever I subsequently visit the slide, I try to uncover a way to make it a little bit briefer. My goal with textual slides is to eventually whittle them down to something that will fit on two lines (and still at an extremely large font size).

Sometimes, a point is so complex that I'd need a dozen textual slides to effectively make it. When this happens, I go to work brainstorming visual metaphors or illustrations to help me make the point with fewer spoken and written words. [Brandon](https://twitter.com/bkeepers) gave me the idea of explaining the complex idea of preemptive abstraction in code bases by using yarn as a visual analogy.

<figure>
  [![Two balls of yarns being jumbled](/img/conf-talks/yarn.jpg)](/img/conf-talks/yarn.jpg)
  <figcaption>It's easier to tangle two balls of yarn into a knot than to untie a knot into two neat balls of yarn</figcaption>
</figure>

## Embed screencasts instead of live coding

Some talks require lengthy spells of live-coding that couldn't be easily replaced by a linear screencast, but most talks use live-coding only sparingly to make one small point at a time. Rather than expend thirty seconds in context switching between my code and my slide deck (all-the-while exposing myself to any number of technical risks), I prefer to use [Screenflow](http://www.telestream.net/screenflow/overview.htm) to record (and edit down!) silent screencasts that make my point for me (again, in 1024x768). Once exported, you can just drag-and-drop them into Keynote as a slide.

The trick is to keep these screencasts really short (sub-30 seconds), because once you've started playing a movie file inside Keynote, there's no easy way to pause or rewind without awkwardly mashing your keyboard in panicked fury.

## Run-through

I don't like to "rehearse" in the sense of practicing my talk in advance as I intend to perform it on stage. First, rehearsal makes me feel cheesy and uncomfortable, which makes me less likely to actually do it. Second, when I can remember my own rehearsal, then I tend to get inside my own head while I'm actually speaking—every time I stumble over a sentence on stage I'll mentally curse at myself and compare the experience to my rehearsal, causing me to lock up for several seconds of panic.

Instead, I just "run through" the slides dozens of times before the talk. I usually run through the slides rapidly to establish visual familiarity and comfort. At least three or four times, though, I will run through more slowly and whisper under my breath what I think I want to say on a slide (beyond the words on the slide itself). The quasi-spoken run-throughs are absolutely crucial to identifying solid segues from each slide to the next.

## Record your screen

I use Quicktime to capture my screen as I present.

<figure>
  [![Quicktime setup](/img/conf-talks/quicktime.jpg)](/img/conf-talks/quicktime.jpg)
  <figcaption>Setting up audio input on Quicktime's Screen Recording utility</figcaption>
</figure>

I do this in order to have a direct feed for later, even if the talk's video is being recorded by camera.Keep in mind that VGA is a lossy transport and video shot of projector screens will wash out, so it's much nicer to compose a direct feed screencast over whatever was recorded on camera by the conference.

Three things to worry about:

* Be sure the audio input is set to your system's microphone (or a direct feed if the conference can provide you one), as the default does not pick up mic audio
* Start the recording **after** you've connected to the monitor and finished setting up your display resolution, or the final video will be distorted or cropped
* Finish the recording and **save the file** before disconnecting the monitor or sleeping your machine. Either event can cause Quicktime to lose the entire recording into the ether, never to return.

## Use a remote

I use a [Logitech R400 presenter remote](http://www.logitech.com/en-us/product/wireless-presenter-r400) even if I know I'm going to be at my keyboard for the entire duration of my talk. I want to be able to use hand gestures even as I transition slides, and dropping my arm to hit the right arrow on my keyboard simply takes too much time. (The Keynote iPhone app is a poor substitute; it relies on a working Bonjour-friendly wifi network and my clammy nervous thumbs fail to swipe accurately enough under pressure.)

Also, somehow, having a remote in my hand gives me something safe to squeeze and fiddle with, subconsciously increasing my confidence a bit. I'll take what I can get.

Oh, and always bring extra AAA batteries. In the excitement of wrapping a talk, I invariably forget to turn the remote off, only to find it dead when I'm about to give my next talk.

## Disconnect

I always disconnect my Mac from wifi and flip my phone into Airplane mode before I go on-stage. The last thing I want is to have to shake the distraction caused by my phone buzzing in my pocket ("Are people tweeting at me? Is it good? Oh no, what was I just saying?!").

## Deliver the talk

It's hard to believe that I could have this much to say about preparing a conference talk, with so little to say about actually delivering one. Alas, I don't have much to add to that topic.

All I'll say is that I'm an incredibly nervous, highly-anxious individual. What I've learned from a few years of speaking in front of audiences is that my anxiety is a terrific asset: when intense nervous energy combines with thorough preparation, attendees can't help but lean forward and listen closely.

As for you, I wish you and your talk the very best! If any of this advice serves you well in the future, please [tell me about it](mailto:justin@testdouble.com)!








