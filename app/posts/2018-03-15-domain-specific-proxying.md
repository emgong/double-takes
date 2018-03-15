---
title: "Domain specific proxying through a jump box"
description: "Using proxy auto configuration with on-demand SOCKS over SSH tunnels"
author:
  name: "Jacob Smith"
  url: "http://jacobsmith.io"
---

Let's say you're trying to access a super-secret web service at `https://secret.example.com`. You open the URL in your browser, but your connection is rejected.

<figure>
  ![Forbidden Page](/img/2018-03-15-domain-specific-proxying/forbidden.png)
</figure>

Turns out you need to contact their support team and give them your IP address so they can add it to their whitelist.

Or perhaps even worse, your whole distributed team needs to be able to access this web service. Or maybe the web service lives on a private network, to which you have SSH access but not VPN access. What these scenarios have in common is that you need to proxy some of your HTTP traffic through a server you have SSH access to, but you also don't want to be bothered to fire up an SSH session and change your browser's proxy configuration every time you need access.

You could use a VPN that provides an IP list, but then you're probably sending _all_ of your traffic through the VPN, even if you don't need to, and you're also allowing all of the users of that VPN access to your secret web service.

You could use a web proxy for all of your browser traffic, but then again, you're then proxying all of your browser traffic, which comes with significant performance impact if you don't need it, and any users of that same proxy would also have access.

This is a frequent enough scenario as a remote consultant, so I've landed on the solution of using on demand SSH tunnels and auto proxy configuration so only the traffic I need proxied goes through a jump box I control.

## tl;dr
In this article, I'll be walking through

- Setting up a SOCKS proxy over SSH
- Configuring `launchd` to launch our SSH proxy on demand
- Setting up a Proxy Auto-Configuration file to use our SOCKS proxy.
- Configuring `launchd` to launch an HTTP server to serve our PAC file.
- Setting up our system to use our custom PAC file.

