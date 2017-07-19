---
title: "Remote Pairing with Tmate and Tmux"
description: "Have an existing tmux session? Need to pair remotely? Share it with tmate!"
subtitle: "Share an existing tmux session with tmate"
author:
  name: "Sam Jones"
  url: "http://twitter.com/samjonester"
reddit: false
---

## Here's the situation.

You love [tmux][tmux], and you use it all the time to organize your terminal and create a workspace. You've created a new tmux session where you will do your work named `awesomework`.

``` sh
tmux new-session -s awesomework
```

Then you've created a bunch of windows, splits, and running processes, and **now you would like to pair**.

Uh-Oh! tmate won't work because you want share this existing session.... *or will it*???


-------------

## Turns out you can share that tmux session with tmate

[Tmate][tmate] is used as a way to share your terminal. It is not super secure because a key is not required to connect, but it sure is convenient. Inside that shared terminal we will connect to our tmux session and continue development with our pair.

### Tmate Configuration

Tmate allows a configuration file to overlay your `~/.tmux.conf` file. You can do this by creating the following file at `~/.tmate.conf`. This example will set up tmate to be as non-intrusive as possible, allowing you to focus on the tmux session you're working in.

```
## tmate

# Reassign prefix to not conflict with tmux
set -g prefix C-]
bind-key ] send-prefix

# turn off status bar so tmate is invisible
set -g status off

# Fix timeout for escape key
set -s escape-time 0
```

### Scripting the Integration
The following functions script the integration between tmate and tmux. This allows a new tmate session to be started and automatically load an existing tmux session for sharing. To do this, add the following functions to your `~/.bashrc`.

``` sh
# TMATE Functions

TMATE_PAIR_NAME="$(whoami)-pair"
TMATE_SOCKET_LOCATION="/tmp/tmate-pair.sock"
TMATE_TMUX_SESSION="/tmp/tmate-tmux-session"

# Get current tmate connection url
tmate-url() {
  url="$(tmate -S $TMATE_SOCKET_LOCATION display -p '#{tmate_ssh}')"
  echo "$url" | tr -d '\n' | pbcopy
  echo "Copied tmate url for $TMATE_PAIR_NAME:"
  echo "$url"
}



# Start a new tmate pair session if one doesn't already exist
# If creating a new session, the first argument can be an existing TMUX session to connect to automatically
tmate-pair() {
  if [ ! -e "$TMATE_SOCKET_LOCATION" ]; then
    tmate -S "$TMATE_SOCKET_LOCATION" -f "$HOME/.tmate.conf" new-session -d -s "$TMATE_PAIR_NAME"

    while [ -z "$url" ]; do
      url="$(tmate -S $TMATE_SOCKET_LOCATION display -p '#{tmate_ssh}')"
    done
    tmate-url
    sleep 1

    if [ -n "$1" ]; then
      echo $1 > $TMATE_TMUX_SESSION
      tmate -S "$TMATE_SOCKET_LOCATION" send -t "$TMATE_PAIR_NAME" "TMUX='' tmux attach-session -t $1" ENTER
    fi
  fi
  tmate -S "$TMATE_SOCKET_LOCATION" attach-session -t "$TMATE_PAIR_NAME"
}



# Close the pair because security
tmate-unpair() {
  if [ -e "$TMATE_SOCKET_LOCATION" ]; then
    if [ -e "$TMATE_SOCKET_LOCATION" ]; then
      tmux detach -s $(cat $TMATE_TMUX_SESSION)
      rm -f $TMATE_TMUX_SESSION
    fi

    tmate -S "$TMATE_SOCKET_LOCATION" kill-session -t "$TMATE_PAIR_NAME"
    echo "Killed session $TMATE_PAIR_NAME"
  else
    echo "Session already killed"
  fi
}
```

### Sharing with tmate

Open a pair session and attach to you existing tmux session. The tmate share url is printed and copied to your (OS X) clipboard.

``` sh
tmate-pair foo
```

Open a pair session with a blank terminal.

``` sh
tmate-pair
```

### Ending a pair

After your done, close down tmate. This will detach all clients from the shared tmux session if one was provided when starting the pair.

``` sh
tmate-unpair
```

<hr/>
<p><a rel="canonical" href="https://samljones.com/2017-07-19/remote-pair-tmate-tmux/">Sam's original post</a></p>

[tmux]: https://github.com/tmux/tmux/wiki
[tmate]: https://tmate.io/
