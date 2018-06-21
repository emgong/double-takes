---
title: "The Three-Things Theorem of Function Intention"
subtitle: "Functions should coordinate, calculate, or control"
author:
  name: "Sam Jones"
  url: "https://twitter.com/samjonester"
---

Origami, the ancient art of paper folding, has gone through a [modern mathematical renaissance](http://www.pbs.org/independentlens/between-the-folds/history.html). The folding process was originally passed down between generations orally. Recently, though, artists have developed a way to document the steps to fold a shape with a diagram called a [crease pattern](http://www.langorigami.com/crease-patterns).

New theorems have emerged to determine whether a crease pattern is flat-foldable. For example, a crease pattern must be [two-colorable](https://en.wikipedia.org/wiki/Maekawa%27s_theorem). Each region in the crease pattern can be colored with one of two colors in such a way that no two regions of the same color share a dividing crease.

<div style="margin: 0 auto; display: block; padding: 30px">
  <a href="https://en.wikipedia.org/wiki/Mathematics_of_paper_folding" alt="mathematics of paper folding">
    <img style="height: 300px; width: 300px;" src="/img/three-things/two-colorability.png" alt="two colorability of bird base"/>
  </a>
  <a href="https://en.wikipedia.org/wiki/Orizuru" alt="orizuru: origami crane">
    <img src="/img/three-things/orizuru-paper-cranes.jpg" alt="orizuru: origami crane"/>
  </a>
</div>

> The art of origami has been reduced to a simple, elegant, binary theorem that represents its integrity.

## A Theorem Proving Code Intention

We can think of our source files as crease patterns used to diagram the intention of the systems we build. We can then define theorems to help us ensure that our diagrams, our source files, have integrity. Each function should have a clear intention, and to prove that, I'd like to introduce **The Three-Things Theorem of Function Intention**.

## A function should do one of these three things

### Coordinate

Coordinate the actions of other small, well-named units by using a defined control flow mechanism.

```javascript
function coordinator () {
  return callFirstFunction
    .then(res => callSecondFunction(res))
    .then(res => callThirdFunction(res))
}
```

A coordinating function is responsible for creating a pipeline of actions, for calling other well named functions. It manages interactions and that's it. Just like a good _people_ manager, a coordinating function becomes less effective when it's splitting time actually doing the work that should be a delegated task.


### Calculate

Calculate a very specific value, state, or object in our system.

```javascript
function simpleCalculator (val1, val2, val3) {
  return Math.pow(Math.abs(val1 + val2) * val3, 2)
}

function domainObjectCalculator (input) {
  return { output: _.get(input, 'foo.bar.baz')  }
}
```

Calculating a value doesn't just need to be limited to a mathematical equation. A calculating function can also be used for transitions in domain concepts. We "calculate" a new object in our system.

### Control

Encapsulate and expose ways to control the flow of our application.

```javascript
function until (condition, run) {
  return function method (subject) {
    if (!condition(subject)) {
      return method(run(subject))
    } else {
      return subject
    }
  }
}

until(n => n === 5, n => {
 // Calculate New N
})
```

We can build functions that perform the control flow through our applications. They can hold conditional logic, looping, and anything algorithmic. This allows our domain functions to focus on performing a specific task. `until` is an example of a complex path through our application, but structuring it as a higher-order-function allows it's functionality to be proven in isolation.

## Lean More

<p>**About this idea** in a talk about code design that [Sam](https://twitter.com/samjonester) gave called [JavaScript Is Too Convenient](http://blog.testdouble.com/posts/2018-05-02-javascript-is-too-convenient)</p>
<p>**About origami** from an amazing talk given by [Robby Kraft](https://twitter.com/robbykraft) on [software built for origami artists](https://www.thestrangeloop.com/2017/origami-software-from-scratch.html)</p>

<hr/>
<p><a rel="canonical" href="">Sam's original post</a></p>
