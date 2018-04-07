---
title: "Effective React Testing"
description: "Learn the ins and outs of different types of tests and how to test your React application."
author:
  name: "Jeremy Fairbank"
  url: "http://twitter.com/elpapapollo"
video:
  url: "https://player.vimeo.com/video/263547792"
  type: "vimeo"
reddit: false
---

The [video above](https://vimeo.com/263547792) was recorded at
[JazzCon 2018](http://jazzcon.tech/) in New Orleans, Louisiana.

Many teams relish building applications with [React](https://reactjs.org/)
these days. Composable components and unidirectional data flow with Redux
create a solid foundation for modular applications. By this point, you know
higher-order components, selectors, and render props like the back of your
hand. But what about testing?

If you neglect to write React tests because you don't know what to test, which
types of tests provide the most value, or how to start testing, then this talk
will guide your path. I explain the difference among unit, isolation, and
end-to-end tests, and provide a general framework for how to test your
application.

You will learn about the testing framework
[Jest](https://facebook.github.io/jest/), how to test-drive components with
[Enzyme](https://github.com/airbnb/enzyme) for design feedback, the magic and
trade-offs of snapshot testing, how to unit and integration test your reducer
and actions, and how to test your entire application in a browser by simulating
user scenarios. Of course, I offer both pros and cons to each type of test, so
you and your team can discover what works best for you. You will also learn how
to use our nifty [testdouble.js](https://github.com/testdouble/testdouble.js)
library.

If this talk excites you and you want to level up on testing, please [reach out
to us](https://testdouble.com/contact). We love helping teams grow.
