---
title: "Complex FFI with Rust & Unity"
author:
  name: "Michael Schoonmaker"
  url: "http://twitter.com/Schoonology"
reddit: false
---

As promised in ["Getting started with FFI: Rust & Unity"][basic-ffi], the next steps for any FFI binding is a _"zero-copy"_ bridge for complex data types. In other words our current goal is to pass classes, objects, or structs between the two languages. Though a binding between Rust and Unity is beneficial in and of itself, I want to go another step further, and show the way to approach this given _any_ pair of languages.

NOTE: If you have not read the [original post][basic-ffi], please do that first. We'll be building off of those concepts here.

## The finished project

Just as we did the first time, the results of this work can be found [on GitHub][repo]. The finished project is a simple app that synchronizes the position of "sparkles". When you press the left mouse button, your sparkle moves, and all other connected clients see it move, too.

## Jumping in

In the basic project, we were already using a structure for complex state: the "baton". The issue with the baton is that it's an "opaque" pointer: though Rust had all the information it needed, Unity cannot retrieve any of that information directly.

What we might try, then, is to extend one of our Rust methods to include a pointer to an object, either as an argument:

```rust
// If you're going to be changing anything, don't forget to make the pointer
// mutable with `*mut`.
#[no_mangle]
pub extern "C" fn pointer_argument(ptr: *mut Baton, data: *mut Something) -> bool {
```

```csharp
[DllImport("libffi_example")]
private static extern bool pointer_argument(IntPtr baton, Something data);
```

...as a return value:

```rust
#[no_mangle]
pub extern "C" fn pointer_returned(ptr: *mut Baton) -> *mut Something {
```

```csharp
[DllImport("libffi_example")]
private static extern Something pointer_returned(IntPtr baton);
```

...or both. _This will fail._ At best, your compiler will yell at you. At worst, this will seem to work—until it starts behaving mysteriously and incorrectly. The most likely outcome is that your program will suddenly and unhelpfully crash.

## Compilers, Languages, and Memory

Before we go any further, I want to review a little bit about computer languages. Most conventional languages today like C# or JavaScript are written in text files, and run on a computer with a big block of memory and a processor that follows _extremely_ basic instructions like "put a 42 here" or "add these two numbers". This is quite the gross oversimplification, but it already presents a problem: how are these sophisticated languages possible if the processor cannot understand them? On the memory front, how is a "struct" or "object" represented in this big blob of memory?

This, dear reader, is the purview of computer science and the purpose of a compiler and an interpreter. I don't intend to teach you how either of these work today, but their domain is important: mapping language-specific concepts (e.g. a `class` in C#) to a consistent storage format.

Using JavaScript and C# as our examples, let's take the example of an object with two keys: a numerical `id` and a text `description`:

```csharp
class Example {
  UInt32 id = 0;
  string description = "Initial description";
}
Example one = new Example();
```

```javascript
var one = {
  id: 0,
  description: 'Initial description'
}
```

At this point, sadly, there is _no_ guarantee how these are laid out in memory. C# uses the `LayoutKind.Auto` format—[described here][layoutkind]—for classes by default, but explicitly does not make guarantees how memory is used. JavaScript doesn't have a definition, either, leaving it to interpreter. In V8's case, for example, objects are, in the best case, laid out according to "hidden classes"—[described here][v8]—based on which properties have been added.

**TL;DR:** We need to _explicitly_ define how the langauges we use—both the "host" language and the "embedded" language—lay out shared structures in memory. Once we do, we should be able to use _native language features_ to access these structures on both sides of the bridge.

To make this easier, the [C programming language][c] is, for one reason or another, the [lingua franca][lingua-franca] of memory layouts for languages. So much so that we can often tell other languages "just use C's rules", and get the consistency we require.

### C-style in C#: LayoutKind.Sequential

To get a "c-style" class in C#, apply the `LayoutKind.Sequential` struct layout to the class:

```csharp
[StructLayout(LayoutKind.Sequential)]
public class Example {
  ...
```

### C-style in Rust: repr(C)

To get a "c-style" data type in Rust, apply the `C` representation to the struct or enum:

```rust
#[repr(C)]
pub struct Example {
  ...
```

### Also, strings

While we won't go through every possible higher-level language feature and how to fit it through an FFI bridge, let's look at strings. Strings are often considered "primitives" in languages like JavaScript and C#, but that's unfortunately naïve. A string is a collection type, just like an array, though it is a nicely strict collection: it only contains characters.

Even the "simple" collection presents the same problem: how big are these characters? Are they stored as [US-ASCII][us-ascii], [ISO 8859][iso-8859], or some [Unicode encoding][unicode]?

