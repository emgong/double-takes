# double-takes

Home of Test Double's official blog. http://blog.testdouble.com

## Adding a post

First, add a post as a markdown file to `app/posts`. Name it like so: "YYYY-MM-DD-url-slug-title.md"

So, for example, you might create a post named `app/posts/2013-06-15-kramer-is-super-cool.md`.

Each post is comprised of a header (which supplies necessary metadata for the layouts to render appropriately) and a post body.

So here's an example post, with all the goodies filled out.

``` markdown
---
title: "Kramer sure is super cool"
description: "Kramer writes good meta descriptions for the google juice"
tldr:
  title: "Kramer writes great code"
  body: """
        Here I write a really quick conclusion about Kramer and his code.
        """
date: "2013-06-15"
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
video:
  type: "youtube"
  url: "http://www.youtube.com/embed/PWHyE1Ru4X0"
---

# section title here

first real paragraph here
```

That said, more minimal header configuration are possible, too. For instance, if you omit the author field, a byline won't display. If you omit a video object, no video will display (and the title will be reformatted somewhat).

Additionally, "date" and "title" are only necessary if the file name's date differs from the title or publication date. In general, it's a bad idea to change the file slug once the page gets deployed since the hyperlink will break, so if a change is needed make sure to favor the header variables.

In fact, if you don't supply a header at all, your post should still render okay. However, it's probably the case that you want to display at least an author name or a tl;dr section.

## Running and building the blog

Here's [a screencast](https://www.youtube.com/watch?v=raznFJedCZM) that shows how the site is built.


### Installing

After cloning this repo, we'll need to install [lineman](http://linemanjs.com) globally.

```
$ npm install -g lineman
```

After that, we can install dependencies.

```
$ npm install
```

### Running

You can run a local copy of the blog by running

```
lineman serve
```
