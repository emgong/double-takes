---
title: "3 Months of Elm: Our Experience"
description: "What it is like to write Elm. Our Elm experience."
author:
  name: "Josh Greenwood"
  url: "http://twitter.com/joshtgreenwood"
---

For the last 3 months we have been hard at work building out an ambitious Elm front-end project with one of our clients. We are building products for a very complex industrial-scale business domain. Our customers need to view and edit very large and very dynamic domain specific maps, stream event data, and investigate telemetry data. Much of the application uses SVG to drive the display of complex maps and figures. What follows is a loose collection of our thoughts about Elm as a language and a tool to leverage for front-end projects.

# Type System
Elm's type system is its hallmark feature. Defining your types, their relationships, and how they relate to the outside world allows the language to have its own controlled environment where safety can be guaranteed. All functions must be pure, state cannot be mutated, and all input must be verified by Elm before it flows into the system. If this sounds like a lot of work, it is! But doing that work up front has saved us countless hours of later debugging when we can be assured that the system is behaving correctly (or at least won't blow up).

An unforeseen benefit is that Elm forces you to make some decisions about your design up front. You can always change them later, but you have to decide *something*. As [Kevin Baribeau](https://twitter.com/kbaribeau) likes to ask, ["Does [tool or process] cause more careful thought, or is it more often an excuse to avoid careful thought?"](https://twitter.com/searls/status/876804767175114756). Elm passes this test with ease. When you're writing Elm code, you must carefully consider which things could be null, how certain states will interact, and how to [make impossible states impossible](https://www.youtube.com/watch?v=IcgmSRJHu_8). Forcing ourselves to do some of the tough design work at the onset pushed us to discovering cracks in our understanding sooner rather than later.

# Learning Curve
When I think of functional programming I think of [monads](https://stackoverflow.com/questions/44965/what-is-a-monad), [lamda calculus](https://en.wikipedia.org/wiki/Lambda_calculus), and other [Haskellisms](http://learnyouahaskell.com/chapters). I expected Elm to be relatively difficult to learn as I was predisposed to viewing functional programming as "harder". I found that the learning curve was pretty steep in the first week but after that, I both had a really strong understanding of the language and patterns. I think the reason for this is twofold. 

1) Elm is a pretty small and constrained language. There generally aren't that many ways of doing things and there isn't much syntax to learn.

2) The ["Elm Architecture"](https://guide.elm-lang.org/architecture/) forces your application into a very specific pattern. Because every Elm project looks roughly the same, it's much easier to understand. This even applies to the syntax itself. Nearly all Elm projects use [elm-format](https://github.com/avh4/elm-format) which ensures everyone uses the same indentation and spacing rules. 

These big and small features make the language significantly more approachable than we had previously thought. If you're comfortable with front-end development, you'll have no problem picking up Elm.

# Graphing
One disadvantage of Elm was that we didn't have any (easy) way to use libraries like [https://d3js.org/](D3). We were able to use [Elm Plot](https://terezka.github.io/elm-plot) for some use cases but it's not anywhere close to the maturity level of the graphing tools available to the wider JavaScript ecosystem. This forced us to implement much of the custom graphing ourselves which was a fun (but slow) challenge.

# Testing
Because the compiler takes care of most low hanging fruit, it's generally only necessary to write tests that cover your actual business requirements. These are in addition to tests we wrote while developing to get a quick feedback loop then throw away. We used the wonderful [elm-test](http://package.elm-lang.org/packages/elm-community/elm-test/latest) framework.

We found testing our application to be difficult at times. A small annoyance was that Elm can feel quite a bit more verbose than the dynamically typed languages I'm used to and the tests could be even more so. It was common to have tests that were 20 lines long and they could get much larger if the input was larger. A larger issue was that beyond simple input-output style unit tests, it was often difficult to test behavior. The issues generally stemmed from the fact that we were testing at various levels of abstraction. There was generally a solution in all of these cases, but we found them verbose and generally non-intuitive. They also generally didn't push us into a better design as we were simply trying to sidestep the Elm runtime.

# Changeability
The distinctive feature of a good design is that you can change it easily. After all, business requirements change, the domain becomes more clear, and you iterate on your product continually. We give Elm a strong +1 in this category. It is orders of magnitude easier and safer to change than its rivals. In most cases we were able to simply make the change we wanted and the compiler would give us step by step instructions on completing the exercise. The only pain point we ran into here was that the verbosity of Elm made us put off larger refactors at times due to the huge amount of typing we knew they would require. We would question if spending an hour or 2 typing was worth the marginal benefit of the refactor. In a dynamically typed language like Ruby, I will generally try the refactor for 15 minutes or so and compare the result to the starting point to determine if it was a step forward or not. It's often hard to rationalize spending a few hours on an experiment though.

# Talking to the outside world
JSON decoding is the best and worst thing to ever happen to us. Data comes in from the network or from JavaScript and you have to convert it to Elm types at the door. When the payload is what you expected and you can successfully transform it into an Elm type, the system proceeds as expected. When decoding fails, you can surface errors to the user or take some other action to rectify the situation. It's important to note that Elm's compiler *forces* you to explicitly handle every possible error case. On one hand, it feels like overkill to spend all this time writing a precise specification and on the other, it is liberating knowing that you have all of your bases covered. We knew it was time well spent when the API in question was stable, but when we were iterating on different API designs it sometimes felt painful. That said, I'm happy to trade a little pain now for a much more stable application later.

# The fun factor
I don't know about you, but I have a whole lot more fun writing Ruby than I do Java. It's clear that Ruby is optimized for programmers, not machines. Elm takes that to the extreme by polishing every sharp edge it can with fantastic tooling and friendly errors when things go wrong. Elm's feedback loop is optimized to make its programmers efficient and happy. When your code can be parsed, your code "clicks" into place from elm-format. When you fix any other compiler errors, the error screen clears and you are presented with your beautiful, fully functioning application. It's tough to quantify how big of a deal this is, but I find myself generally happier when I'm writing Elm code and I think that goes a long way.

# Conclusion
At Test Double, we are really excited about the future of Elm. [Jeremy Fairbank](https://twitter.com/elpapapollo) is even working on a book about Elm! There is a tradeoff between long term maintainability vs. short term time to market. Elm falls on the first end of that spectrum so it will likely not be the quickest to develop in, but it might be the easiest to change in 2 years.
