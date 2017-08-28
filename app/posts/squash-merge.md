A treatise in favor of conventional merges


The default argument in favor of squash merges is typically "make history cleaner". Problems with this:

"Clean" is subjective, so I'm assuming clean just means "linear". But "clean" is not _functionally useful_. There is nothing that can be done in git with squash merges that can't be done with normal merges; but the reverse is NOT true. There are huge piles of features in git that ONLY work with conventional merge workflows. That makes normal merges _functionally_ superior, because more can be done with them.

- `git branch --merged/--no-merged`
- `git branch --contains/--no-contains`
- `git tag --merged/--no-merged`
- `git tag --contains/--no-contains`
- `git log --merges/--no-merges`
- `git log --first-parent`
- `git log --cherry-pick`
- `git log --cherry-mark`
- `git log --left-only`
- `git log --right-only`
- `git log --cherry`.

That is a long list of features in git that are effectively neutered by using squash merges, thus making git and its history drastically less useful for tracking down the history of changes.

If a nice "linear" view is all that's desired, that can be trivially seen with: `git log --oneline --first-parent`.

Further, the "conventional merge" workflow itself does not encourage reckless and meaningless commits. A squash-merge generally leads to "WIP", "typo", "fix", and "oops" commits as developers know the branch will eventually be squashed before merging. It is not desirable that these commits exist in a conventional merge workflow, either. For this reason, it is ideal for developers to make liberal use of git features like interactive rebase (also --exec), autosquash (see --fixup), interactive add, and to ammend commits. This allows a branch history to be kept nice and tidy (and useful for `log`, `revert`, and `bisect`!). So "clean" histories are not only the realm of squash-merge.


## Effects of squash merges:

### Orphaned branches.

Dozens (or hundreds, depending on the repo in question) of orphaned branches are left hanging on github. Github frequently shows the associated PR as 'Closed' but not 'Merged' because the branch HEAD is literally not merged with master. Further, look at all the branches that show "X commits ahead of master" but have already been squash-merged! So they aren't really ahead of master at all! Squash merges make (some) branch and pr information a lie.

### Large commits:

Large commits make it much harder to isolate the actual cause of a problem. git-bisect becomes _drastically_ less useful because a single commit can't be bisected further. With smaller logical commits, the commit can be more easily understood and reverted or patched. This is much harder to do with a large squash commit which is the accumulation of days or weeks of commits.

### Loss of authorship:

A commit can only contain a single author and a single committer. When a branch is squashed, the many authors of the PR are reduced to a single author. The committer is the person who is doing the merge. Which means `git-blame` will now report _incorrect_ authorship information for any multi-author PRs. Working on a feature and want to know why a particular change was introduced? You can no longer be sure that the author of the commit was actually the author of that code. Want to include the previous author as a reviewer of _your_ PR, since they will have context for that are of the codebase? git-blame will not be showing you all the right people to actually include.

# TL;DR

In short squash-merge:
- makes git branch/tag --merged useless
- makes git branch/tag --contains useless
- kills the ability to trace cherry picks
- kills the ability to see which shared commits are already merged to master
- strips GPG signatures from commits
- makes git-bisect much less useful
- loses authorship of multi-author branches
- result in larger, less digestable commits
- leads to orphaned branches that are not easily cleaned up
