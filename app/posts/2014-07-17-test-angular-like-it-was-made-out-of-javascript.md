---
title: "Test Angular Like It Was Made Out Of JavaScript"
author:
  name: "Zach Briggs"
  url: "http://twitter.com/theotherzach"
video:
  url: "http://www.youtube.com/embed/eFPpSeEhhOE"
  type: "youtube"
tldr:
  title: "Misdirection For Profit"
  body: """
        This screencast demonstrates separating domain logic from code that requires a
framework. The demo application is written in JavaScript, uses Angular to handle
the DOM, and employes Lineman as a build tool. However, it does not provide an
explanation of why I adopted that approach. The accompanying post lays out that why.
        """
---

Building systems with software costs money.

Changing code in an existing system costs money.

For the purposes of this document, the creation phase ends and the maintenance phase begins when users begin using a system.

The majority of of software systems cost is in the maintenance, not the initial creation.

Therefore, decisions that minimize future code change will reduce cost so long as they do not endanger the success of the project.

I have Angular, Durandal, and Ruby on Rails in mind when discussing frameworks in this document. I believe the concepts to be generalizable to a broader range of large software libraries.

Frameworks are valuable because they solve difficult problems that are common to otherwise disparate systems.

Framework APIs change.

Frameworks will change behavior in undocumented ways.

Frameworks die.

Therefore, frameworks are a source of volatility.

Application code that depend on framework behavior can be no less volatile than the framework.

Application code that does not interact with a framework is insulated from the framework's volatility.

Therefore, a potential least cost means of producing software systems is one that employs frameworks while simultaneously isolating application code from that framework's volatility.

That is why I don't like to place much code in framework provided buckets. Watch the video for how I execute that approach.
