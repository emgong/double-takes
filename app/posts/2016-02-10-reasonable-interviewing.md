---
title: "Three problems in Tech Interviewing"
author:
  name: "Kevin Baribeau"
  url: "http://twitter.com/kbaribeau"
reddit: false
---

# A Beginning

A year or so ago, we at Test Double decided our interview process needed some major refinements.
For context, here's what we had:

  * Initial set-up / scheduling call with candidate
  * Pairing session #1
  * Pairing session #2
  * One "real" interview, where we talk about consulting and soft skills
  * A short meeting where the interviewers all compare notes and make a decision

Obviously, the above doesn't have much detail, but really we didn't *have* any
details. Despite that, we still felt like we were doing relatively well,
although we found we lacked consistency. Candidates might succeed or fail based
on which interviewers they had rather than on their own merit. This implies
that candidates are subject to the individual biases of our interviewers, which
is not a great thing. We'd like to hire based on things that we've agreed on as
a group, rather than hiring whoever got lucky enough to be paired with an
interviewer who was willing to see their best side.

We've actually made a ton of changes to our process in the past year, but in
the interest of time, I'm going to focus on just three problems that we found
and addressed while trying to improve our consistency.

## Problem #1: False Negatives

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
scheduling, but more importantly they serve as a neutral party when deciding
whether to move the candidate forward in the process, or to end it (based on
the evaluations we've collected so far). Since they're present in every stage
of the evaluation process, but never directly evaluating the candidate, they're
in a position to play arbitrator if there's ever a claim that a candidate is
being evaluated unfairly.

## Problem #2: Overemphasis on technical knowledge

It's tempting to center an interview around finding holes in what the candidate
knows about [Ruby on Rails](http://rubyonrails.org/), or
[Node.js](https://nodejs.org/), or whatever the latest framework is. But we're of
the opinion that refactoring skills, communication chops, and testing kung-fu
are more important. We want to emphasize breadth of skills over depth.

To be fair, obscure framework knowledge is useful, but it's not necessary for
everyone to have it. As a developer, if you don't know how to approach a
problem, the answer is often just a Slack question or Google search away.
Additionally, people will accumulate technical knowledge over time. It's
absolutely the easiest and most common way for a person to grow after you've
hired them.

Since the temptation for interviewers is to ask about their favorite deeply
technical topic, we need to give them other things to talk about. So we
developed a set of rubrics. A rubric is just a point we've written down that we'd
like to evaluate the candidate on. The goal is to help us be more objective (and
consistent!) by writing down (and agreeing on) the things that we'd like to
evaluate. For example:

> Given a few lines of code that we want to extract into a method, can the candidate identify the parameters that the method needs?

This is a relatively easy thing to slip in while pairing, and it's easy to mark
as either a "Yes they can", or "No they can't" in your notes.

Our actual list of rubrics is still growing, but having our evaluation criteria written
down in a shared space is a large part of what enables consistency.

## Problem #3: Pairing Structure

Saying that we're doing interviews by "pairing" is actually a pretty vague
statement. A pairing session might be 45 minutes of sharing vim configs, or it
might be actually writing some code on a production system. We wanted to
enforce a little bit more structure on our interviewing sessions.

We made the first interview into a review of a take-home assignment.  We
instruct the candidates to spend less than two hours on this, as we'd like to
avoid giving an advantage to candidates who have the privilege of more spare
time. Some candidates still cheat and send us a ton of code, but really all we
need is a method or two; just enough to get us started talking about some code
as a pair.

When you're interviewing as a pair, there's still a power dynamic in play. The
candidate is pretty likely to respond to suggestions that the interviewer
gives. When the candidate provides their own starting point, we've got an
unbiased sample. Additionally, having the candidate explain how they
approached a problem that they've put a little thought into is a great way for
them to show off their design chops.

Consistency in the second pairing interview is harder to handle. The second
pairing session needs to vary a little to accommodate the candidate. Some
candidates are best served by showing off their skills in an additional
language, or by working on a large, existing project. In order to cut down on
false negatives, our structure should be aimed at giving the candidate the best
possible chance of success. Bridge Agents are in a good place to help define
the structure here. Rubrics though, let us keep our evaluation consistent while
varying our structure.

# Wrap-up

Our interview process has improved a lot, but it's important not to stop. A lot
of our refinements have come out of routinely talking about what we want out of
it, and questioning whether we're doing the right things. Hopefully we'll have more
improvements to share in the future.

Also, if you'd like to work with us, you should [send us a message!](mailto:join@testdouble.com)
