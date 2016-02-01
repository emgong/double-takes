# Reconcilable Differences with React and VDOM

TL;DR A recipe detailing a way to integrate DOM-mutating plugins into a React application, based on an understanding of how React does Reconciliation of VDOMs.

# The Halcyon Days of Pure React
Early on in one's ReactJS days, you learn of one-way data flow and commit this mantra to memory

> The UI is a (pure) function of the state 

When you adhere to this 100%, you no longer have to ask the question *"What is my source of truth?"* You know that state - consisting of `props`, and an optional overlay layer called `state` - is turned into DOM through a method called `render` that returns VirtualDOM. React then applies that new VDOM to the real DOM in clever and minimal ways. As long as React is 100% in charge of that DOM underneath that mounted component, that's all you need to know.

But DOM mutations can occur in many ways. You could be using a JQuery plugin or Chrome Extension that mutates the DOM without React knowing. Or - simply, a user may choose an option from a `<select>` , and now that DOM is in a state React is not aware of. 

Those who caution to *"never mutate the DOM underneath React"*, miss out on having a backup plan if they are not able to Reactify All The Things. Personally, I find the utility of existing JQuery plugins too compelling to opt to rewrite each one I use immediately - so I set out to detail a hybrid option.

# Act 1 - Setting the Stage

Our investigation starts with the following scenario: A nested list is rendered (from an object given to React, via `props`). Then, `render` turns this into DOM with a series of `<ol>` and `<li>` lists and list items with classes that nestable wants. Lastly, we want to initialize the JQuery nestable plugin to make the lists drag-and-drop re-orderable.

We decide that after mounting our component, we'll initialize the Nestable plugin on the rendered output. Keep in mind that - for this JQuery plugin - its source of truth is what's in the DOM, and it gives you a method you can call to get an object representation of that DOM - but we'll talk about that later.

