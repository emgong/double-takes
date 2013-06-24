---
title: "this Is Why We Can't Have Nice Things"
author:
    name: "Zach Briggs"
    url: "http://theotherzach.com"
    tldr: "JavaScript's `this` is hard to grok, but doing so is worth your time"
    body: """
          Blah blah blah, look at me I'm fancy JavaScript screencast guy.
          """
---

#`this` Is Why We Can't Have Nice Things
JavaScript's 'this' is one of the most frustrating aspects of the language. Even after getting a handle on object instantiation, prototypical inheritance, and higher order functions I still find ‘this’ to be troublesome.

When I approached this project it was with the idea of a quick look into why `this` sucks whenever we have an event handler with a short recipe showing how to mitigate the problem. Instead I created JavaScript examples where the ‘this’ behaved in ways entirly counter to my expectations. Rather than recording a quick 3 minute screencast I ended up spending 48 hours slaying my greatest JavaScript dragon.

`this` Spotting
------------------------------------

Lets start with some example code.

```javascript
window.object1 = {

    attribute1: "bob",

    method1: function() {
        return this.attribute1;
    }
}
```

What does `this.attribute1` correspond to? Does `this.attribute1 === "bob"` evaluate to `true`?  Do you have your answer? 
Let's look at one more code example before I reveal my duplicity.

```javascript
window.object2 = {
    method2: function(arg) {
        return arg;
    }
}
```

How about `arg`? Is `arg === "bob"` `true`? How about `arg === 42`? The correct answer is that we just don't have enough information; we've got no clue what arg is until that function is invoked. `this` should be thought of like a function's arguments. Where that function's code sits, dead on disk, has no bearing on its value. It isn't until that code is run, live in memory, do we know what `this` is. 

Invoking vs Referencing
------------------------------------

When writing JavaScript, they key to understanding `this` is looking for where the function is invoked and how. Invocation typically happens when a pair of parens `()` immediately follow a function reference. 

```javascript
var func = function() {
    return "string";
}
var variable1 = func // We're just assigning func to variable1
variable1
//=>function () {
//    return "string";
//}
variable1()
//=>"string"
```
```javascript
var func = function() {
    return "string";
}

var variable2 = func() // func is being invoked here and returning "string."
variable2
//=>"string"
variable2()
//=>TypeError: string is not a function
```

If this is obvious to you then congratulations, I think you're far ahead of most people that dip into JavaScript from time to time. Most people I observe always kind of forget to leave the parens off a function when passing it to a jQuery event handler. No big deal, but it's a sign that maybe we don't quite understand when we are passing a reference to a function vs the return value to a function. Stop the video here and reproduce the above example in a JavaScript console.

Function Invocation
------------------------------------

Method Invocation
------------------------------------

Constructor Invocation
------------------------------------

Apply Invocation
------------------------------------


Event Handing
------------------------------------


http://jsbin.com/awuwef/1/edit
```
$(document).ready(function () {
  $("#add-word").on(
    "click",
    function(){
      alert($("#word").val());
    });
});
```
