---
title: "An Empathetic Guide to Git Conflicts"
author:
  name: "Kevin Baribeau"
  url: "http://twitter.com/kbaribeau"
reddit: false
---

We've all seen this story. You've worked hard on some cool new stuff and are ready to push, but the universe has other ideas.

BBZZZT!

Conflict!

What do you do?

Take a deep breath
------------------

I know you thought you were finished, but the worst thing you can do is rush
through this last bit.  There's a good chance resolving this conflict is going
to be difficult. The stakes are high.  There's a good chance you'll break your
cool new feature here. Not only that, but **someone else** worked hard too, and
you don't want to break their stuff either.

So take a breath and make sure you're ready to concentrate a bit and get this
next part right.

Read the other commit
----------------------

Ok, you know what your change was but what's this conflict about? The reason
you've got a conflict is that **someone else** made a change that overlaps with
your changes (omg, what a jerk!). Angry as you might be, the appropriate
reaction here is empathy. What was this other person trying to accomplish?
What will it look like if it breaks?

If you can't answer these questions, you'll need help. Ask the author of the
other commit. Pair on the rest of the resolution if that's your thing.

Resolve the conflict
--------------------

This is the part where you press some buttons in your editor. Boring stuff really.

Re-test both changes
--------------------

So the hard part's done. You've got an understanding of both changes and how
they need to work together, but the **important** part is here. In a vaccuum,
the risk of something breaking here is about equal between your changes and
that pesky "other commit". It's tempting to re-test only your changes, and
to forget about that other commit (or worse, to skip testing altogether,
this is especially tempting if you didn't stop to take a breath).

If you've got an automated test suite here, that's great. Run it. But also be
aware that no test suite is perfect; and not everyone tests things the same way
that you do. The "someone else" who made "that other commit" can tell you what
tests they used. Ask them about it. Ideally you want to repeat whatever they did
(automated or not).  Practically there might be some shortcuts, but two people
can do a better job of making that judgement call than one.

If you didn't ask for help, ask for review
------------------------------------------

I said to ask for help right? You should ask for help.

Even if you don't think you need help, whoever wrote that other commit will
know their side of the story better than you do. Better to at least let them
know you made changes in an area that they touched last. They won't be mad, I
promise. Heck, they might even do some testing for you.
