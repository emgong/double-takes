---
title: "Solving the Boolean Identity Crisis"
description: "Learn about the dangers of using booleans in your Elm code and how to write clearer code for you and your teammates with union types."
author:
  name: "Jeremy Fairbank"
  url: "https://twitter.com/elpapapollo"
video:
  url: "https://player.vimeo.com/video/236415246"
  type: "vimeo"
---

The [video above](https://vimeo.com/testdouble/solving-the-boolean-identity-crisis) was recorded at [Elm Conf 2017](https://www.elm-conf.us/).

While powerful in its simplicity and important to computation, the boolean can be extremely limiting in Elm applications. In this talk, briefly explore the history of boolean logic in computation and look at how booleans can become misused in Elm. See how booleans obscure the meaning of code, make code harder to maintain, and hinder usability for our teammates and users. By watching this talk, you will learn how to harness union types to write cleaner, clearer code. More importantly, you will learn how to place usability at the forefront of the APIs and UIs you build.

**Booleans create problems in four key areas:**

1. Boolean arguments make function calls confusing, hide important meaning, and create implicit state.
2. Functions that return booleans lead to problems like [boolean blindness](https://existentialtype.wordpress.com/2011/03/15/boolean-blindness/) which opens the doors for bugs.
3. Spreading application state out among boolean values leads to invalid state and requires more testing to prevent bugs.
4. Boolean thinking in UIs can create frustrating user experiences for our users with a simple checkbox. Users have to guess what an unchecked checkbox might do.

**You can fix these boolean dilemmas with more explicit data representations:**

1. Use union type values as meaningful arguments to functions.
2. Return union type values from functions to prevent boolean blindness.
3. Combine disparate boolean values in application state into one union type like a finite state machine. This makes [impossible states impossible](https://youtu.be/IcgmSRJHu_8).
4. Use radio buttons instead of checkboxes to offer explicit options to users. This is similar to using union types to replace booleans in code.

The overarching theme to this talk is to have empathy for our teammates and users by writing clear, self-documenting code and designing intuitive UIs.
