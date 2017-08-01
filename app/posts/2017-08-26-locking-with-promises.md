---
title: "Abusing Promises as a Locking Mechanism"
author:
  name: "Neal Lindsay"
  url: "http://twitter.com/neall"
---

[`prompt`][prompt] is a node library to accept text input in the terminal. It
exposes a traditional node-callback-style API. I recently had occasion to
promisify it and ran in to a funny problem. Here is what I initially wrote:

[prompt]: https://www.npmjs.com/package/prompt

    const prompt = require('prompt')

    const promisePrompt = (name) => {
      return new Promise((resolve) => {
        prompt.get(name, (err, result) => {
          if (err) {
            reject(err)
          } else {
            resolve(result[name])
          }
        })
      })
    }

    const fields = ['first', 'middle', 'last']

    Promise
      .all(fields.map(promisePrompt))
      .then(console.log.bind(console))
      .catch(console.error.bind(console))

Don't worry if you don't see anything wrong here. The problem isn't in the code
per se, I just made an incorrect assumption about how `prompt.get()` works.

If you call `prompt.get()` again before the user is done typing into your first
invocation, `prompt` will just use the same input for both. In other words,
`prompt` is not written to be run more than once at the same time.

<img style="margin: 0 auto" src="/img/locking-with-promises/before.gif" alt="$ node index.js
prompt: last:  LLLiiinnnddd??????
[ 'Lind??', 'Lind??', 'Lind??' ]
$ ">

By mapping across our `fields` array, we're calling `prompt.get()` three times
before the user can even type a character.

Please note, this is not how `prompt` is supposed to be used - it wants you to
pass in a list of fields instead of calling it once per field. So this example
is a bit contrived, but it's a great chance to use promises in a novel way.

Here is a function that takes a promise-returning function (`f`) and wraps it so
it will wait until any previous call is finished:

    const lockify = (f) => {
      // initialize our lock as an "already resolved" promise
      var lock = Promise.resolve()
      return (...params) => {
        // run our `f` when previous lock is done
        const result = lock.then(() => f(...params))
        // next lock waits for result to finish
        lock = result.catch(() => {})
        return result
      }
    }

*(If you're a bit fuzzy on how promises work, last year I recorded
[a conference talk on Javascript promises][patterns] that you might want to
watch.)*

[patterns]: /posts/2016-01-14-common-patterns-using-promises

When you call `lockify` it immediately creates an internal `lock` promise and
returns a new function. `lock` is already resolved, so it will not block
anything the first time we call the returned function.

The returned function also does two things immediately when you invoke it. It
creates a `result` promise, then it overwrites the `lock` variable with a new
promise that waits on `result`.

Later, after the initial `lock` finishes, `f` will be called. Whenever the
promise that `f` returns is done, `result` and the new `lock` will both resolve.

-------------

`lock` is the heart of the function and is being used in a very unusual way for
a promise: we never care what its value is. Instead, it's being used exclusively
for timing.

Notice that `lock` is the only identifier defined as a `var`. Everything else is
a `const`. That's so we can overwrite `lock` each time our function is called.

Also notice that we create each `lock` except the first by calling
`result.catch(() => {})`. This means that `lock` will resolve immediately after
and with the same value as `result`. The only time it will have a different
value is if `result` rejects with an error. By creating `lock` with a call to
`result.catch`, we make sure that our `lock` still resolves successfully even
when `result` rejects.

Here is the full code of our fixed version:

    const prompt = require('prompt')

    const promisePrompt = (name) => {
      return new Promise((resolve) => {
        prompt.get(name, (err, result) => {
          if (err) {
            reject(err)
          } else {
            resolve(result[name])
          }
        })
      })
    }

    const lockify = (f) => {
      var lock = Promise.resolve()
      return (...params) => {
        const result = lock.then(() => f(...params))
        lock = result.catch(() => {})
        return result
      }
    }
    const safePrompt = lockify(promisePrompt)

    const fields = ['first', 'middle', 'last']

    Promise
      .all(fields.map(safePrompt))
      .then(console.log.bind(console))
      .catch(console.error.bind(console))


<img style="margin: 0 auto" src="/img/locking-with-promises/after.gif" alt="$ node index.js
prompt: first:  Neal
prompt: middle:  Danger
prompt: last:  Lindsay
[ 'Neal', 'Danger', 'Lindsay' ]
$ ">

It's very rare that you have to worry about resource contention this way when
writing promise code. Most of the asynchronous calls you make are also perfectly
happy to run concurrently (like HTTP requests and file reads).

So then what can we take away from this exercise? First, promises are abstract
things that can benefit from being thought about in a very "math-y" way, similar
to how you think about higher-order functions. Our `lockify` function doesn't
care what `f` does, other than that it is a function that could return a
promise.

Second, when you're writing a function to explicitly manipulate promises, it's
important to keep in mind what happens immediately and what happens later.
`lock` gets *immediately* set when we call `lockify`, and gets overwritten
*immediately* on each call of the returned function. `f`, on the other hand,
gets called *after* the previous lock resolves.

Third, at all other times it is important to *forget about all that temporal
stuff*. The beauty of promises is that most of your code doesn't worry about
when it will run. It just says "when we have the data, do this stuff". I love
mapping across some data with a promise-returning function and then throwing the
result into `Promise.all`. When does that stuff get done? We don't need to think
about it.
