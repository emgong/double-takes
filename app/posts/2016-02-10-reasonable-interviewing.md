---
title: "A reasonable approach to interviewing... and some improvements"
author:
  name: "Kevin Baribeau"
  url: "http://twitter.com/kbaribeau"
reddit: false
---

# A Beginning

Imagine you work for a very small software company. Five or so developers.
Someone tells you that it's time to hire #6, and you're in charge of
interviewing. There should probably be some sort of semi-formalized process in
order to hire people, but no one's laid that out yet. What do you do?

You say, "The simplest thing is probably to just to pair with them and see if
we can get any work done, let's just do that." That seems ok, right? Someone
points out that we should be getting more than one opinion on each candidate,
you say, "No problem, we can pair with them twice!" While you're in love with
the idea of completely avoiding the traditional interview, you're forced to
concede when someone points out that we should be asking at least a couple of
questions about how to be a consultant.

So far, the process looks something like this:

  * Initial set-up / scheduling call with candidate
  * Pairing session #1
  * Pairing session #2
  * One "real" interview, where we talk about consulting and soft skills
  * A short meeting where the interviewers all compare notes and make a decision

You're pretty proud of yourself. You've avoided those silly puzzle questions, and
whiteboard coding. What do those things have to do with actually getting work
done anyway?

# What next?

There's nothing catastrophically wrong with the above, but it's missing a lot
of detail. Test Double started with a loose process like this, but we found
that we weren't very consistent. Candidates might succeed or fail based on
which interviewers they had rather than on their own merit.

So, we made a pretty serious push to improve things. We settled on a bit of
interviewing philosophy that we think sets us apart from other companies, we
added a little more structure to the process, and tried to encode what we're
actually screening for into a set of rubrics.

# Philosophy

##  Avoiding False Negatives

False positives (hiring someone not-great) are obviously a problem, but false
negatives (failing to hire someone who is great) are too. Primarily, they mean
we've wasted a bunch of time (both our time, and the candidate's), but also
their existence implies that we're screening for things that don't actually
matter. We've identified a few things that often come up in screenings that
we don't think are important, and are always on the lookout for more. Here's
a few examples:

   * Comp Sci chops (B-trees, graph theory, etc.)
   * Self-marketing (telling stories that put you in a positive light)
   * Answering "puzzle questions"
   * Handling high stress situations (our day-to-day work is actually pretty low stress)
   * People who are able to take a whole day off work to interview

## Coding super wizards are great, but other things matter too

As an interviewer, it's really tempting to overemphasize the things that you
know well or are easy to measure. Coding ability fits both these criteria. What
we'd like to do though instead of finding people are whizbang coders, is to
evaluate what we think is the minimum set of coding chops necessary to be
successful, and then move on.

Once we've determined a candidate can write a little code, we don't push
further on that front.  We'll spend time evaluating their refactoring and
design skills, consulting/communication chops, and testing kung-fu. Having a
wide breadth of skills is more important than just being a great coder.

# Process Refinements

In order to address consistency, we made a few changes to our original, loose process.

## Bridge Agents

The first is that whoever handles the initial call with the candidate becomes
their **Bridge Agent**. Superficially, Bridge Agents just handle scheduling,
but more importantly they serve as a client's insider friend would. We found
early on that candidates who had friends inside the company had a significant
advantage because they had someone fighting to get them an extra interview if
they flubbed the first one. Bridge Agents serve to fight for candidates who
might have been judged unfairly, or to defend the process if a candidate is
turned down, but might be earning an advantage politically.

Bridge agents are explicitly not involved with evaluating the candidate in any
sort of detail, so that they can be impartial when deciding whether to move the
candidate forward in the process, or to end it.

## A Take Home Assignment

Another change we made was to add more structure to the pairing interviews. We
made the first interview into a review of a take-home assignment. We instruct
the candidates to spend less than two hours on this, as we'd like to avoid
giving an advantage to candidates who have more spare time. Some candidates
still cheat and send us a ton of code, but really all we need is a method or
two.

What we are looking for is just that they're capable of converting an english
description of a problem into code. When you're interviewing as a pair, there's
still a power dynamic in play. The candidate is pretty likely to respond to
suggestions that the interviewer gives. When the candidate has provides their
own starting point, not only do we have an unbiased sample; having the
candidate explain how they approached a problem that they've put a little
thought into is a great way for them to show off their design chops.

While there is overlap in evaluation between the first and second pairing
interviews, we try to vary the style of the second interview as much as can.
We'll try to do the second interview on an existing large-ish project, rather
than a small project that's just been started. We also try to vary the language
we're using. We like to suggest that the candidate use their strongest language
for the second interview, since there's more room for them to show off on a big
project, but the priority is on whatever is the least stressful / most
comfortable for them.


## Rubrics

The last major piece of refinement that our basic interviewing process needed is
a set of Rubrics. A rubric is just a means of scoring how well a candidate did.
As much as possible, we want to have a set of consistent rubrics. For example:

* Given a few lines of code that we want to extract into a method, can the candidate identify the parameters that the method needs?

This is a relatively easy thing to slip in while pairing, and it's easy to mark
as either a "Yes they can", or "No they can't" in your notes.

Earlier I laid out a short list of things that we're explicitly leaving out of
the interview process. Every rubric is something that we're explicitly putting
in. Having this list of things that we care about written down is a huge win for
the consistency of our process over a large pool of potential interviewers.


# Wrap-up

Our interview process has improved a lot, but it's important not to stop. We're
constantly re-evaluating what works for us, and hope to have more changes to
share with the world in the future.

