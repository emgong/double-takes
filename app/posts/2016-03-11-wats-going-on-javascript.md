---
title: "Wat's Going On, JavaScript Edition"
author:
  name: "Schoon"
  url: "http://twitter.com/Schoonology"
reddit: false
---

<script charset="ISO-8859-1" src="//fast.wistia.com/assets/external/E-v1.js" async></script><div class="wistia_responsive_padding" style="padding:56.25% 0 28px 0;position:relative;"><div class="wistia_responsive_wrapper" style="height:100%;left:0;position:absolute;top:0;width:100%;"><div class="wistia_embed wistia_async_mk5lvhoqgt videoFoam=true playerColor=00e600 preload=true playButton=false" style="height:100%;width:100%">&nbsp;</div></div></div>

A quick, 5-minute video explaining the JavaScript portions of Gary Bernhardt's
infamous ["Wat"][wat] talk.

<!-- more -->

## For bonus points (after watching the video)

When Gary gave this talk, `jsc` was the go-to JavaScript REPL, and it's still
made available on off-the-shelf Macs. That said, Node has become _pervasive_,
and I'd argue more web developers today would jump to `node` to give a talk
like this before `jsc`. That said, you _cannot_ replicate Gary's middle slide
(the second I examine) with `node`:

```js
> [] + []
''
> [] + {}
'[object Object]'
> {} + []
0
> {} + {}
'[object Object][object Object]'
```

What changed?

## Relevant links

- [Wat][wat]
- [ECMA-262, 5.1 Edition][spec]
- <a rel="canonical" href="https://www.schoonology.com/technology/wats-going-on-javascript/">Schoon's original post</a>

[schoon]: https://www.schoonology.com/technology/wats-going-on-javascript/
[wat]: https://www.destroyallsoftware.com/talks/wat
[spec]: http://www.ecma-international.org/ecma-262/5.1/
