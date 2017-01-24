---
title: "Large and In Charge"
subtitle: "How and Why to use Git LFS"
author:
  name: "Michael Schoonmaker"
  url: "http://twitter.com/Schoonology"
reddit: false
---

## Why might I need Git LFS?

To some extent, all software is _obsessed_ with data. Facebook, GitHub, and Dropbox are not very compelling without the data they manage, and Rails wouldn't be near as widely used without ActiveRecord (or some equivalent). That said, all of these examples—and most web applications in general—defer responsibility of that data to a database like Postgres. While they require data to be compelling, their core behaviour still exists without it, and users can continue to use the software to _add_ interesting data.

Some applications, on the other hand, _require data to function_. In game development this is often referred to as [data-driven design][ddd-games] or data-oriented design. (Not to be confused with the [UX paradigm][ddd-ux], nor [domain-driven design][ddd-software]) (For a more concrete example, check out the [entity-component-system][ecs] architecture for game engines.)

For our earlier examples, the relationship between data and behaviour is loose, and it's managed equally loosely, with ["migrations"][migration-example] to update the database schema as the various [data-access models][model-example] change over time. For these data-driven applications, the data _is_ the behaviour, requiring all the care and attention typically paid to code.

Because of this tight coupling between data and the code interpreting it, versioning the two _together_ becomes critical to maintaining this relationship over time: as the code changes, the data changes, and vice-versa. Historically, this need has been met with specialized version-control software like [Perforce][perforce]. (Notably, there are still features unique to Perforce that make it particularly _effective_ in these types of projects, but we'll leave that for another day and another post.)

Recently, there is another option: [Git Large File Storage][git-lfs] (Git LFS for short).

### Other examples

While data-driven game engines are a convenient example, many applications have a similar relationship:

- A parser for a binary file format and a set of binary test fixtures verifying the parser's behaviour.
- A static web site that wants to include images and fonts alongside markup, all [deployable via git push][git-push-deploy].
- A repository for a company's style guide, with source files (such as the `.sketch` files, naturally) versioned alongside the resulting style guide.

## Why wouldn't I use Git LFS?

In order to save space, Git LFS avoids _downloading_ the files it tracks, leaving them on the remote for retrieval as needed. While effective, this technique precludes individual clients from having all of a repository's history available offline.

Using the example of binary test fixtures, for example, you would be unable to run that test suite inside of `git bisect` without access to the remote storing the history for those fixtures.

## How much space does Git LFS save?

That depends. If most of the binary data over the history of your repository is in "the past" (you have binary files that change a lot), the space savings with respect to those files approaches 100%, mathematically and theoretically speaking. (Practically, I'd expect the savings to be 75% or higher for a repository containing, say, 3MB images that change often.)

Not satisfied to rely on theory alone, [this repo][size-test] contains the tools, method, and results for a series of tests. The results were:

- 10 2KB files, committed 40 times each: 700KB and **72% less** disk space
- 1 100MiB file, committed only once: 0B (no cost for large or unchanged files)
- 1 1MiB file, committed 1000 times: 188MB and **98.6% less** disk space

These tests also revealed a few other interesting details:

- Committing tracked files is slower, due to the time it takes Git LFS to run its various scripts.
- Uploading and downloading files is faster over Git LFS, though the overhead of setting up the additional connection can nullify this for fewer binary files without a long history.
- Local disk usage for the clients making the changes to tracked files can be higher with Git LFS installed, due to the local bookkeeping Git LFS performs alongside storing all binaries (since they originated at this client). Cleaning out the repository of these binaries (once they've been pushed to the remote, of course) will bring disk usage back down again.

## An unfortunate name

Contrary to its name, nothing about Git "Large File" Storage requires anything regarding the _size_ of the files to be versioned. Instead, Git LFS improves upon the default handling of _binary_, _unmergeable_, or _uncompressable_ files, storing them independently of the rest of the index.

If those files are added to the repo without Git LFS installed, Git does its best, but it will naïvely compress and store each updated copy just as it would with text. If these binary files are large, or simply change often, the size required to track their history (as opposed to the size of the binaries themselves in the working directory) would be significantly reduced by installing and using Git LFS.

## How to use Git LFS

- Each team member will need to [download and install the Git LFS extension][git-lfs]. Depending on how each team member has configured their machine, this can be as simple as one command to download the extension (on a Mac, this can be `brew install git-lfs`; for other environments, see [these excellent docs][git-lfs]), and `git lfs install` to install it.
- In your git repo, you need to tell Git LFS to "track" each kind of binary file:
  - To track all `.dat` files, run `git lfs track *.dat` from within the repo.
  - To track all files in `images`, use `git lfs track images/` instead.
  - For other options, check out the [gitignore pattern format][gitignore]. Git LFS uses the same format!
- Add and commit your binary files as normal. (e.g. `git add big-data.dat && git commit -m "Adding our Big Data, powered by Git LFS!"`)

## How it works

Rather than commit your 6GiB "Big Data" file to Git naïvely, LFS uses a handful of extension points already provided by Git: a plaintext "pointer file" added to the index as normal, a `pre-push` Git hook to upload changed files, and a set of `.gitattributes` options to wire up diffing, filtering, and merging.

The pointer files used by Git LFS describe the file to be tracked, which Git LFS will use in its commands and scripts to infer where to find updated files, where to upload local updates, and so forth. This is what one of these files looks like:

```
version https://git-lfs.github.com/spec/v1
oid sha256:6fe2e48ef494b7855e6d8f93c59cf38d38350274e304a9ac35102d5c365ee002
size 620773
```

The `.gitattributes` options (generated by Git LFS when you run `git lfs track`) direct Git to use a set of globally configured filters whenever `git commit`, `git diff`, `git merge`, and the like try to target LFS-tracked files. This filter is configured when you run `git lfs install`, looking something like this:

```
[filter "lfs"]
  clean = git-lfs clean -- %f
  smudge = git-lfs smudge -- %f
  required = true
  process = git-lfs filter-process
```

One of the primary roles for these filters is to ensure only pointer files wind up tracked in the Git index, even though the original binary files remain in the working tree. Likewise, these filters ensure only the pointer file is _stored_ in Git's primary object storage (i.e. `.git/objects`), while the binary file and its changes are stored in a separate location (`.git/lfs/objects`). (For more information on filters in general, [this][gitattributes] is a good primer on the topic.)

Finally, the `pre-push` hook (generated alongside those `.gitattributes`) intercepts your calls to `git push`, uploading the original, locally changed binary files just before Git uploads new and updated pointer files.

When you pull the repository onto another machine, the pointer files direct Git LFS to download the binary files needed by the new `HEAD`. If 90% of the binary files in the history of the repo aren't needed by the `HEAD` commit, then that 90% isn't downloaded (and your local copy will be that much smaller for it).

## Concerns

The primary concern with Git LFS is that it _does_ require using an extension—for the time being, Git LFS does not come with Git. If a team member _does not_ have Git LFS installed, all they will see is the pointer file, not the original binary.

If you'd like to see this in action, [this repo][test-repo] explains how to create this scenario using a pair of Docker containers, one with LFS installed, and one without.

(Another potential concern might be users editing pointer files directly, although I did not find evidence or discussion of this at the time of writing.)

## Git server support

The following Git hosts currently support hosting Git-LFS-tracked files:

- GitHub ([announcement](https://github.com/blog/1986-announcing-git-large-file-storage-lfs))
- GitLab ([announcement](https://about.gitlab.com/2015/11/23/announcing-git-lfs-support-in-gitlab/))
- BitBucket ([announcement](https://confluence.atlassian.com/bitbucketserver/bitbucket-server-4-3-release-notes-794211212.html))
- Visual Studio Online / Visual Studio Team Services ([announcement](https://blogs.msdn.microsoft.com/visualstudioalm/2015/10/01/announcing-git-lfs-on-all-vso-git-repos/))

More information on server support can be found on the [Git LFS wiki][implementations].

## Git client support

In addition to the command-line Git LFS client, many graphical Git clients support Git LFS:

  - GitHub Desktop ([demo](https://www.youtube.com/watch?v=uLR1RNqJ1Mw))
  - SourceTree ([announcement](https://blog.sourcetreeapp.com/2016/02/22/sourcetree-update-atlassian-account-git-lfs-support-ui-refresh-and-more/))
  - Tower ([FAQ](https://www.git-tower.com/help/mac/faq-and-tips/faq#faq-git-lfs))
  - SmartGit ([release notes](https://www.syntevo.com/smartgit/whatsnew))
  - GitUp ([wiki](https://github.com/git-up/GitUp/wiki))

Notably, GitKraken does not yet support Git LFS. See [their FAQ](https://support.gitkraken.com/faq) for more information.

(I tried to find if GitX supports LFS, and couldn't find anything definitive. [This issue][gitx-issue] was the closest I could find, and it hasn't been addressed at the time of writing.)

## Alternatives

Knowing the risks of checking in unmergeable, uncompressable, or frequently-changing binaries, one alternative is to _check them into Git anyway_. For an internal Test Double project, this is exactly what we did. For your project, it might be undesirable.

Another alternative would be to write your own, using some of the same techniques Git LFS does: `.gitattributes` and hooks. If you want to support custom workflows, for example, this may be the easiest way to go about it. For most projects, this should be unnecessary.

Lastly, you could write a set of tools _around_ git that similarly manage binary files in cold storage like Amazon's S3. If you have files that shouldn't be versioned in tandem with the rest of the project, but should be made available to all contributors, this is a solid alternative.

All of these alternatives come with a maintenance burden over time—buyer, beware.

## Additional reading

For more information, check out the core [Git LFS documentation][core-docs]. In particular, the following documents are useful jumping-off points:

- [This document][server-discovery] on "server discovery": pointing uploads at a specific server _independent_ of the location of the Git remote.
- [This document][extensions] on "extensions": hooking and wrapping the core LFS behaviour, e.g. adding a wrapper to sign files before upload.
- [The spec for Git LFS][spec], which goes into further detail of the inner-workings of Git LFS.

[git-lfs]: https://git-lfs.github.com/
[ddd-ux]: http://www.uxmatters.com/mt/archives/2016/02/five-best-practices-for-becoming-a-data-driven-design-organization-part-1.php
[ddd-games]: https://www.cs.cornell.edu/courses/cs3152/2014sp/lectures/14-DataDriven.pdf
[ddd-software]: https://en.wikipedia.org/wiki/Domain-driven_design
[ecs]: https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system
[migration-example]: http://guides.rubyonrails.org/v3.2.21/migrations.html
[model-example]: http://guides.rubyonrails.org/active_record_basics.html
[perforce]: https://www.perforce.com/
[git-push-deploy]: https://github.com/substack/pushover
[gitignore]: https://git-scm.com/docs/gitignore#_pattern_format
[test-repo]: https://github.com/Schoonology/git-lfs-test
[implementations]: https://github.com/git-lfs/git-lfs/wiki/Implementations
[core-docs]: https://github.com/git-lfs/git-lfs/tree/master/docs
[server-discovery]: https://github.com/git-lfs/git-lfs/blob/master/docs/api/server-discovery.md
[extensions]: https://github.com/git-lfs/git-lfs/blob/master/docs/extensions.md
[spec]: https://github.com/git-lfs/git-lfs/blob/master/docs/spec.md
[size-test]: https://github.com/Schoonology/git-lfs-size-test-generator
[gitattributes]: https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes#Keyword-Expansion
[gitx-issue]: https://github.com/rowanj/gitx/issues/457
