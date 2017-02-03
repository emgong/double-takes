---
title: "Cloning a Local Repo Over HTTP"
author:
  name: "Michael Schoonmaker"
  url: "http://twitter.com/Schoonology"
reddit: false
---

For fully distributed companies like Test Double, Git hosts like GitHub and BitBucket have become essential for collaboration. Rather than hiring sysadmins to maintain an in-office, intra-networked filesystem, we rely instead on shared hosting by experts and SaaS licensing.

At its core, however, Git was intended as a _Distributed_ Version Control System, (One of the core design decisions was [What Would CVS Never Do?](https://youtu.be/4XpnKHJAok8?t=2m39s)) and the boon of these shared sources of truth quickly becomes the bane of a single point of failure.

Fortunately, even repos hosted on one of these services still can be shared peer-to-peer, over nothing more than HTTP, with nothing more than a handful of tools (conveniently hosted on GitHub!).

## 1. Serve your local repository over HTTP

The first step is to ensure your local repository is available via HTTP. There are plenty of local, ad hoc HTTP servers available, though here are a few solid options:

- Node: [http-server](https://github.com/indexzero/http-server)
- Python 2: [SimpleHTTPServer](https://docs.python.org/2/library/simplehttpserver.html)
- Python 3.3: [http.server](https://docs.python.org/3.3/library/http.server.html)
- Ruby: [httpd](https://twitter.com/tenderlove/status/351554818579505152)

Whatever option you choose, host the `.git` folder in the repo you want to share, and take note of what port it's served over. (Examples will use the Ruby `httpd` built-in, and will serve the repo over port 8080.)

```
$ cd /some/git/repo
$ ruby -run -e httpd .git -p 8080
```

## 2. `git update-server-info`

Next, we need to add a little extra information to our Git repository that a more complete Git server would handle for us. More technical details can be found in the [official documentation](https://git-scm.com/docs/git-update-server-info), but for the sake of our current objective, we just need to run `git update-server-info` inside our Git repo (where you would run `git checkout`).

```
$ git update-server-info
```

## 3. Make your HTTP server reachable

At this point, our server can be cloned on by any machine that can reach our HTTP server. For most options from Step 1, only machines on your local network will be able to reach your machine. Fortunately, there are simple tools that can provide remote access to local servers:

- [ngrok](https://ngrok.com/) (Recommended)
- [PageKite](https://pagekite.net/)
- [Forward](https://forwardhq.com/)

Each of these tools will have a different method of invoking it, but (using ngrok in our example) you'll need to inform it of which local port the HTTP server from Step 1 is bound to.

```
$ ngrok http 8080
ngrok by @inconshreveable

Session Status                online
...
Forwarding                    https://3e5b48dd.ngrok.io -> localhost:8080
```

Now that your forwarding tool is running, take note of the _public URL_ provided (you can forget your local port number now, if that makes things easier). In our example, this URL is `https://3e5b48dd.ngrok.io`.

## 4. Clone

Finally, share that URL with anyone you want to be able to clone or pull from your repository. (In our example, we provide a path for Git to use when cloning the repo. If you don't, Git will use the URL as the path.)

```
$ git clone https://3e5b48dd.ngrok.io my-local-version
```

## Optional: Collaborate

At this point, anyone with the URL from Step 3 can pull code from your local repository. Without a complete Git daemon, they cannot _push_ to your local repository, and you will need to run `git update-server-info` every time you make a change on your machine (e.g. after each new commit).

That said, with a few process changes, this model of development _can_ replace a shared host like GitHub:

- Instead of creating a Pull Request on GitHub, directly tell your collaborator(s) to `git pull` your remote.
- If each collaborator hosts their own local Git repo, you can `git origin add` each, named by collaborator, allowing you to accept "pull requests" from anyone.
- Build machines, web hosts, and other collaborative servers can extend this model using [bare repositories](https://git-scm.com/book/ch4-2.html) and [githooks](https://git-scm.com/docs/githooks).
