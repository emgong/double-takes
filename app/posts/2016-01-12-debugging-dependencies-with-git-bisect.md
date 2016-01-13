---
title: "Debugging gems with git bisect."
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
reddit: false
---

One of your project's dependencies just released a new version you want.

You run `bundle update` as you ritualistically cross your fingers.

All your tests are now broken.

What do?

Your _kneejerk reaction_ would be to open an unhelpful issue on the offending
gem's Github site, offering little more than "version 3.4.0 of your gem broke
my app. Fix it!"

<figure>
  ![fry-fix-it](/img/fix-it.gif)
</figure>

Though cathartic, that approach is decidedly unproductive. It's a bummer for the
gem's maintainer, to start. It comes across as entitled, too, as if you're requesting
warranty service for something you almost certainly never paid for. Most
persuasively, doing so wastes your own time, because the maintainer will
probably ask you to reproduce the issue, which you won't be able to easily do,
since you can't just upload your employer's super secret proprietary app to the
public (sidenote: loads of people actually do this anyway, out of apparent
ignorance or desparation).

So, the issue ends in a stalemate with neither party providing the information
needed to definitively fix or dismiss the problem. Months pass as the issue
whithers on the vine, never to be closed due to the ambiguity surrounding
the failure's root cause.

## A better way

Turns out, there's a better way to go about this. Instead of dredging up the
entire breadth of how you're using that particular dependency and then hunting
for the offending change outside-in, you can instead tell git to dig through the
history of changes made to the dependency and find the exact commit that caused
the break. From there, it's not hard at all to demonstrate how your usage's
behavior differs before and after that commit, and have a narrow, fact-based
conversation with the maintainer.

Today, I effectively experienced the above scenario with [Jim
Weirich](https://en.wikipedia.org/wiki/Jim_Weirich)'s
[rspec-given](https://github.com/rspec-given/rspec-given),
which I do my best to lovingly maintain. A test [started
failing](https://github.com/rspec-given/rspec-given/issues/18) when RSpec 3.3 was
upgraded to 3.4—and I had no idea why—so
[@myronmarsten](https://github.com/myronmarston) suggested I use [git
bisect](https://git-scm.com/docs/git-bisect)'s `run` command against the failing
test of my code.

[**Note:** this guide is about using `git-bisect` to debug dependencies using
RSpec as an example, and is not related to RSpec's own [rspec
bisect](https://relishapp.com/rspec/rspec-core/v/3-4/docs/command-line/bisect)
command.]

In case you're not familiar, `git-bisect` is a git command for finding the commit
that introduced a breaking change. It takes a known working ("good") commit and a
broken ("bad") commit as initial configuration. From there, you can specify a
shell script (usually an automated test) for `git-bisect` to run automatically.
It starts by literally "bisecting" to find the halfway-point in history between
the known working & broken commits, checking out that reference, running the
specified test script, and marking the reference as "good" or "bad" based on
whether that script exits cleanly before bisecting the remaining history again.
This process repeats until the commit that introduced the breakage has been
isolated to a single commit. It's pretty neat!

Below, I'll show the steps I took to bisect through the history of `rspec-core`,
which was the specific gem whose gem triggered the failure in `rspec-given` in
this instance.

## Update the Gemfile

First, clarify to Bundler that you want to load the offending gem from a local
path in your Gemfile:

``` ruby
gem 'rspec-core', :path => '../../rspec/rspec-core'
```

Clone the gem's repository at whatever path you specified and `bundle` its own
dependencies (you may want to `git checkout` a relevant release tag first) to
make sure everything looks good there.

Next, run `bundle` from your own project to verify things are wired together
right. Before you consider automating anything, verify you can reproduce the
issue at this point.

(Note: because of how RSpec versions its inter-dependencies between releases, I
had to engage in [some further, less relevant
shenanigans](https://github.com/rspec-given/rspec-given/issues/18#issuecomment-170971332)
at the instruction of [@samphippen](https://github.com/samphippen).)

## Write a bisect script

Next, write a little shell script that will be run every time `git-bisect` checks
out a new reference to determine whether the test succeeds (a "good" commit) or
fails (a "bad" commit).

I was able to get away with a relatively simple `bisect.sh` script in this case:

``` bash
#!/usr/bin/env bash

cd ~/code/rspec-given/rspec-given
rm Gemfile.lock
bundle
bundle exec rake
```

I saved the script in the working copy of the gem itself, because git-bisect
operations have to be run from the root directory of the repository whose history
is being bisected (which in our case is the `rspec-core` gem). I also ran
`chmod +x bisect.sh` it to make it executable.

## Running the bisect

Unlike most git CLI commands, `git-bisect` is awkwardly stateful. One must be
"in" a bisect just as one might be "in" a multi-step rebase operation, which
retains knowledge of the "good" and "bad" commits. I normally start by doing a
dance like this to ensure a clean slate:

``` bash
$ git bisect reset
$ git bisect start
```

Next, because I knew version 3.3.0 of the gem worked fine, but 3.4.0 broke, I
told `git-bisect` to set them as the "good" and "bad" starting points,
respectively:

``` bash
$ git bisect good v3.3.0
$ git bisect bad v3.4.0
```

In response, `git-bisect` reported: `Bisecting: 89 revisions left to test after
this (roughly 7 steps)`, indicating that there were 89 commits between the two
points, and a naive bisect algorithm would require about 7 steps before isolating
the exact commit.

Finally, it's time to let loose `git-bisect run`! To kick off its automated
history spelunking, run:

``` bash
$ git bisect run ./bisect.sh
```

A minute or two later (bisect is a great example of why it pays off to have a
fast test suite), the process will end with output like: `aadd33… is the first
bad commit`, along with that commit's message.

This gave me everything I needed to show Myron the exact commit that triggered
the change, and was enough to [jog his
memory](https://github.com/rspec-given/rspec-given/issues/18#issuecomment-171022814)
as to what change in RSpec had impacted me. Victory!

## When to bisect

Bisecting is an oft-overlooked tool that's good to have in your arsenal. It's not
the sort of utility that ought to be needed very frequently, but on the
occassions when it is, it can save hours of effort.

Keep in mind that bisect is better at answering the question "what change to the
code introduced this behavior?" than simply "why is my thing broken?" It can be
used to troubleshoot failures, to be sure, but in many situations, the cost of
controlling variables outside of the code proper (e.g. databases, third-party
APIs, system clocks) in your bisect script can easily exceed the insight you
might glean from a successful bisect.

That said, when you're sure that a failure was introduced by an isolated bit of
code, `git-bisect` can be a great asset in identifying what exactly caused it.






