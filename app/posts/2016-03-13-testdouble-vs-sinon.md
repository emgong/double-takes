---
title: "testdouble.js vs. sinon.js"
author:
  name: "Justin Searls"
  url: "http://twitter.com/searls"
  googlePlus: "https://plus.google.com/+JustinSearlsTestDouble"
reddit: false
---
<div class="side-by-side-code-examples"></div>

I _hate_ "X upstart vs. Y incumbent" technology posts. They're reductive,
provocative, and they cherry pick contexts favorable to the Shiny New Thing™ over
the older, broader standard-bearer.

If you're happy using [Sinon.js](http://sinonjs.org) then stop reading and
send [@cjno](https://twitter.com/cjno) a tweet and thank him for his hard work.
If you're already convinced you want to try
[testdouble.js](https://github.com/testdouble/testdouble.js), start by perusing
[our docs](https://github.com/testdouble/testdouble.js#docs) and playing with its
API.

For the rest of you, please enjoy this reductive, provocative, and narrow
glimpse into the things that frustrated me about the API of Sinon.js and how I
designed testdouble.js to better suit how I want to write isolated unit tests in
JavaScript.

## Creating a test double

Sadly, the vast majority of developers don't know or care to learn the nuanced
differences between spies, stubs, fakes, mocks; or what a "partial" test double
is and why they're usually a bad idea. As a result, it's not helpful when this
jargon leaks into the API.

Here's how to create a test double function in each library:

testdouble.js
``` js
var honk = td.function()
var honk = sinon.stub() // or sinon.spy() if verifying i can keep going until i a
```

Sinon.js
``` js
var honk = sinon.stub() // or sinon.spy() if verifying i can keep going until i a
```

And now i'll talk about other stuff and junk

testdouble.js
``` js
var honk = td.function()
```

Sinon.js
``` js
var honk = sinon.stub() // or sinon.spy() if verifying
```


## Specific by default

## Symmetrical APIs