```js
  componentDidMount: function() {
	$('.dd').nestable()
  },
```
Here's how this works:
![image](https://s3.amazonaws.com/www.deanius.com/react-td/no-react-sync.gif)

It appears to work fine from the user's point of view, but notice that after we drag a node around - the React Inspector is not aware of the change. This breaks our sync, and leads to confusion. Let's try and remedy that.

# Act 2 - Closing the Loop

*"No problem"*, you say. You're cool as a cucumber, knowing that in a situation like this, we need an event handler to feed the current value of the tree back into React. You even know to avoid `state` except in container components, and use `props` as much as possible. So you look up the nestable docs, and scale up to the following:

```js
 componentDidMount: function() {
   var $dd = $('.dd').nestable().on('change', () => {
     this.props.onChange(this.getCurrentTree())
   })
 },
 getCurrentTree: function() {
   return $('.dd').nestable('serialize');
 }
```
Yeah! You are feeding the tree (as given by nestable's `serialize` method), into a function (which you accept via `props`), and that function can push the props back down to the component. Your code looks like this, and you feel great.

```js
const container = document.getElementById("nestable");

const nestableChanged = (newTree) => {
  ReactDOM.render(
    <Nestable data={newTree} onChange={nestableChanged} />,
    container)
}

// on first load
ReactDOM.render(
	<Nestable data={exampleData()} onChange={nestableChanged} />, 
	container
)
```

Yet- when you start to test its behavior now, you get a sinking feeling, your pulse races, and your blood pressure shoots up a couple dozen points. Something is not right.

# Act 3 - Something's Rotten in the State of the DOM

Unfortunately, we have two very anomalous behaviors, indicated by the animations below:

#### Error 1 - Tucking one subtree under another causes the subsequent subtree to vanish!

![image](https://s3.amazonaws.com/www.deanius.com/react-td/subtree-deletion.gif)

### Error 2 - Dragging a node out to the root adds it twice!

![image](https://s3.amazonaws.com/www.deanius.com/react-td/addition-to-root.gif)

While these errors appear different on the surface, they are essentially the same kind of error caused by the phase of the React lifecycle called [Reconciliation](https://facebook.github.io/react/docs/reconciliation.html).

# Act 4 - Reconciling with the Past

Remember that React has an internal model of state, and when we update `props` or `state`, `render` is invoked again to return a new VDOM. This VDOM gets compared to the current state, as well as the current DOM, and changes flow to the real DOM.

You can make some adjustment to this part of the process in the React LifeCycle method `shouldComponentUpdate`:

```js
shouldComponentUpdate: function(nextProps, nextState) {
  // well, should it update? return false if not
}
```

Let's now explain what happened in Error 1 above from the point of view of React, which has to apply changes to the DOM.

 1. Looking at the difference between the old and new VDOM, it appears that the second child of the root has been deleted.
 2. React deletes the second child of the root *as it should!*, but due to our user and plugin's changes, that node has already been moved out of the way, and React's deletion applies to the wrong node.

You can reason out Error #2 for yourself, based on the same logic of trying to propogate an update without realizing that it's already been taken care of.

The nodes use `key`, which is a best practice for being able to let React identify them in a list, using something other than their position, but it's not enough, because in fact we're at an edge-case of React's diffing algorithm.

> In the current implementation, you can express the fact that a sub-tree has been moved amongst its siblings, but you cannot tell that it has moved somewhere else. 

Since we've written our React component to fully be determined from `props`, what's safe to do - and what we really want to do - is clobber the old DOM and then re-render. Don't try using JQuery's `.empty()` either.. Trust me, dragons that way lie, in the form of:

```
Invariant Violation: processUpdates(): Unable to find child 1 of element. This probably means the DOM was unexpectedly mutated
```

That's not helpful. So let's look at what works.

# Act 5 - Denoument

It's actually been right under our nose all along. Not a lifecycle method, not a configuration option, but the same way we got React markup into the DOM from the beginning. We mounted React to the DOM initially, so we can completely clear up its state by [unmounting](https://facebook.github.io/react/blog/2015/10/01/react-render-and-top-level-api.html).

```
const container = document.getElementById("nestable");

const nestableChanged = (newTree) => {
  ReactDOM.unmountComponentAtNode(container) // <- This!
  ReactDOM.render(
    <Nestable data={newTree} onChange={nestableChanged} />,
    container)
}
```

While this may seem crude, it actually ensures that any state the user sees is generated from React's render method - in other words:

> The UI is a pure function of state

We're simply allowing that to be untrue momentarily while the user interacts with us, and we're taking the performance hit of clobbering more DOM than we theoretically need to, in order to preserve logical correctness that is easy to reason about, and to use a plugin that makes the grievous mistake of not being compatible with every JS framework that wasn't even out yet when it was written :)

# Reconciled, and Happy

Our problem was a two-part one - 1) not knowing how to correctly blow away the DOM under React, and 2) not knowing that our particular plugin comes up against edge cases inherent in React. 

But now we're empowered. If we are sticking to `props` instead of `state`, and find ourselves in a corner where React's VDOM reconciliation fails to clear out old nodes correctly, we can unmount and remount and then we'll know that we are back in sync after every render cycle.

The React team knows this needs to be done sometimes, and [speaks to this](https://facebook.github.io/react/blog/2015/10/01/react-render-and-top-level-api.html):
> Unfortunately not everything around you is built using React. At the root of your tree you still have to write some plumbing code to connect the outer world into React.

Problems like these will arise from time to time, but in the end I think the React model is the cleanest I've seen. I have to give a nod to some of its predecessors, though: The KnockoutJS ViewModel library, and the reactive-coffee library for reactive UI are libraries I've used that follow these principles, and I've been using or contributing to these since 2007. Flowing truth from objects to DOM is definitely the way to stay happy.

You just need to be aware of a few edge cases, and sometimes learn some of the implementation details of the framework you're working with.

Dean

PS Thanks to Gordon Kristan, from Sprout Social whose presentation on this topic at Chicago React inspired this post.
PPS Play with [a JSBin for this article](http://jsbin.com/zifodo)
