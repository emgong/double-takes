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
you say, "No problem, we can pair with them twice!" You're in love with
the idea of completely avoiding the traditional interview (whiteboard coding?
real coding is better, puzzle questions? again trumped by actually writing
code), but after some discussion you're forced to concede when someone points
out that we should be asking at least a couple of questions about how to be a
consultant.

So far, the process looks something like this:

  * Initial set-up / scheduling call with candidate
  * Pairing session #1
  * Pairing session #2
  * One "real" interview, where we talk about consulting and soft skills
  * A short meeting where the interviewers all compare notes and make a decision

# What next?

There's nothing catastrophically wrong with the above, but it's missing a lot
of detail. Test Double started with a loose process like this, but we found
that we weren't very consistent. Candidates might succeed or fail based on
which interviewers they had rather than on their own merit.

We've identified a few problems that were hurting our consistency, and made some
adjustments to address them.

##  Consistency problem #1: False Negatives

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

In order to to make sure candidates are treated uniformly and fairly (and
aren't turned down for reasons that don't matter), we introduced the idea of a
**Bridge Agent**.  Superficially, Bridge Agents just handle scheduling, but
more importantly they serve a neutral party when deciding whether to move the
candidate forward in the process, or to end it. Since they're present in every
stage of the evaluation process, but never involved, they're in a position to
play arbitrator if there's ever a claim that a candidate is being evaluated
unfairly.


## Consistency problem #2: Overemphasis on technical knowledge

It's tempting to center an interview around finding holes in what the candidate
knows about rails, or node, or whatever the latest framework is. But we're of
the opinion that refactoring/design skills, consulting/communication chops, and
testing kung-fu are more important. We want to emphasize breadth of skills over depth.

To be fair, obscure framework knowledge is useful, but it's not necessary for
everyone to have it. As a developer, if you don't know how to approach a
problem, the answer is often just a Slack question or Google search away.
Additionally, people will accumulate technical knowledge over time. It's
absolutely the easiest and most common way for a person to grow after you've
hired them.

Since we don't want to screen for deep technical knowledge, we avoid
asking about it early in the process. This is helped along a bit by centering
our process around pairing, but still needs to be made explicit. Explicitness
is helped along by having a set of **rubrics**, which we use to evaluate candidates
after every interview.

A rubric is just a means of scoring how well a candidate did. For each
interview, we have a bank of points that we'd like to see evaluated in a
candidate. For example:

* Given a few lines of code that we want to extract into a method, can the candidate identify the parameters that the method needs?

This is a relatively easy thing to slip in while pairing, and it's easy to mark
as either a "Yes they can", or "No they can't" in your notes.

The actual list of rubrics is still growing, but having our evaluation critiria writting
down in a shared space is a large part of what enables consistency.

## Consistency problem #3: Pairing Structure

Saying that we're doing interviews by "pairing" is actually a pretty vague
statement. A pairing session might be 45 minutes of sharing vim configs, or it
might be actually writing some code on a production system. We wanted to
enforce a little bit more structure on our interviewing sessions.

We made the first interview into a review of a take-home assignment.
We instruct the candidates to spend less than two hours on this, as we'd like
to avoid giving an advantage to candidates who have more spare time. Some
candidates still cheat and send us a ton of code, but really all we need is a
method or two.

When you're interviewing as a pair, there's still a power dynamic in play. The
candidate is pretty likely to respond to suggestions that the interviewer
gives. When the candidate has provides their own starting point, not only do we
have an unbiased sample; having the candidate explain how they approached a
problem that they've put a little thought into is a great way for them to show
off their design chops.

While there is overlap in evaluation between the first and second pairing
interviews, we try to vary the style of the second interview as much as can.
We'll try to do the second interview on an existing large-ish project, rather
than a small project that's just been started. We also try to vary the language
we're using. We like to suggest that the candidate use their strongest language
for the second interview, since there's more room for them to show off on a big
project, but the priority is on whatever is the least stressful / most
comfortable for them.


# Wrap-up

Our interview process has improved a lot, but it's important not to stop. We're
constantly re-evaluating what works for us, and hope to have more changes to
share with the world in the future.

