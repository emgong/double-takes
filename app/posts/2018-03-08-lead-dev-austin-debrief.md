---
title: "Debrief: Lead Dev Austin 2018"
author:
  name: "Brittany Moore"
  url: "http://twitter.com/bannmoore"
---

Last weekend I had the great privilege of attending [LeadDev Austin](https://austin2018.theleaddeveloper.com/). As far as I'm concerned, the folks at White October knocked it out of the park! For a one day conference where the longest talks were 30 minutes, the speakers packed in plenty of valuable information.

If you'd like a preview before the videos become available, read on!

## Common Themes

This is a list of ideas that came up in multiple talks (not a lot of disagreement between the speakers).

- "What got us here won't get us there". This exact phrase came up in at least two talks. It's applicable to developers that become lead developers. The roles require different priorities and skills.
- People over process. Most of the talks weren't directly agile-related, but I kept coming back to this. Many of the challenges you face as a lead developer don't have solutions that guarantee success - teams vary, situations vary, and most of all people vary. Leaders need to accept a world where there may not be a "right" answer.
- Emotional intelligence matters. Many of the speakers addressed social topics like empathy, trust, diversity, and inclusion. To lead successful teams we _have_ to learn empathy for the world around us (inside and outside of the office).
- Technology is not neutral. Our industry has an impact on the world around us - on communities, on services that use data, even on elections. As members (and leaders) of this industry we have a responsibility to think about that impact and strive to be forces of good.

## How A Nuclear Meltdown Relates to Development

I definitely wasn't expecting to come out of Austin with a greater knowledge of nuclear reactors, but there you go. In the final talk of LeadDev, [Nickolas Means](https://twitter.com/nmeans) tells (in great detail) the story of Three Mile Island and the operators who "let" a simple malfunction cascade into catastrophe. Or did they?

Human error is a tricky thing. It's always tempting to blame the people involved without analyzing _why_ they made the decisions they did. We deal with this as dev leads every day. Why aren't the users hitting our flashy new page? How did a developer manage to drop production tables? Why didn't we see the team was struggling and try to head off the crisis? In the TMI incident, the engineers made reasonable decisions based on the data they had available - it was their interface with the machines themselves that led to false assumptions. It was a UI problem the whole time.

Hanlon's Razor tells us "never attribute to malice that which is adequately explained by incompetence". While it's true in a technical sense, it does disregard a third option. I might restate the aphorism as: "never attribute to malice or incompetence that which can be attributed to bad data". Sometimes it's so easy to get sucked into cost-effectiveness or style that we forget the _users_ behind our systems.

## Tech and Humans

The talk "Do The Most Good" covered [Mina Markham's](https://twitter.com/minamarkham) role in the Hilary Clinton campaign, and activism in tech. It's an amazing story, told with some beautiful slides. There were also some really great points about data bias and marginalized groups (Heidi Waterhouse's entire talk focused on similarly "poisoned" data).

My biggest takeaway from here was "be an accomplice, not an ally". I can't state it better than Mina (and many others) already have, so I'm not going to try. But I _am_ going to learn what it means to be a good accomplice, and I'd encourage everyone to do the same.

## Testing for the Lazy (Or Not)

I'm greatly interested in testing (as you might guess since I work at [a company named after a mock](https://testdouble.com/)), so I was excited to see this on the schedule. [Jaime Lopez Jr's](https://twitter.com/devwiththehair) talk, [I'm Lazy so I Write Tests](https://github.com/DevWithTheHair/Conference-Talks/tree/master/Im-Lazy-So-I-Write-Tests), focused less on the mechanics of testing and more on _why_ we write tests at all. Spoiler: the talk isn't really about laziness, it's about getting the most out of your valuable time.

Test-Backed Development (TBD) isn't TDD or [discovery testing](https://github.com/testdouble/contributing-tests/wiki/Discovery-Testing), use tests to write better code. It seems (and don't quote me on this) to view testing as a time-saving mechanism, which means analyzing the tests you write for explicit value. Jaime mentioned three possible use cases for TBD: mocking api calls (for a system that doesn't exist yet, perhaps), smoke testing, and demonstration.

I see interesting applications for TBD in legacy systems that don't currently have test coverage. There's a tendency to latch onto "test coverage" as the most important metric (which is understandable, humans really like reaching 100% in reports). But do you really _need_ tests to cover a system that isn't breaking or changing? Using TBD, you might write regression tests to validate bug tickets instead of worrying about coverage. I'm curious to see if Jaime expands upon this idea in the future, and not just because the acronym is awesome.

## But Wait - There's More

These are just a few highlights based on my experience, but _all_ of the speakers at LeadDev Austin were great. In particular, [Heidi Waterhouse](https://twitter.com/wiredferret) and [Anjuan Simmons'](https://twitter.com/anjuan) talks were powerful enough on their own that I don't think I can do them justice. You can find my full conference notes on [GitHub](https://github.com/bannmoore/conference-notes/wiki/LeadDev-Austin-2018), and be sure to check out videos as they become available!

See the full speaker lineup [here](https://austin2018.theleaddeveloper.com/talks).
