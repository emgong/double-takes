---
title: "Consistency in Tech Interviewing"
author:
  name: "Kevin Baribeau"
  url: "http://twitter.com/kbaribeau"
reddit: false
---

# A Beginning

A year or so ago, Test Double's interviewing process looked something like this:

  * Initial set-up / scheduling call with candidate
  * Pairing session #1
  * Pairing session #2
  * One "real" interview, where we talk about consulting and soft skills
  * A short meeting where the interviewers all compare notes and make a decision

There's not much there, but we felt like we already had a pretty good process.
We've got two interviews where we're actually writing code instead of doing
some imaginary whiteboard stuff, or just talking randomly about what might
happen if we had code in front of us. We've also got a session devoted to soft
skills, which is a pretty large part of being a successful developer.

Still, we had problems with consistency. Candidates might succeed or fail based
on which interviewers they had rather than on their own merit. If we're not
consistent, the implication is that there's at least some guesswork in our
screening process. Our hiring process directly affects our future as a company.
Guesswork isn't the right way to go about it.

So, we made a bit of a push to refine our process. We identified a few
problems that were hurting our consistency, and made some adjustments to
address them.

##  Consistency problem #1: False Negatives

False positives (hiring someone not-great) are obviously a problem, but false
negatives (failing to hire someone who is great) are too. Primarily, they mean
we've wasted a bunch of time (both our time, and the candidate's), but also
their existence implies that we're screening for things that don't actually
matter. There's no shortage of things that often come up in screenings that
are absolutely not important. Here's a few examples:

   * Comp Sci chops (B-trees, graph theory, etc.)
   * Self-marketing (telling stories that put you in a positive light)
   * Answering "puzzle questions"
   * Handling high stress situations (our day-to-day work is actually pretty low stress)
   * People who are able to take a whole day off work to interview

In order to to make sure candidates are treated uniformly and fairly (and
aren't turned down for reasons that don't matter), we introduced the idea of a
**Bridge Agent**. Bridge Agents are the people who serve as the main point of
contact for any candidate. Superficially, their purpose is to handle
scheduling, but more importantly they serve a neutral party when deciding
whether to move the candidate forward in the process, or to end it. Since
they're present in every stage of the evaluation process, but never involved,
they're in a position to play arbitrator if there's ever a claim that a
candidate is being evaluated unfairly.

## Consistency problem #2: Overemphasis on technical knowledge

It's tempting to center an interview around finding holes in what the candidate
knows about rails, or node, or whatever the latest framework is. But we're of
the opinion that refactoring skills, communication chops, and testing kung-fu
are more important. We want to emphasize breadth of skills over depth.

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

Our actual list of rubrics is still growing, but having our evaluation criteria written
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
gives. When the candidate provides their own starting point, we've got an
unbiased sample. Additionally, having the candidate explain how they
approached a problem that they've put a little thought into is a great way for
them to show off their design chops.

Consistency in the second pairing interview is harder to handle. The second
accommodate pairing session needs to vary a little to  the candidate. Some
candidates are best served by showing off their skills in more than one
language, or by working on a large, existing project. Our structure should be
aimed at giving the candidate the best possible chance of success in order to
cut down on false negatives. Bridge Agents are in a good place to help define
the structure here. Rubrics though, let us keep our evaluation consistent while
varying our structure.

# Wrap-up

Our interview process has improved a lot, but it's important not to stop. A lot
of our refinements have come out of routinely talking about what we want out of
it, and questioning whether we're doing the right things. Hopefully we'll have more
improvements to share in the future.
