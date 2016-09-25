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

So, if you're happy using [Sinon.js](http://sinonjs.org) then stop reading and
send [@cjno](https://twitter.com/cjno) a tweet to thank him for his hard work.
If you're already convinced you want to try
[testdouble.js](https://github.com/testdouble/testdouble.js), start by perusing
[our docs](https://github.com/testdouble/testdouble.js#docs) and playing with its
API.

For the rest of you, please enjoy this reductive, provocative, and narrow
glimpse into the things that frustrated me about the API of Sinon.js and how I
designed testdouble.js to better suit how I want to write isolated unit tests in
JavaScript.

Here are the topics we'll be covering:

1. [Creating test doubles](#creating-a-test-double)
2. [Injecting dependencies](#injecting-dependencies)
3. [Stubbing responses](#stubbing-responses)
4. [Verifying invocations](#verifying-invocations)
5. [Introspection](#introspection)
6. [Conclusion](#conclusion)

## Creating a test double

Here's how to create a test double function in each library:

testdouble.js
``` javascript
// whether stubbing or verifying
var honk = td.function()
```

Sinon.js
``` javascript
// stubbing a response
var honk = sinon.stub()

// verifying an invocation
honk = sinon.spy()

// pre-asserting an invocation
honk = sinon.mock()
```

Sadly, the vast majority of developers don't know or care to learn the nuanced
differences between spies, stubs, fakes, mocks; or what a "partial" test double
is and why they're usually a bad idea. As a result, it's not helpful when this
jargon leaks into the API of test double libraries.

In testdouble.js, there is a single type of test double function, designed to
stand-in for any real function your subject under test depends on. It can serve
as a stub or a spy, and its role isn't determined by how the user creates it,
but rather by how the user chooses to configure it.

<div class="aside">
I don't know why Sinon.js offers both a mock and a spy API. Because
there are no situations (apart from legacy rescue) where a mock function is more
appropriate than a spy, and because mocks violate [arrange-act-assert](
https://github.com/testdouble/contributing-tests/wiki/Arrange-Act-Assert), I'll
disregard mocks from this point forward. It's the first of several areas where I
wish Sinon.js were more narrowly focused and opinionated.
</div>

### Creating test double objects

In addition to creating test double functions, both libraries provide some
conveniences for creating objects of test double functions. One they share is to
mimic a prototypal constructor and return test doubles for all its functions.

Given a function `Dog`:

<div class="wide"></div>
``` javascript
function Dog() {}
Dog.prototype.woof = function(){}
Dog.prototype.bark = function(){}
```

testdouble.js
``` javascript
var dog = td.object(Dog)

dog.woof // a test double function
dog.bark // a test double function
```

Sinon.js
``` javascript
var dog = sinon.createStubInstance(Dog)

dog.woof // a stub function
dog.bark // a stub function
```

Here we see an immediate limitation of Sinon's coupling of the stub/spy/mock
roles with their means of creation, as it only provides this convenience for
stubs. Meanwhile, testdouble.js functions are intended to play either role. Oddly
enough, Sinon.js's stubs support the same assertion API as spies, so it's more a
matter of API confusion than feature disparity.

### testdouble.js creation conveniences

In addition to imitating constructors, testdouble.js offers a few other
one-liners to make it easy to create objects of test doubles. I don't believe
any of these are available in Sinon.js. (But [please correct
me](http://twitter.com/searls) if I'm wrong!)

<div class="wide"></div>
``` javascript
// clone a plain object, replacing functions with test doubles:
var cat = { meow: function(){}, age: 9 }
td.object(cat) // {meow: [test double function], age: 9 }

// create an object with functions
var lion = td.object(['roar', 'sleep'])
lion.roar // a test double function
lion.sleep // a test double function

// create an ES2015 Proxy object
var pig = td.object('Pig')
pig.oink() // a test double function, defined dynamically
```

Using [Proxy objects](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Proxy)
as test doubles are particularly nifty, but are only currently supported by the
latest versions of Firefox and MS Edge.

## Injecting dependencies

In order for a test double library to be useful, you need to be able to get your
fake things into the hands of your subject under test as unobtrusively as
possible. The libraries may seem similar here, but testdouble.js provides
a much more involved scheme for Node.js and a greatly simplified approach to
resetting state to avoid test pollution.

### Replacing properties

One mechanism both Sinon.js & testdouble.js provide is property replacement of
objects referenceable by both the test and its subject (i.e. global namespacing):

testdouble.js
``` javascript
td.replace(process, 'cwd')

process.cwd // a test double function
```

Sinon.js
``` javascript
sinon.stub(process, 'cwd')

process.cwd // replaces the real thing

sinon.spy(process, 'cwd')

process.cwd // wraps & calls the real thing
```

This is a significant way in which the two libraries diverge in behavior.
Whereas testdouble.js will replace `process.cwd` entirely with a fake function,
Sinon.js spies merely wrap it, allowing any invocations to go through to its
actual implementation while also enabling verification of those invocations.

Sinon.js's behavior may seem more robust at first glance, but in the attempt to
have it both ways, it encourages unfocused tests: either the purpose of the test
is to verify an invocation or to ensure that the integrated unit behaves as
expected; it can't be both. Either the test will be needlessly coupled to its
implementation or it will be needlessly coupled to its depended-on component.
Moreover, most users probably aren't aware of the nuanced difference in behavior
between `sinon.spy` and `sinon.stub` in this case, given how similarly they
behave elsewhere.

#### Restoring properties

Here's how to restore those real properties back to their original owners:

testdouble.js
``` javascript
td.reset()
```

Sinon.js
``` javascript
process.cwd.restore()
```

While testdouble.js has a global reset for the state of all of your test doubles
and any destructive actions taken through its API, Sinon.js is so flexible it
hurts: restoring the state of each and every replaced property becomes
the job of the user, leading to (easy-to-forget) teardowns for each test double
in your test suite.

<p class="aside">
The chore of manually restoring all your Sinon spies is complicated by the fact
that they delegate invocations to the real function, so it's easy to forget to
`restore()` them after each test until much later, if and when the presence of
Sinon's spy wrapper causes a problem someplace else.
</p>

To mitigate this annoyance, Sinon.js features a "sandbox" API, but that just
gives users another, higher-order thing to keep track of:

<div class="wide"></div>
``` javascript
var sandbox = sinon.sandbox.create()

sandbox.spy(process, 'cwd')
sandbox.spy(process, 'uptime')

// … later in an after-each hook:
sandbox.restore()
```

This (and its `sinon.test` counterpart, which binds to `this`) makes uses of
Sinon.js harder to grep. Additionally, there's nothing preventing users from
accidentally referencing `sinon.*` methods even when in a sandbox, potentially
polluting production-scoped code with wrappers.

### Node.js module replacement

Global property replacement doesn't work very well in runtimes that provide a
native module system, so if you're using Node.js, testdouble.js provides a nifty
and terse mechanism for replacing module dependencies without any additional
configuration or cleanup needed:

<div class="wide"></div>
``` javascript
var brake = td.replace('../../lib/brake'),
    subject = require('../../lib/car')
```

The above will:

1. Require `'../../lib/brake'`
2. Return a test double:
  1. If 'brake' exports a function, returns a `td.function('brake')`
  2. If 'brake' exports a plain object, returns a `td.object()` of its properties
  3. If 'brake' exports a constructor, returns a `td.object()` of an
  instance of the constructor
3. Intercept any calls to `require` made by `'../../lib/car'` for paths that
resolve to the same file as `'../../lib/brake'` and return the test double (or,
in the case of constructors, a wrapped constructor so the subject can still call `new` on it)
4. Restore everything with `td.reset()`, which is typically called from a
single suite-wide after-each hook

To my knowledge, Sinon.js doesn't offer a similar feature, but modules like
[sandboxed-module](https://www.npmjs.com/package/sandboxed-module) and
[proxyquire](https://www.npmjs.com/package/proxyquire) do, leaving each user to
wire things up on their own. (Though, to my knowledge, this is the tersest
dependency replacement API currently available for Node.js.)

## Stubbing responses

Let's say you have a test double function `ask` that should return `42` when you
pass it `'meaning'`. Here's how you'd do that in each library:

testdouble.js
``` javascript
var ask = td.function()
td.when(ask('meaning')).thenReturn(42)

ask('meaning') // 42
ask('other stuff') // undefined
```

Sinon.js
``` javascript
var ask = sinon.stub()
ask.withArgs('meaning').returns(42)

ask('meaning') // 42
ask('other stuff') // undefined
```

So far so good. Sinon.js features a chained-API, whereas testdouble.js has users
"rehearse" the invocation as they expect the subject to invoke it.

There are a few quirks, however. First, Sinon.js doesn't provide a way to ensure
the stub is called with exactly the specified args, and will consider the
invocation to satisfy the stubbing when additional arguments are present (despite
the existence of a `withExactArgs` method for asserting spy invocations).

### Chaining confusion

Additionally, the chaining API can get a little confusing when combining options
that are seemingly at odds with one another. For instance, what does this do?

<div class="wide"></div>
``` javascript
var ask = sinon.stub()
ask.withArgs('meaning').returns(42).throws('fail')
```

The answer is it throws `'fail'`. And if reversed, the chain (e.g. called
`throws('fail').returns(42)`) would return `42`. Because nearly everything
you'd want to apply to a stubbing configuration is potentially mutually
exclusive with something else, a chaining API seems like an odd choice for the
task at hand.

Here are a few other stubbing configurations for comparison:

testdouble.js
``` javascript
var ask = td.function()
td.when(ask('meaning')).thenReturn(42)
td.when(ask('age'), {times: 1}).thenReturn(25)
td.when(ask('random')).thenReturn(10,7,3)
```

Sinon.js
``` javascript
var ask = sinon.stub()
ask.withArgs('meaning').returns(42)
ask.withArgs('age').onCall(0).returns(25)
ask.withArgs('random').onFirstCall().returns(10).
    onSecondCall().returns(7).
    onCall(2).returns(3)
```

Either of the above will configure the following behavior in `ask`:

<div class="wide"></div>
``` javascript
ask('meaning') // 42
ask('age') // 25
ask('age') // undefined
ask('random') // 10
ask('random') // 7
ask('random') // 3
```

Both libraries get the job done here, but Sinon.js is much more dense and
requires a little more thought about what methods are available, and which
can be chained with what.

An example where Sinon's chaining doesn't work (but where you might expect it to)
is in attempting to simplify a one-off stubbing into a one-liner:

testdouble.js
``` javascript
var ask = td.when(td.function()('meaning')).
             thenReturn(42)

ask('meaning') // 42
ask('other thing') // undefined
```

Sinon.js
``` javascript
var ask = sinon.stub().withArgs('meaning').
                returns(42)

ask('meaning') // 42
ask('other thing') // 42 // <- wait, what?!
```

At first, the above _looks_ like both are working, but in fact Sinon's chaining
API just silently returned an unconditional stub that'll actually return `42` no
matter what you pass to it. (I [opened an issue for this
problem](https://github.com/sinonjs/sinon/issues/817), if you want to help
solve it.)

Chainable APIs are fun to use and enable lots of possible configurations, but
they also expose to end-users a vast surface area that's hard to circumscribe
confidently. In my limited day-to-day use of Sinon.js, I've run into several
hard-to-debug problems like this one due to the way the chaining API was
implemented.

Aside from the API ergonomics, the two library's stubbing features are broadly
in line with one another, leaving the relative advantage to users' tastes:

* Callbacks can be stubbed in testdouble.js with `thenCallback` and the
`td.callback` matcher; Sinon.js enables the same with its `callsArgOnWith` and
`yields` chained functions
* Errors can be thrown in testdouble.js with `thenThrow` or `throws` in Sinon.js
* The argument matcher API is pretty comparable between the libraries; Sinon.js
offers more of them out of the box, but testdouble.js includes an argument captor

## Verifying invocations

In addition to stubbing responses, every test double library provides a way to
assert that a test double was invoked as expected. In testdouble.js,
`td.verify()` is almost entirely symmetrical to `td.when()`, down to the same
configuration properties. This was done intentionally to keep the API as
easy-to-learn and unsurprising as possible.

Sinon.js spies feature an assertion API that's unrelated to the stubbing API
for the most part, and which sports over 20 functions to assert invocations at
varying degrees of specificity.

Here's a typical verification example:

testdouble.js
``` javascript
var save = td.function()

save('Joe')

td.verify(save('Joe')) // undefined
```

Sinon.js
``` javascript
var save = sinon.spy()

save('Joe')

save.called // true
save.calledWith('Joe') // true
save.calledWithExactly('Joe') // true
```

One difference that stands out between the libraries is that in testdouble.js,
the presumption is that the user should verify the exact invocation (with
options to loosen the assertion), whereas in Sinon.js, the easiest-to-reach
assertions are also the least precise. Both libraries allow for the same breadth
of specificity, but a test double library that encourages precise assertions will
in turn encourage tests that fully specify the behavior they're meant to cover.

### Error messages

In testdouble.js, `td.verify` is designed as an assertion statement, meaning it
will raise an error if the verification is not met (though the
[testdouble-chai](http://npmjs.com/package/testdouble-chai) and
[testdouble-jasmine](http://npmjs.com/package/testdouble-jasmine) plugins modify
this somewhat).

The reason for this is to help the user by providing a very detailed error
message when a verification fails, in the hope they're able to understand the
failure without any further print statements or debugging:

<div class="wide"></div>
``` javascript
td.verify(save('Jane')) /* will throw:
Error: Unsatisfied verification on test double.

  Wanted:
    - called with `("Jane")`.

  But was actually called:
    - called with `("Joe")`.
    at Object.module.exports [as verify] (…/testdouble/lib/verify.js:22:15)
*/
```

Meanwhile, the Sinon.js docs suggest wrapping the boolean state of `called…`
properties in an `assert()`:

<div class="wide"></div>
``` javascript
assert(save.calledWithExactly('Jane')) /* will throw:
AssertionError: false == true
*/
```

The above error message isn't particularly helpful, and would require some
debugging or `console.log()`'ing to figure out why the assertion failed. As it
happens, Sinon does provide its own assertion tools, but their messages are
still pretty limited:

<div class="wide"></div>
``` javascript
sinon.assert.calledWithExactly(save, 'Jane') /* will throw:
AssertError: expected spy to be called with exact arguments Jane
    spy(Joe)
*/
```

## Introspection

While we're on the topic of robust, actionable error messages, let's review how
each library lets you inspect the state of test doubles at runtime,
which is important to consider when you're debugging a test. In fact, the same
information can generally be gleaned from test double functions created with
either library:

testdouble.js
``` javascript
var cough = td.function('cough')
td.when(cough('hack')).thenReturn('HACK')
td.when(cough('hoff')).thenReturn('HOFF')

cough('hiccup') // undefined

var explanation = td.explain(cough)
explanation.callCount // 1
explanation.calls // [{context: this, args: ['hiccup']}]
```

Sinon.js
``` javascript
var cough = sinon.stub()
cough.withArgs('hack').returns('HACK')
cough.withArgs('hoff').returns('HOFF')

cough('hiccup') // undefined

cough.callCount // 1
cough.getCalls() // [{args: ['hiccup', thisValue: this, …}]
```

The fact that testdouble.js needed to be able to print tidy verification
failures, it was trivial to tack it onto `td.explain` as well, for high-quality
logging when troubleshooting, like so:

<div class="wide"></div>
``` javascript
console.log(td.explain(cough).description)
```

Which will print a very readable summary of what we've done to the test double
so far:

>This test double `cough` has 2 stubbings and 1 invocations.
>
>Stubbings:
>  - when called with `("hack")`, then return `"HACK"`.
>  - when called with `("hoff")`, then return `"HOFF"`.
>
>Invocations:
>  - called with `("hiccup")`.

Now that testdouble.js has cleared the 1.0.0, most of my focus between now and
version 2 will be to improve the library's introspection abilities and messages.

## Conclusion

The API design of libraries inform users on how to think about the problems they
solve.

Sinon.js, by offering a broad API with multiple overlapping types of test
doubles, redundant ways to accomplish the same thing, and scant few opinions on
proper use can leave non-expert users feeling confused and overwhelmed.

As a result, it's no surprise that most people I know who use Sinon.js struggle
to articulate a coherent rationale for why they're using test doubles, lack a
consistent way to perform common tasks, and spend a lot of time complaining about
test doubles.

It feels like I saw the same thing play out nearly a decade ago in Java.
[jMock](http://jmock.org)'s abstractions overwhelmed all but the most ardent
experts in isolation testing, whereas [EasyMock](http://easymock.org)'s
slowly-expanding API encouraged teams to mock dependencies haphazardly and
inconsistently. It took [Mockito](http://mockito.org)'s narrow API and
strongly-opinionated design and documentation to encourage consistent and
comprehensible use.

There are a few tricks that Sinon.js knows which testdouble.js doesn't—sometimes
by design. But I think if you take the opportunity to try testdouble.js you'll
find that its API is broad enough to get the job done, but narrow enough to
foster consistent, readable isolated unit tests. If you're ready to take the
next step, I'd encourage you to check out [its
documentation](https://github.com/testdouble/testdouble.js#docs).

<script>
  (function(){
    if (![].filter) return
    [].slice.call(document.getElementsByTagName('pre')).filter(function (pre) {
      return pre.previousElementSibling.previousElementSibling.getAttribute('class') !== 'wide'
    }).forEach(function (pre) {
      var wrap = document.createElement('div')
      wrap.setAttribute('class', 'inline-code-block')
      pre.parentNode.insertBefore(wrap, pre.nextSibling)
      wrap.appendChild(pre.previousElementSibling)
      wrap.appendChild(pre)
    })
  })()
</script>
