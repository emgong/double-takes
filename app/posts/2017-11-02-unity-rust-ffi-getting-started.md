---
title: "Getting started with FFI: Rust & Unity"
author:
  name: "Michael Schoonmaker"
  url: "http://twitter.com/Schoonology"
reddit: false
---

In my [slack time][slack-time], I've started writing games in [Unity][unity] again.

As I've been going, though, I found myself wanting some of the tools and features from [Rust][rust]. I've grown accustomed to Rust for performance-sensitive applications; it has several tools and features that make writing those applications easier for me. More and more I found myself thinking, "Wouldn't it be better to be able to write this feature in Rust?"

Time to break out some FFI magic.

[slack-time]: http://testdouble.com/join/developer
[unity]: https://unity3d.com/
[rust]: https://www.rust-lang.org/

## What is FFI?

The term "Foreign-Function Interface" refers to any mechanism that allows code written in one language to _directly invoke_ code written in another language. If "microservices" allow you to write individual networked services in whatever language you want as long as they understand a shared network protocol, FFI implementations allow you to write _libraries_ in whatever language you want as long as the programs that use those libraries understand the foreign-function interface provided.

If you've ever used a native module in Ruby or Node, you've benefitted from an FFI provided by C or C++. [Native modules typically control the virtual machine directly (e.g. using V8's C++ API), though both [Node][node-ffi] and [Ruby][ruby-ffi] have FFI modules available for binding to dynamic libraries.]

In Rust's case, the name also refers to the [`ffi` module][rust-ffi] of Rust's standard library, which provides tools to make writing those interfaces from Rust simpler.

[node-ffi]: https://github.com/node-ffi/node-ffi
[ruby-ffi]: https://github.com/ffi/ffi
[rust-ffi]: https://doc.rust-lang.org/1.5.0/book/ffi.html

## Why might I do this?

Unity is a fantastic game engine, loaded with an incredibly rich set of features for a game engine that is freely available. Where Unity lacks, Rust shines:

- Test-driven development: If the simulation logic is written in Rust, the same safety and testability that Rust provides can be applied to your simulation. While Unity continues to tinker with an in-editor Test Runner, it's fragile, with a slow feedback loop.
- Memory management: .NET relies on garbage collection, [which can cause performance issues](https://unity3d.com/learn/tutorials/topics/performance-optimization/optimizing-garbage-collection-unity-games). Rust, on the other hand, _requires_ manual memory management, which allows you to more finely control its use over time.
- Complex network protocols: Rust's design for enums, `match`, and the `std::io::Cursor` type all make writing low-level network protocols simpler and more reliable. In tandem with the other two points, you can write predictable, tested protocols with well-understood, _verifiable_ performance and memory implications.

## Risks

I've come across two major risks to this approach: thread panics and memory ownership.

The first risk is _specific to Unity_, and not an issue with FFI in general: if the Rust code panics (throws an unhandled error), Unity crashes. _Hard._ There may be a way to defend against this from Unity, but I haven't found it. Instead, _avoid panics at all costs_. `match`, `Result`, etc. are your friends.

The second risk is common in FFI applications: Rust's semantics around allocating and deallocating memory are specific to Rust, so the only way to _correctly_ free memory allocated in Rust is to _allow Rust to deallocate that memory_. You need to keep track of any and all memory you allocate in Rust, and ensure that Rust knows when it's safe to deallocate that memory. The simplest way to do that is with what I call a "baton".

A baton is a single, opaque pointer provided to the host (e.g. Unity) when your library's internal state is initialized. All internal allocations are attached to the data structure behind the baton. Every operation requested by the host comes with the baton, to which you continue to affix data as required. Once the host is finished, they pass the baton back one last time, and you deallocate all remaining memory in use.

## Partial example

I'm assuming you already have a Rust library and a Unity project. In your Rust project's `Cargo.toml` file, tell Cargo you want to build a dynamic library instead of a static one:

```
[lib]
name = "ffi_example"
crate-type = ["dylib"]
```

Once you've done that, future builds of the library will place a `.dylib` file in the target directory (e.g. `target/debug/ffi_example.dylib`). This DLL needs to be moved into your Unity project's `Asset/Plugins` directory _as a `.bundle`_ to be discoverable and loadable via Unity:

```
cp rust/target/debug/ffi_example.dylib unity/Assets/Plugins/ffi_example.bundle
```

I highly recommend scripting this: every time the Rust library is built, it needs to be copied into Unity. [In the [full example][full-example] that can be seen in `build.sh`.]

### <s>Detangling</s> Unmangling names

The next major step is to provide a publicly consumable API from Rust. This is as simple as marking a function `extern "C"` within the top-level module:

```
# In src/lib.rs:
pub extern "C" fn get_answer() -> u32 {
  42
}
```

[Notice the function is marked `pub`, too. Try dropping that and see what happens.]

We can double-check that the symbol (the name of the function) is actually exported with a tool like `objdump`:

```
objdump -t rust/target/debug/libffi_example.dylib | grep get_answer
0000000000001260 g     F __TEXT,__text  __ZN11ffi_example10get_answer17h684b44aa9cba5ce3E
```

Unfortunately for us the Rust compiler has "mangled" the name we provided. This process is really good at ensuring we don't collide with some other `get_answer` function, but we need to disable mangling for this function to call it from Unity:

```
# In src/lib.rs:
#[no_mangle]
pub extern "C" fn get_answer() -> u32 {
  42
}
```

Double-checking with `objdump`, we can see that the `#[no_mangle]` attribute did its job (the underscore at the beginning is normal):

```
objdump -t rust/target/debug/libffi_example.dylib | grep get_answer
0000000000001260 g     F __TEXT,__text  _get_answer
```

### Calling from Unity

Now that we can find our `get_answer` function, we should call it from C#. While we could bind to this function from a MonoBehaviour, it's better to create a separate class:

```
# In Assets/Plugins/FFI.cs
using System.Runtime.InteropServices;

public class FFI
{
    [DllImport("libffi_example")]
    public static extern int get_answer();
}
```

Then, from any MonoBehaviour, we can call our newly-loaded Rust function:

```
Debug.Log(String.format("The answer is: {0}", FFI.get_answer()));
```

## Full example: Memory management, error handling, etc.

A full example of this is available [on GitHub][full-example]. This example includes solutions to the risks mentioned above, as well as doing something a little more interesting: sending UDP datagrams to a waiting Node server.

In particular, check out the example for:

- Memory management using a baton.
- A well-factored Baton _type_ in Rust.
- An FFI class in C# that provides a more idiomatic interface.
- Sending basic data from C# to Rust.

[full-example]: https://github.com/testdouble/rust-ffi-example

## Going further

Now that you have the basics of FFI down, the next steps are to pass more complicated data structures around. For example, let's take the "network protocol" use case, above. If you're trying to represent domain objects on the wire, you need to get the full domain object into Unity. How do we do that?

While the complete answer is a blog post in and of itself, here are a few hints:

- Keep to single-layer `structs`.
- Use `[StructLayout(LayoutKind.Sequential)]` from C#.
- Use `#[repr(C)]` from Rust.

## Additional thanks

Thanks to [Jim Fleming](https://medium.com/jim-fleming/rust-lang-in-unity3d-eeaeb47f3a77) for inspiration and some helpful information while I started exploring this concept.
