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
        This screencast demonstrates separating domain logic from the framework.
The demo application is written in JavaScript, uses Angular to handle
the DOM, and employes Lineman as a build tool. The accompanying post lays out why
I believe that separation is a good idea.
        """
---
Building systems with software costs money.

Changing code in an existing system costs money.

For the purposes of this document, the creation phase ends and the maintenance phase begins when end users begin using a system.

It costs more to maintain a software system than it did to create it.

Therefore, decisions that minimize future code change are likely to reduce overall cost.

I have Angular, Durandal, and Ruby on Rails in mind when discussing frameworks in this post, but I believe the concepts to be generalizable to a broader range of large software libraries.

Frameworks are valuable because they solve difficult problems that are common to disparate software systems.

Framework APIs change.

Frameworks will change behavior in undocumented ways.

Frameworks die.

Therefore, frameworks are a source of volatility.

Application code that depends upon framework behavior can be no less volatile than the framework behavior upon which it depends.

Application code often depends on the same framework behavior in multiple places.

Therefore, application code that depends upon framework behavior is likely to be considerably more volatile than the framework behavior upon which it depends.

The volatility of application code that does not depend upon framework behavior is not a function of the volatility of the framework.

Therefore, a potential least cost means of producing software systems is one that employs frameworks while simultaneously isolating application code from that framework's volatility.

That is why I don't like to place much code in framework provided buckets. Watch the video for how I execute that approach.
