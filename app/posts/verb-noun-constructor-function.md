I've been a fan of the VerbNoun naming scheme ever since I was introduced to it a few years ago. In summary, the VerbNoun naming scheme seeks to aid in controlling the scope of classes (or modules, etc) by naming things in accordance with their behavior. Typically, we name objects and classes as nouns. They are intended to be abstractions for the "things" in our system as we attempt to model the domain or real world. This generally results in the objects being dumping grounds for all sorts of behavior that is *related* to the named object in question. We seem determined to set ourselves up for SRP violations by using Noun names that act as a magnet for responsibilities. The Verb/Noun naming pattern, in contrast, brings the *behavior* to the forefront. It's easier to notice an SRP violation because secondary responsibilities quite literally clash with the very name of the class to which we attempt to add them.

Enough summary. For more reading on VerbNoun naming, I suggest http://searls.testdouble.com/posts/2011-04-29-the-power-of-prompts.html (jump to the bit titled: 'Verb-first Classes, or “Where does this code go?”'. Also, https://devchat.tv/ruby-rogues/186-rr-the-4-rules-of-simple-design-with-corey-haines about 41min in. 


When objects begin to be built around encapsulating single responsibilities, or behaviors, it becomes increasingly common to have a single method that actually invokes the desired behavior. "DoesThing" might have a 'do' method. FeedsBunnies might have a 'feed' method. That's not to say the class doesn't have other methods for configuring the object and whatnot. But it's highly likely that a single method will stand above the rest as "the verb that must be done". After initially falling to the temptation of simply naming the 'doer' method after the actual action, I began experimenting with using a common trigger method. For example 'execute, run, go, or call'. Astute readers might recognize that `call` as a method name has some special semantics in Ruby. Avdi explains quite well in a Ruby Tapas episode dedicated to Callable: http://www.rubytapas.com/episodes/35-Callable

In short, many objects in Ruby respond to the `call` message; proc and method in particular. This means that procs (whether created as lambdas or blocks or from Symbols via to_proc) and methods (both bound and unbound) can be substituted for any user defined object the implements it's primary behavior behind :call. This is especially useful for providing default behavior in an initializer, or stubbing for a test. (Ruby even goes so far as supporting an alias of `[]` for `.call`.)

So now, FeedsBunnies.feed becomes FeedsBunnies.call.

Taking it to JavaScript. So we've learned that ruby has a common interface for 'Callable', that is the 'call' method. JavaScript doesn't quite have a defined method interface. But functions are first class in JavaScript! So a 'behavior' can be passed around simply as function. Okay, so we can pass around functions, big deal. Hold that thought.

Let's back up and say we have an object, FeedsBunnies for instance, that requires some setup. Perhaps it needs some initial configuration, or may even have some additional methods.

function FeedsBunnies() {}

FeedsBunnies.prototype.feed = function(bunnies) {
  bunnies.forEach(function(bunny) {
    bunny.food.concat(this.food, this.treat);
  });
};

FeedBunnies.prototype.food = function(food) {
  this.food = food;
};

FeedBunnies.prototype.treat = function(food) {
  this.treat = food;
};


We find after much use that FeedsBunnies are typically instantiated and `feed` is immediately invoked. We frequently see `new FeedsBunnies().feed(bunnies);` in the codebase.

Well JavaScript has a rather obscure feature in that a function can determine whether it was invoked as a constructor (with `new`) or as a function. (Technically, it only knows whether the function is bound to an instanceof the constructor. One could invoke it as a function bound to an instance and the function would presume to be invoked as a constructor.) Typically, this pattern is used to ensure that constructors invoked as functions do indeed return an instance.

function FeedsBunnies() {
  if(!this instanceof FeedsBunnies){
    return new FeedsBunnies();
  }
}

So let's step back. We have a 'class' that encapsulates a behavior, which is typically modeled as a simple function in JS. We have a primary method that is the normal trigger for this behavior. And we have a mechanism to determine whether a function was invoked with `new` or not. Could we combine these powers such that our FeedsBunnies object can be used per usual; *but also* improve the api in the common case where an instance is created and immediately 'triggered'?

function FeedsBunnies() {
  if(!this instanceof FeedsBunnies){
    return new FeedsBunnies().feed();
  }
}

x = new FeedsBunnies();
x.feed(bunnies); // no more hungry bunnies

FeedsBunnies(bunnies); // no more hungry bunnies

We might be on to something here!

Though it's a bit awkward to use a PascalCased function invoked as a function and not as a constructor. This can be changed with a simple tweak to the require:

FeedsBunnies = require('./feeds-bunnies')
feedBunnies = require('./feeds-bunnies')

The function can be named accordingly to its intended use at the point where it's required. Hopefully the scope of the require is small enough that only one of the two forms is used per file.

But wait, how is this different than simply exporting a function with some closures for any private helpers? Perhaps in some cases,  the object must be instantiated separately from its use. 

I'm not yet convinced this is a good pattern. Indeed, it makes the constructor definition quite confusing. But I'm curious to see if this pattern helps improve the usage of my VerbNoun objects in the common case.
