---
title: "what polymer and angular tell us about the future of the web platform"
author:
  name: "David Mosher"
  url: "http://www.youtube.com/user/vidjadavemo/videos"
tldr:
  title: "dont try to get everything right upfront"
  body: """
        the web platform and javascript frameworks are going to be more successful if their authors offer low-level APIs that developers can play with instead of trying to get high-level APIs designed correctly the first time.
        """
---

Yehuda Katz recently gave a talk entitled ["The Future of the Client-Side Web"](https://www.youtube.com/watch?v=EcyxXPILO8E) in which he highlighted the current challenges that web standards bodies face when trying to design APIs for web developers to use. In this talk, Yehuda highlighted Googles recently announced Polymer library as a good example of the right way to push the web platform forward.

Polymer provides a "low enough" level API that gives web developers the power to redefine the way they write markup using the power of newer features coming to JavaScript in ES6. The specifics of the implementation aren't relevant to what I want to say here, but Yehuda does a great job covering the details at a high level in the video so I suggest you watch it if they interest you.

What I found interesting was the message that was at the heart of Yehudas talk: web platform standards bodies need to focus less on getting implementations of new APIs right the first time (hello AppCache) and instead provide web developers with a set of lower level APIs that are exposed to JavaScript. When this approach has been followed, developers are capable of iterating far faster than standards bodies which results in consensus on API design being reached faster and with less upfront design.

This is a really fundamental shift in thinking that I believe has already been validated by a number of well-known client-side libraries.

# The Backbone Lesson

Since its release, Backbone has exploded in popularity and many other frameworks have since been built on top of the low-level components it provides. Jeremy Ashkenas and the team at Document Cloud did an amazing job of releasing a set of components that can be adapted to fit almost any scenario when building a web application, from simple uses of Backbone.View inside an existing legacy application all the way up to writing a completely self-contained rich-client application purely in JavaScript.

When I first started working in Backbone almost two years ago I remember feeling overwhelmed at how I was supposed to use all the pieces provided. I believe this speaks to the nature of how Backbone was created, and looking back now it is clear to me that Backbone follows the design model that Yehuda praises in his talk; it gave us a low-level set of components and didn't really enforce any particular design decisions on how to use them aside from an important guiding principle: get your data out of the DOM.

# The Ember Conundrum

A recent blog post by @evil_trout originally entitled "AngularJS vs Ember, It's not even close" highlights some perceived shortcomings of Angular, the chief being that there are too many pitfalls in the simplistic features that Angular provides and that it should strive to provide higher-level conventions that developers can follow. This point of view really struck me as being in stark contrast when hearing Yehuda extol the virtues of seeing success in the web platform when developers were given access to low-level components without many opinions on how they should be used.

It seems to me like the Ember team and contributors would be better served by following these design goals; spending more time observing how web developers use their low-level APIs when crafting solutions and less time trying to get a high-level rich-web application framework right the first time. Perhaps this is why the path to Embers 1.0 release has been so full of frequent, backwards compatibility breaking API changes.

# The Angular Approach

Initially I was skeptical about the power of Angular JS, having spent a good 18 months of my life invested in writing applications with Backbone I wasn't eager to make a jump to another framework. Thankfully my skepticism was quickly swept aside as I discovered the beauty in the simplicity of the Angular API. I didn't have to extend framework built-in objects or methods, I could just use POJSO's and functions. I also didn't have to spend a lot of time thinking about how to structure my application thanks to `angular.module` and built-in Dependency Injection. Angular really hits the sweet spot between low-level components and _tightly scoped_ high-level abstractions. It provides high-level features that don't do too many things as well as low-level components that I can craft into domain-specific solutions within my applications.

The ability to craft custom markup through `angular.directive` is an interesting high-level piece in that it has the power to create custom components that are just as coarse or granular as you need them to be. Angular is _just_ opinionated enough that it allows developers to work with the low-level components provided to craft higher level abstractions; in fact, I think that's the core benefit of Angular. Having the power to abstract:

```html
<div id="chart" data-type="bar">
  <div class="legend"></div>
</div>
```

into

```html
<bar-chart></bar-chart>
```

is an incredibly powerful idea.

# Web Components and the future of Markup

One of the most exciting changes to the Web Platform in the last five years is the upcoming Web Components spec; Eric Bidelman gave a great overview of it during Google IO this year and [guy one, guy two] had an amazing demo that showcased some of the capabilities. I'm excited about Web Components because it allows  web developers to experiment at a lower-level by reshaping the way that we write markup; it will also offer true encapsulation on the web, a feature that has been sorely lacking.

It really seems like Angular has been an engine used to power the direction of Web Components, in fact I think people on the Angular team have said that Angular will simply utilize the power of the Web Components API once it becomes standard. The awesome thing about Angular is that you can use it to achieve these kinds of markup abstractions in your applications right now, along with all the other great features it provides.

I'm eager to see how the lower-level features in ES6 and low-level libraries like Polymer are going to be used by developers to create even more amazing frameworks in the future.

# Moving the Web Forward

I think Yehuda has it right, standards bodies need to focus less  on getting high-level APIs right up front and more on providing developers with enough low-level APIs to experiment with. The same principle applies to the design of rich-client application frameworks. My hope is that the standards bodies and JavaScript framework authors embrace this approach going forward; hopefully this will motivate the web development community to move beyond rhetoric and comparison and into an age of innovation.
