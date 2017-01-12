---
title: "Backpressure Basics"
author:
  name: "Michael Schoonmaker"
  url: "http://twitter.com/Schoonology"
reddit: false
---

The high-level premise is that correctly applying backpressure is the primary tool for managing any exceptional state in a distributed application: even the humblest of web applications.

- Concepts
  - What is backpressure?
  - What is the "high water mark"?
- Techniques
  - Queueing Messages
  - Blocked Queues
  - Dropping Messages
  - Propagation of Backpressure
- Applications
  - Exceptions as backpressure (queue/drop)
  - Spinners as backpressure (block/propagation)
  - 503 as backpressure
  - CDNs and backpressure
- Examples
  - TCP/IP (provides almost none)
  - HTTP (provides all)
  - HAProxy/nginx (round-robin/fair-queued, dropping)
  - Rails/REST?
  - Node/Websocket?
