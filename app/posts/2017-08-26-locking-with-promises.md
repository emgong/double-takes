---
title: "Abusing Promises as a Locking Mechanism"
author:
  name: "Neal Lindsay"
  url: "http://twitter.com/neall"
---

I recently had occasion to hand-promisify the [`prompt`][prompt] library and ran
in to a funny problem. Can you guess what went wrong?

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

Don't worry if you didn't figure it out - I was pretty surprised when I ran this
code. If you call `prompt.get()` again before the user is done typing into your
first invocation, `prompt` will just use the same input for both.

<img style="margin: 0 auto" src="/img/locking-with-promises/before.gif" alt="$ node index.js prompt: last:  LLLiiinnnddd?????? [ 'Lind??', 'Lind??', 'Lind??' ] $ ">

Please note, this is not how `prompt` is supposed to be used - it wants you to
pass in a list of fields instead of calling it once per field. But I think my
way of using it is a good contrived example for what comes next.

So `prompt` doesn't protect you from using it twice at the same time. But now
that we've promisified it, we can easily build that protection:

    // `lockify` will take a promise-returning function and give
    // you back a version of it that avoids running concurrently.
    const lockify = (f) => {
      // initialize our lock to the "ready to do stuff" state
      var lock = Promise.resolve()
      return (...params) => {
        // run our `f` when previous lock is done
        const result = lock.then(() => f(...params))
        // next lock waits for result to finish (successfully or not):
        lock = result.catch(() => {})
        return result
      }
    }

When you call `lockify` it immediately creates an internal `lock` promise and
returns a new function. `lock` is already resolved, so it will not block
anything the first time we call the returned function.

The returned function also does two things immediately when you invoke it. It
creates a `result` promise, then it overwrites the `lock` variable with a new
promise that waits on `result` (ignoring any errors). The `result` promise will
resolve by calling the earlier-passed-in `f` function after the original `lock`
finishes.

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
care about what `f` does, other than that it is a function that could return a
promise.

Second, when you're writing a function to explicitly manipulate promises, it's
important to keep in mind what happens immediately and what happens later.
`lock` gets *immediately* set when we call `lockify`, and gets overwritten
*immediately* on each call of the returned function. `f`, on the other hand,
gets called *after* the previous lock resolves.

Third, at all other times it is important to *forget about all that temporal
stuff*. The beauty of promises is that most of your code doesn't worry about
when it will run. It just says "when we have the data, do this stuff". I love
writing mapping across some data with a promise-returning function and then
throwing the result into `Promise.all`. When does that stuff get done? We don't
need to think about it.
