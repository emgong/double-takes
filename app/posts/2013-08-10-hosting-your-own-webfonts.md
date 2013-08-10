---
title: "Hosting your own webfonts."
tldr:
  title: "No one file is enough"
  body: """
        It turns out that if you want to serve up your own webfonts, no single
        file is ever enough to ensure that the font appears cleanly in every
        browser and operating system. Instead, generate ttf, eot, svg, and woff
        files and then define an exhaustive <strong>@font-face</strong>
        declaration block.
        """
author:
  name: "Justin Searls"
  url: "http://about.me/searls"
---

When I first added a webfont to <a href="http://testdouble.com">test double</a>'s web
site, I didn't realize that only hosting a ".woff" file was not enough
to ensure sharp rendering across browsers and operating systems. The font
looked fine in Safari on OS X, a little aliased on Chrome on OS X, a jagged
mess on Chrome in Windows, and almost invisible Internet Explorer.

As it turns out, browser filetype support is all over the place. Some browsers
will (apparently, my knowledge of this is limited to my own frustrations)
attempt to degrade gracefully when only a non-preferred filetype is provided.
What's really odd, however, is that even if you provide a browser's preferred
font filetype, it will sometimes render the font more accurately (with better
kerning and anti-aliasing) if you *also provide font files it doesn't prefer*.
Who knows why that is. Browsers.

Anyway, here's how I recommend going about hosting your own fonts on the web.

1. Find OTF or TTF files for the various weights and styles of your font.
2. Visit [Font Squirrel's webfont
generator](http://www.fontsquirrel.com/tools/webfont-generator) and upload each
weight and style of your font that you'd like, selecting the **Optimal** option.
3. Download your kit, then copy all the newly generated `eog`, `.svg.`, `.ttf`,
and `.woff` font files into any publicly available path of your web application
4. Define your `@font-face` declarations (one per style & weight) to point at
your new web font styles.

Here's the CSS declaration I'm currently finding success with:

``` css
@font-face {
  font-family: 'Source Sans Pro';
  src: url('../webfonts/sourcesanspro-regular-webfont.eot');
  src: url('../webfonts/sourcesanspro-regular-webfont.eot?#iefix') format('embedded-opentype'),
       url('../webfonts/sourcesanspro-regular-webfont.woff') format('woff'),
       url('../webfonts/sourcesanspro-regular-webfont.ttf') format('truetype'),
       url('../webfonts/sourcesanspro-regular-webfont.svg#source_sans_proregular') format('svg');
  font-weight: 400;
  font-style: normal;
}
```

In the above, my CSS is being served from `/app/css/fonts.css` and my webfonts are in `/app/webfonts`.

It's also important to specify a `font-weight` and `font-style` in accordance
with each font file. This step can be a little confusing, as each font creator
seems to have their own nomenclature for font weights. But at the end of the
day, all that matters is that the font-weight you assign matches whatever weight
your CSS specifies.




