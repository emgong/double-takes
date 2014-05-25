---
title: "Breaking up (with) your test suite."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
video:
  url: "http://www.youtube.com/embed/9_3RsSvgRd4"
  type: "youtube"
reddit: true
---

In this day and age, we have a thousand ways and reasons to test our code. On it's face, this is great! But the sword is double-edged: when I open a test that I'm not familiar with, I have to determine why it exists from any of a thousand possible reasons. If I want to add my own tests, I must choose from any of a thousand possible methods.

The most immediate abstraction we have for wrangling the motivations and implementations of our tests is the "test suite". By cordoning off each group of tests based on the value we hope to get out of them, we can develop unprecedented clarity in our working relationship with tests.

This talk is an example of how to do that. Hopefully, it's at just the level of detail you'll need to ponder how to apply a similar approach to your teams and applications.

The [video above](https://www.youtube.com/watch?v=9_3RsSvgRd4&feature=youtu.be) was presented at Ancient City Ruby 2014 on April 3rd, 2014. Its slides are [available on SpeakerDeck](https://speakerdeck.com/searls/breaking-up-with-your-test-suite), as always:

<script async class="speakerdeck-embed" data-id="372e82c09d7501316e28625017dd54d3" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>
