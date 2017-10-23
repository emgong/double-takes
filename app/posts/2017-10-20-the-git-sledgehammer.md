---
title: "The Git Sledgehammer"
description: "Completely lost in a nasty git merge conflict? Here's what you do..."
author:
  name: "Kevin Baribeau"
  url: "https://twitter.com/kbaribeau"
---

Got a nasty git conflict, have no idea what's going on? Completely lost? Try the **Git Sledgehammer**

Let's assume you've on a branch called `fancy-new-stuff`; you've made a bunch
of awesome commits here.  But, you've been assaulted by a terrfying number of
conflicts after trying to `git merge origin/master`.  You're paralyzed with
fear and cannot continue.

What do you do? Try these steps:

1. `git reset --hard fancy-new-stuff`. This does two things. It changes HEAD to point to the `fancy-new-stuff` branch, and it changes the filesystem to match your branch. You're back to where you started before you tried to merge.
2. Do a `git log`. Scan the log for all your new commits and copy the SHA of each of these commits into a text file in another window.
  It should look something like this:

  ```
  67c884399bdbaeb1e3d38e2b5bc5228af6a22cce
  9ae937853fe10af3f3d803cf3c162baf0a77627f
  acc94eb3c6c90f9ffa5bcf6a57222faab43f5ace
  ```

3. Do a `git reset --hard origin/master`. Now, your HEAD points at origin/master, and so does your filesystem. It might look like your commits were destroyed, but git can still find them.
4. Stop here and take note of what your list of SHAs represents. It comes from `git log`, which outputs commits in *reverse chronological order*. We'd like to re-apply those commits in *chronological order*. This leads us to...
5. Starting from the **bottom**, for each of your SHAs do a `git cherry-pick <your-SHA>`, resolve conflicts as necessary. This is hardest step, but it should still be easier than a merge. Good luck!
6. You now have a branch that contains all your commits, **and** all the commits from master. Push it. You can either push this as the new `master` (`git push origin HEAD:master`), or make a new `fancy-new-stuff` branch (`git push origin HEAD:fancy-new-stuff-merged-oct-20-2017`).
7. You're done! Congratulations! Declare victory. Celebrate. You deserve it.


## So, why call it the sledgehammer? Why use it at all?

Well, like a sledgehammer, it's not very subtle. You might have noticed it
doesn't require you to know much about git. You only have to know which commits
from your branch are needed in master. Identifying these commits *can* get a
little tricky if your branch has been merged several times already, but pulling
commit SHAs out of `git log` still tends to be much easier than resolving a
giant conflict.

The main benefit of the sledgehammer actually happens while you're resolving
conflicts. It naturally breaks big confllicts up into smaller ones. If you've
got several new commits locally, it's useful to know which one caused the
conflict. The sledgehammer approach makes this obvious since you're only
applying commits one at a time. A merge though will force you to resolve all
of these conflicts at once, which can be intimidating and confusing.

Generally though, the sledgehammer will help you bash your way through some
conflicts. You could probably come up with a more sophisticated solution if you
really put your mind to it, but sometimes you just want the job to be done.


## But what's the downside?

The sledgehammer might help with conflict resolution, but it isn't always
enough. We still need some additional human brainpower to figure out what the
changes were on each side of the conflict and how to reconcile them. Git is
powerful, but it can't replace careful thought. If you're still having trouble
with the smaller conflicts, you should probably ask a co-worker for help.
Ideally, ask the person who wrote the code that conflicts with yours.

Another drawback is that the sledgehammer reorders history; it leaves no record
of any conflicts at all. Knowing where conflicts happened and which commits
were developed simultaneously on separate branches can be important parts of
history. If you care about preserving these parts of your history, you'll want
to avoid the sledgehammer by resolving your conflicts the hard way using a
regular merge.

## Ok, this is cool, what should I read next?

Definitely go check out [Git imerge](https://github.com/mhagger/git-imerge). It's a much more sophisticated tool than the sledgehammer. The sledgehammer is great when you're in a panic and need help *right now*; imerge is the tool you should go learn when you're calm and have time to focus on learning something new.

Also, be aware of [git rerere](https://git-scm.com/blog/2010/03/08/rerere.html). If you have a partially completed rebase or sledgehammer, but you want to start over (maybe because another team member added new commits to master while you were fixing conflicts); having rerere enabled means that you won't have to re-resolve the conflicts you've already committed.

<script>
  (function(){
    // Remove highlightJS classes, because they make SHAs look funny
    [].slice.call(document.getElementsByTagName('code')).forEach(function(ele) {
      ele.setAttribute('style', 'color: inherit;');
      [].slice.call(ele.children).forEach(function(span) {
        span.setAttribute('class', '');
      });
    });

  })()
</script>