Just as we did with objects, we'll need to indicate _explictly_ how to treat strings. Fortunately for our example, Rust is already specific about it's standard `String` type: [it is UTF-8 encoded][rust-utf-8]. The only work we need to do, then, is be explicit on the C# side (sample taken from the example project):

```rust
#[no_mangle]
pub extern "C" fn connect_to_server(ptr: *mut *const Baton, url: *const c_char) -> bool {
  // NOTE: We still have to explicitly type-cast the string, but
  // this won't copy anything.
  let url = unsafe { CStr::from_ptr(url) };
```

```csharp
[DllImport("libffi_example")]
private static extern bool connect_to_server(out IntPtr baton, byte[] url);
public static bool connectToServer(string url)
{
    return connect_to_server(out _baton, Encoding.UTF8.GetBytes(url));
}
```

This same strategy applies to any higher-order structure you want to use in your work: trees, arrays, etc. Find a way to make their layout explicit in both the host and the embedded language, enabling you to pass a pointer between the two.

## Memory ownership

The last precaution we need to follow is ownership: if we allocate memory in one language and pass a pointer to that memory to the _other_ language, who owns that memory?

While some langauges (:cough: C :cough:) play fast-and-loose with the program's (and programmer's) ability to leak memory, most modern languages are more restrictive with the lifespan of any allocated block of memory. What this means for our FFI work is that memory allocated in Rust, for example, is _owned_ by the Rust library, and it's the Rust library's job to ensure that memory is preserved. If a pointer to that block of memory is passed to C#, and Rust allows that memory to be freed, any access to that memory from C# will result in a segmentation fault and a crash.

Each set of languages and libraries you use will present a different set of options, so I'll leave you with the following general advice: if one your project's languages makes explicit memory management (e.g. allocating, freeing, pointer math) _more difficult_, that language should own any shared memory. In our example, that langauge is C#: it is much easier to use the `unsafe` block in Rust and do whatever pointer trickery we require, so we'll allocate objects in C# that are written to in Rust, rather than trying to pass Rust-allocated memory to C#.

## Working through our example

Here are a couple interesting tidbits from the [worked example][repo]:

### Unity-to-Rust: separate arguments

There are two strategies provided in the bindings of our sample project. The first breaks each "field" of the call into a separate argument. Both sides of the binding use an `enum` to restrict the values of those arguments at compile-time, but the relationship between these values is very loose:

```csharp
public enum StatusUpdate
{
    Ping = 0,
    ...
}

// Just as with the basic example, notice that we define both a private
// method that binds to the Rust library and a public method that makes
// it nicer to call from managed code.
[DllImport("libffi_example")]
private static extern void send_status_update(IntPtr baton, UInt32 id, byte status);
public static void sendStatusUpdate(StatusUpdate status)
{
    send_status_update(_baton, _id, (byte)status);
}
```

```rust
impl<'a> Baton {
    ...
    fn send_status_update(&mut self, id: u32, status: StatusUpdate) -> Result<(), String> {
    ...
}

#[repr(u8)]
enum StatusUpdate {
    Ping,
    ...
}

impl StatusUpdate {
    ...
    fn from_byte(byte: u8) -> StatusUpdate {
        match byte {
            0 => StatusUpdate::Ping,
            ...
        }
    }
}

// Likewise, we have a type in Rust to manage the behaviour we care about,
// and a set of extern functions to handle communication with the host.
#[no_mangle]
pub extern "C" fn send_status_update(ptr: *mut Baton, id: u32, status: u8) -> bool {
    if !ptr.is_null() {
        match Baton::from_ptr(ptr).send_status_update(id, StatusUpdate::from_byte(status)) {
    ...
}
```

### Unity-to-Rust: combined object

The second strategy for communicating from Unity to Rust uses a Rust struct and a C# class to pass multiple fields at once. This provides a strong semantic coupling, improves comprehension, and makes maintenance and extension easier in the future. As mentioned above, take notice of the `StructLayout` and `repr` instructions telling each compiler to consistently and compatibly lay out the structures in memory:

```csharp
[StructLayout(LayoutKind.Sequential)]
private class rPositionUpdate {
    public UInt32 id;
    public Int32 x;
    public Int32 y;
}


[DllImport("libffi_example")]
private static extern void send_position_update(IntPtr baton, rPositionUpdate data);
public static void sendPositionUpdate(Vector3 position)
{
    rPositionUpdate update = new rPositionUpdate();

    update.id = _id; // Our ID, created randomly at start time.
    update.x = (Int32)Mathf.RoundToInt(position.x * 10000);
    update.y = (Int32)Mathf.RoundToInt(position.y * 10000);

    send_position_update(_baton, update);
}
```

