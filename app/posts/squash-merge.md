A treatise in favor of conventional merges

# TL;DR

In short squash-merge is lossy:
- makes `git branch/tag --merged` useless
- makes `git branch/tag --contains` useless
- kills the ability to trace cherry picks
- kills the ability to see which shared commits are already merged to master
- strips GPG signatures from commits
- makes `git-bisect` much less useful
- loses authorship of multi-author branches
- results in larger, less digestable commits
- leads to orphaned branches and inability to determine their merge status
- is easily replaced with `git log --first-parent`


The default argument in favor of squash merges is typically "make history cleaner". But there are problems with this:

"Clean" is subjective, though most usages tend to generally mean "linear". It does this by stripping valuable history, which on its face has far reaching impact. To evaluate the tradeoff, we must evaluate the value of a simple linear history, and measure against its cost. In this case, the value add can be easily replicated with existing git functionality: `--first-parent`. But the converse is NOT true; once the history has been lost, we permanently lose the ability to use significant features of git. This makes normal merges _functionally_ superior, because their feature set is a strict superset of squash merge features.

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

Further, the "conventional merge" workflow itself does not encourage reckless and meaningless commits. A squash-merge workflow, in contrast, encourages poor git hygiene by recognizing that all branch commits will eventually be squashed anyway. This frequently leads to "WIP", "typo", "fix", and "oops" commits. Of course, it is not desirable that these commits exist in a conventional merge workflow, either. For this reason, it is ideal for developers to make liberal use of git features like interactive rebase (also `--exec`), autosquash (see `--fixup`), interactive add, and to ammend commits. This allows a branch history to be kept tidy (and useful for `log`, `revert`, and `bisect`!). So "clean" histories are not only the realm of squash-merge!


## Effects of squash merges:

### Orphaned branches.

Dozens (or hundreds, depending on the repo in question) of orphaned branches are left hanging on github. Github frequently shows the associated PR as 'Closed' but not 'Merged' because the branch HEAD is literally not merged with master. Further, look at all the branches that show "X commits ahead of master" but have already been squash-merged! So they aren't really ahead of master at all! Squash merges make (some) branch and pr information a lie.

Further, having dozens or more branches in a repository has a negative impact on other features of git: like shell completion of branch and tag names. (Not to mention the–typically negligible–performance impact for git to continually fetch, consult, and track remote branches that ought to be pruned.)

### Large commits:

Large commits make it much harder to isolate the actual cause of a problem. git-bisect becomes drastically less useful because a single commit can't be bisected further. With smaller logical commits, the commit can be more easily understood, reverted, or patched. This is much harder to do with a large squash commit which is the accumulation of perhaps days of commits.

### Loss of authorship:

A commit can only contain a single author and a single committer. When a branch is squashed, the many authors of the PR are reduced to a single author. The committer is the person who is doing the merge. Which means `git-blame` will now report incorrect authorship information for any multi-author PRs. Working on a feature and want to know why a particular change was introduced? You can no longer be sure that the author of the commit was actually the author of that code. Want to include the previous author as a reviewer of your PR, as they will have context for that are of the codebase? git-blame will no longer suggest the right people to include.

### Loss of commit signatures

As squash-merges discard history, any signatures will also be lost along with the original commits.
