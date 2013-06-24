---
title: "the sourcemap workflow pipeline"
author:
  name: "David Mosher"
  url: "https://github.com/davemo"
tldr:
  title: "sourcemaps are useful for more than just debugging transpiled languages"
  body: """
        You can use sourcemaps in three different ways during the construction of javascript applications intended for consumption in a browser:

        in development:

        - to visualize/debug a single piece of a concatenated bundle of javascript files
        - to visualize/debug a single piece of a transpiled language file that is output as javascript

        in staging:

        - to visualize/debug a single piece of both of the above in a staging environment

        HELP FORMATTING!
        """
---

Somebody told you sourcemaps were the cats meow; you went to google and [searched for "sourcemaps"](https://www.google.ca/#gs_rn=17&gs_ri=psy-ab&tok=3vcUDNDlAA82XO_tKwkYeQ&suggest=p&cp=10&gs_id=12&xhr=t&q=sourcemaps&es_nrs=true&pf=p&output=search&sclient=psy-ab&oq=sourcemaps&gs_l=&pbx=1&bav=on.2,or.r_cp.r_qf.&bvm=bv.48293060,d.dmQ&fp=c3cfede1bb20378a&biw=1366&bih=647), watched a few of the videos out there and read a couple of articles, but you're still left with wondering "sourcemaps, what are they good for?"

Well, the answer is: a few things! This post explores some of the uses in the context of a sourcemap workflow pipeline and attempts to provide an avenue for discussion around how developers are using sourcemaps in their workflows right now.

# The Elevator Pitch

[INSERT AMAZING INTRO BLOCK OF TEXT HERE]

# Implications

- browser support for the dev tools (chrome/firefox)
- you'll need to upload the original files so they are accessible
-- (todo: does [sourcesContent](https://github.com/mozilla/source-map#new-sourcemapconsumerrawsourcemap) make this uploading optional?)

# Visualizing & Debugging JavaScript Asset Bundles

# A Sourcemap Pipeline

## 1: Concatenated, Unminified, Development Bundles

- useful and performant to develop against a single, concatenated, unminified bundle of javascript
- not so useful: having to debug in a single file
- first use of sourcemaps: mapping original source files to allow debugging without the headache of serving a bajillion script tags to the browser in development
- sourcemaps generated here can be used as input sourcemaps in stage 3

## 2: Concatenated, Transpiled, Development Bundles (like CoffeeScript, TypeScript)

- is it useful to debug in the transpiled language directly?
- given javascript is what actually runs in the browser, does it make more sense just to debug there?
-- question of value: is it important to get familiar with the generated javascript that transpilers emit?
- sourcemaps generated here can also be used as input sourcemaps in stage 3

## 3: Concatenated, Minified,   Staging/Production Bundles

- is it even appropriate to upload source maps to production?
- do most developers actually do this or do they only go into staging?
- consumes the sourcemaps from stage 1 and stage 2 to generate a final sourcemap

# Conclusions

- more people need to talk about _how_ they use sourcemaps!
- sourcemaps are now a suitable thing to use in your workflow, use em!
- more than just for debugging transpiled languages, sourcemaps should be used in a variety of instances