## Requirements
I assume you are using macOS for your client machine. The basic principles apply on Linux (Using [`upstart-socket-bridge`](http://manpages.ubuntu.com/manpages/trusty/man8/upstart-socket-bridge.8.html) on Ubuntu for example), but I'm unaware of a way to get this to work on Windows.

I also assume you already have a server that you have SSH access to. It should have a static IP so you can register its IP address with the web service you are trying to access. I use [Digital Ocean](https://www.digitalocean.com) (you can get $10 in credit if you use my [referral link](https://m.do.co/c/d58cef18e39d)). For $5 a month you can get a VPS with a static IP, 1GB of RAM, and 1TB of network transfer, so I use a single VPS for a jump box, a pairing machine, and a cloud development environment (using [Blink](http://www.blink.sh) on my iPad).

Finally, I'm going to assume you understand SSH and SOCKS proxying pretty well. If not, shoot me an email at jacob [at] testdouble.com and I'll write another post about that stuff!

## Configuring SSH with your jump box IP

The first step is to add your jump box's IP address to your SSH config. This is handy so that the name you use is decoupled from the actual server you use, and it's nice to be able to share configuration between what you type on the command line and what your daemons use.

**`~/.ssh/config`**

```
Host jumpbox
    HostName 1.2.3.4
    User myusername
```

Now we should be able to establish an SSH connection:

`$ ssh -C -n -N -D 8082 jumpbox`

- `-C` requests that data be compressed
- `-n` tells the ssh process to not read stdin. This isn't really required when we're running SSH in the foreground, but is required when there is no stdin (when we run in a daemon).
- `-N` tells the process not to run any remote commands. We _could_ open a shell on the server if we want, but that would almost definitely cause trouble when we daemonize our tunnel.
- `-D 8082` specifies a dynamic application-level port forward using the SOCKS protocol. This is probably a whole other blog post for another time, but that means that this does _not_ suffer from the [well known](http://sites.inka.de/bigred/devel/tcp-tcp.html) performance problems of using TCP over TCP, which seems to confuse some people.

Technically, you could have configured a lot of this stuff in `~/.ssh/config`, but then _all_ of your SSH connections to your jump box would use those options. Personally, I prefer just the username, hostname, and the identify file (if using something other then the default). If I need to create shortcuts to avoid remembering all of the command line flags, I'll use shell aliases.

## Proxying all your web traffic through your jump box

With your SSH tunnel running in your terminal, you can configure your system to proxy all your HTTP(S) traffic through the SSH SOCKS proxy in `System Preferences → Network → Advanced... → Proxies`

<figure>
  ![SOCKS Settings](/img/2018-03-15-domain-specific-proxying/socks-settings.png)
</figure>

Now all your traffic should be proxied through your server, so from the perspective of the secret web service, the origin IP address of your traffic is the IP address of your server:

<figure>
  ![Unlocked Page](/img/2018-03-15-domain-specific-proxying/unlocked.png)
</figure>

Success!

The problem is that:
- _All_ of our web traffic is going through the proxy, which is _slow_, and also potentially using up all of our VPS bandwidth, and maybe we don't want all of our web traffic exposed to whoever else has access to our server.
- It's also annoying to have to spin up an SSH session in our terminal every time we need access to the web service.

## Configuring the SSH tunnel to run as needed

The next step is to daemonize our SSH session using [`launchd`](https://en.wikipedia.org/wiki/Launchd). If you are running Linux, you'll have to use upstart or whatever your system is configured with. On macOS, we just need to create a configuration file for our daemon:

**`~/Library/LaunchAgents/com.example.proxy-connection.plist`**

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.example.proxy-connection</string>
    <key>ProgramArguments</key>
    <array>
      <string>ssh</string>
      <string>-C</string>
      <string>-n</string>
      <string>-N</string>
      <string>-D</string>
      <string>8082</string>
      <string>jumpbox</string>
    </array>
    <key>Sockets</key>
    <dict>
      <key>Listeners</key>
      <dict>
        <key>SockServiceName</key>
        <string>8082</string>
        <key>SockType</key>
        <string>stream</string>
        <key>SockFamily</key>
        <string>IPv4</string>
      </dict>
    </dict>
  </dict>
</plist>
```

And then tell the system to load it:

`$ launchctl load ~/Library/LaunchAgents/com.example.proxy-connection.plist`

I'm going to ignore all of the flags to `ssh` since those were covered above, but let's look at the `Sockets → Listeners` section:

`SockServiceName → 8082` tells `launchd` that on login (this is a launch agent, as opposed to a launch daemon, which runs on boot), it should [`bind()`](https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man2/bind.2.html) a [`socket()`](https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man2/socket.2.html#//apple_ref/doc/man/2/socket) on port `8082`. The `SockType → stream` configuration configures the socket for TCP traffic, the odd parlance is because of the BSD (and Linux) system specification.

What all of that means is that instead of the SSH client creating a socket, `launchd` creates the socket. It doesn't actually run the program (`ssh` in this case) until a connection is made to that socket, at which point it hands the socket to the program. Or more simply, it means that SSH doesn't need to run constantly, but only on-demand. If port 8082 is never accessed, SSH is never launched, which saves us some CPU and memory resources.

So that solves your "I don't feel like running ssh in a terminal every time I have to access the secret web service" problem, but we're still sending _all_ of our web traffic through our SOCKS proxy. Let's fix that with Proxy Auto-Configuration.

## Introduction to Proxy Auto-Configuration

> A Proxy Auto-Configuration (PAC) file is a JavaScript function that determines whether web browser requests (HTTP, HTTPS, and FTP) go directly to the destination or are forwarded to a web proxy server.  
>   
> – [Proxy Auto-Configuration (PAC) file](https://developer.mozilla.org/en-US/docs/Web/HTTP/Proxy_servers_and_tunneling/Proxy_Auto-Configuration_%28PAC%29_file)

Sounds easy enough, right? Well, they're pretty tricky to debug since you don't have `console.log` or anything, but the basic idea is we need to write a JavaScript function named `FindProxyForURL(url, host)` that returns the proxy configuration based on the url or host. Unfortunately, pretty much all browsers are configured to strip all paths and query parameters from the URL, so effectively the only difference between `url` and `host` is the protocol.

## Configuring PAC to proxy certain traffic through our jump box

Fortunately for us, the web service we care about can be distinguished by hostname (`secret.example.com`), so we can use the following PAC file to proxy our requests to that host, but use a direct connection for all other hosts.

**`~/.config/proxy.pac`**

```
const whitelist = [
  'secret.example.com'
]

function shouldProxy (_url, host) {
  return whitelist.includes(host)
}

function FindProxyForURL (url, host) {
  if (shouldProxy(url, host)) {
    return 'SOCKS localhost:8082'
  }
  return 'DIRECT'
}
```

Since this is based on the actual PAC file I used, it's a little more complicated then necessary, since I have many domains I proxy, but the idea is that we can add domains to the `whitelist` array and they will be proxied through our jump box, but all other domains will not.

In order to get this PAC file to our system so it can know what to proxy, we first need to serve it over HTTP. In older versions of Mac OS X, you could just use `file:///path/to/proxy.pac`, but newer versions disallow that mechanism, so let's set up a `launchd` daemon to serve our file over HTTP on demand.

## Configuring an HTTP server to serve our custom PAC file
We write our daemon configuration:

**`~/Library/LaunchAgents/com.example.pac-server.plist`**

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.example.pac-server</string>
    <key>ProgramArguments</key>
    <array>
      <string>sh</string>
      <string>-c</string>
      <string>ruby -run -e httpd $HOME/.config/proxy.pac -p8000</string>
    </array>
    <key>Sockets</key>
    <dict>
      <key>Listeners</key>
      <dict>
        <key>SockServiceName</key>
        <string>8000</string>
        <key>SockType</key>
        <string>stream</string>
        <key>SockFamily</key>
        <string>IPv4</string>
      </dict>
    </dict>
  </dict>
</plist>
```
  
And load it into `launchd`:

`$ launchctl load ~/Library/LaunchAgents/com.example.pac-server.plist`

We need to actually use `sh` to run our program since `launchd` doesn't know anything about `~` or `$HOME`, and who wants to use hard coded username paths? Otherwise, the basic idea here is that we're running a web server with Ruby that serves our file over HTTP on port 8000.

And now we should be able to fetch our PAC file over HTTP with `$ curl localhost:8000`:

<figure>
  ![Fetching the PAC file with curl](/img/2018-03-15-domain-specific-proxying/curl.png)
</figure>

Now we just need to tell our OS to use that PAC file.

## Configuring our system to use our custom PAC file

Going yet again to `System Preferences → Network → Advanced... → Proxies`, let's turn off our `SOCKS Proxy` setting and use `Automatic Proxy Configuration` instead:

<figure>
  ![Proxy Auto Configuration Settings](/img/2018-03-15-domain-specific-proxying/pac-settings.png)
</figure>

Now `launchd` will spin up a SOCKS proxy over SSH whenever we make a request to `https://secret.example.com`. It's just that easy! 😓