```rust
impl<'a> Baton {
    ...
    fn send_position_update(&mut self, data: &mut PositionUpdate) -> Result<(), String> {
        debug!("Position update received: {:}, {:}", data.x, data.y);
    ...
}

#[derive(Debug)]
#[repr(C)]
pub struct PositionUpdate {
    pub id: u32,
    pub x: i32,
    pub y: i32,
}

#[no_mangle]
pub extern "C" fn send_position_update(ptr: *mut Baton, data: *mut PositionUpdate) -> bool {
    if !ptr.is_null() && !data.is_null() {
        match Baton::from_ptr(ptr).send_position_update(PositionUpdate::from_ptr(data)) {
        ...
}
```

_Why are X and Y multiplied by 10000?_ Just as there are conflicting ways to store strings, there are different ways to represent numbers. Rather than get C# and Rust—not to mention the UDP protocol—to agree on a representation for floating-point numbers, I decided to represent positions as 32-bit integers.

### Rust-to-Unity

The structures for communicating from Rust to Unity look much the same, though _logically_ there's another layer: the `Update` type includes an extra enum for the "kind" of update (e.g. did a new client connect, or did a client's position update?). This "kind" can be `switch`-ed on for behaviour.

```csharp
public enum UpdateType {
    None = 0,
    Connect,
    Disconnect,
    Position,
}

public class Update {
    public UpdateType type;
    public UInt32 id;
    public Vector3 position;
}

[StructLayout(LayoutKind.Sequential)]
private class rIncomingUpdate {
    public byte type = (byte)UpdateType.None;
    public UInt32 id = 0;
    public Int32 x = 0;
    public Int32 y = 0;
}

[DllImport("libffi_example")]
private static extern void read_next_update(IntPtr baton, rIncomingUpdate update);
public static Update readNextUpdate()
{
    rIncomingUpdate incoming = new rIncomingUpdate();

    read_next_update(_baton, incoming);

    Update update = new Update();
    update.type = (UpdateType)incoming.type;
    update.id = incoming.id;
    update.position = new Vector3(incoming.x / 10000.0f, incoming.y / 10000.0f, 0.0f);

    return update;
}
```

```rust
impl<'a> Baton {
    ...
    fn read_next_update(&mut self, data: *mut IncomingUpdate) -> Result<(), String> {
        // Check out the full project for all the gory networking bits.
        ...
        let update_type = cursor.read_u8().unwrap();
        ...
        if update_type == 3 {
            unsafe {
                (*data).x = cursor.read_i32::<NetworkEndian>().unwrap();
                (*data).y = cursor.read_i32::<NetworkEndian>().unwrap();
            }
        }

        Ok(())
    }
}

#[no_mangle]
pub extern "C" fn read_next_update(ptr: *mut Baton, data: *mut IncomingUpdate) -> bool {
    if !ptr.is_null() {
        match Baton::from_ptr(ptr).read_next_update(data) {
        ...
}
```

The alternative to this is to create many individual calls for each type of event, and an initial check for the "kind". This is more memory efficient (you only send what you need), but results in more calls across the FFI bridge, which is more _computationally_ expensive. Trade-offs.

## Final notes

The principles I've laid out are the same for _any_ two languages, whether you're writing a native C++ library for Node or Ruby, or if you're trying to write Lua bindings for an Erlang project. The way you apply them may be more sophisticated—like using a custom C++ type to represent the `undefined` value from V8—but the pattern of being explicit with the relationship between two langauges remains.

Finally, I'll add a note I should have started this series with: these FFI bindings are about _directly_ invoking code written in one language from code written in another. Though it might be better for performance or maintenance or comprehension, your mileage may vary. It may be easier to communicate in other ways, such as:

- Running a legacy Ruby program from your new C project.
- Starting an HTTP server inside of the Unity Editor, making requests to it from Go so you can access editor state from your Go CLI.
- Offloading processing power to a server running Scala, using ZeroMQ to coordinate work with your local Swift app.

[basic-ffi]: http://blog.testdouble.com/posts/2018-01-02-unity-rust-ffi-getting-started
[repo]: https://github.com/testdouble/rust-ffi-complex-example
[layoutkind]: https://msdn.microsoft.com/en-us/library/system.runtime.interopservices.layoutkind(v=vs.110).aspx
[v8]: https://github.com/v8/v8/wiki/Design-Elements
[c]: https://en.wikipedia.org/wiki/C_%28programming_language%29
[lingua-franca]: https://en.wikipedia.org/wiki/Lingua_franca
[us-ascii]: https://en.wikipedia.org/wiki/ASCII
[iso-8859]: https://en.wikipedia.org/wiki/ISO/IEC_8859
[unicode]: https://en.wikipedia.org/wiki/Unicode#Mapping_and_encodings
[rust-utf-8]: https://doc.rust-lang.org/book/second-edition/ch08-02-strings.html#what-is-a-string
