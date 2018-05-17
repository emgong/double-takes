---
title: "Do we need Dependency Injection in ruby?"
description: "It's easy to find fault in the way we interview in tech. Let's make a better technical interview with honesty, transparency, and a more realistic experience."
author:
  name: "Kevin Baribeau"
  url: "http://twitter.com/kbaribeau"

reddit: false
---

Let's start this with a quick example. You're selling clothes, and your Shirt
class looks something like this.

```
# In real life, these two classes/methods would call an API or something
# Let's ignore those details though :)
class Inventory
  def self.check_availability(product_code); end
end
class Purchaser
  def self.purchase_item(product_code); end
end

class Shirt
  def initialize(product_code)
    @product_code = product_code
  end

  def buy!
    if Inventory.check_availability(product_code)
      Purchaser.purchase_item(product_code)
      true
    else
      false
    end
  end

  private

  attr_reader :product_code
end
```

...and, you've got some tests that looks like this:


```
require 'rspec'
require_relative 'shirt_with_class_methods'

describe Shirt do
  it "doesn't buy shirts when there are none left" do
    shirt = Shirt.new('abc123')
    allow(Inventory).to receive(:check_availability).with('abc123').and_return(false)
    expect(Purchaser).to_not receive(:purchase_item).with('abc123')

    result = shirt.buy!

    expect(result).to eq(false)
  end

  it "buys a shirt when there are shirts available" do
    shirt = Shirt.new('abc123')
    allow(Inventory).to receive(:check_availability).with('abc123').and_return(true)
    expect(Purchaser).to receive(:purchase_item).with('abc123')

    result = shirt.buy!

    expect(result).to eq(true)
  end
end
```

A long time ago, in Java-land, I worked on a team that was doing lots of TDD, but at the
time, mocking a class method was a technical impossibility. So, you'd have to come up with
another way of writing your code so that testing was even possible.

The ruby version of that code might look something like this:

```
# Again, these methods don't *do* anything, but,
# we made them instance methods this time
class Inventory
  def check_availability(product_code); end
end
class Purchaser
  def purchase_item(product_code); end
end

class Shirt
  def initialize(product_code, inventory, purchaser)
    @product_code = product_code
    @inventory = inventory
    @purchaser = purchaser
  end

  def buy!
    if inventory.check_availability(product_code)
      purchaser.purchase_item(product_code)
      true
    else
      false
    end
  end

  private

  attr_reader :product_code, :inventory, :purchaser
end
```

And you'd have specs that look like this:

```
require 'rspec'
require_relative 'shirt_v2'

describe Shirt do
  it "doesn't buy shirts when there are none left" do
    fake_inventory = Object.new
    fake_inventory.define_singleton_method(:check_availability) { |_product_code| false }
    fake_purchaser = spy
    shirt = Shirt.new('small', fake_inventory, fake_purchaser)

    result = shirt.buy!

    expect(result).to eq(false)
  end

  it "buys a shirt when there are shirts available" do
    fake_inventory = Object.new
    fake_inventory.define_singleton_method(:check_availability) do |product_code|
      product_code == 'abc123'
    end
    fake_purchaser = spy
    shirt = Shirt.new('abc123', fake_inventory, fake_purchaser)

    result = shirt.buy!

    expect(fake_purchaser).to have_received(:purchase_item).with('abc123')
    expect(result).to eq(true)
  end
end
```

If I mention "Dependency Injection", a lot of people seem to think I mean that you should use a framework. In reality, I'm trying to advocate for a design like the second example here. I'd like to be able to pass in dependencies to an Object, instead of having that object rely on class methods or other globally accessible things.

It's hard to articulate why I prefer the second example though. I think some people would even be against it; it doesn't look like typical ruby code. So, I have to ask myself, why do I like it?

I tried to come up with some reasons myself. I realized that I'm a big fan the [Arrange, Act, Assert](https://github.com/testdouble/contributing-tests/wiki/Arrange-Act-Assert) pattern of writing tests. The spec in the first example doesn't follow that pattern, which bugs me. That's a pretty small criticism though.

I asked the Test Double #ruby slack channel for some other thoughts.

Dave Mosher pointed out that the `allow(x).to_receive(y)` syntax is a little weird. My thoughts are that it's common enough though that it's intent is probably clear. But, if I have a spec that's failing and I don't understand why, I'll probably find myself questioning the weird bits, and the implementation of `to_receive` is going to be hard to debug.  Having a preference for code that's too-dumb-to-fail over a complex library like rspec-mocks is probably a good thing.

Steven Harman gave me the answer I was really looking for, but couldn't find myself. The second version of the code has a much clearer dependency structure than the first. Even in the first example, it's not hard to see that Shirt depends on Inventory and Purchaser, but classes often grow. If this class were a hundred lines long or more, it would be nice to have it's dependencies explicitly laid out.  In fact, if we explicitly lay out a classes dependencies, it probably won't ever grow to a hundred lines or more. Someone will probably (hopefully?) notice that it's list of dependencies is getting long, and try to split it up.

Lastly, Alex Burkhart pointed me at the section on Dependency Injection in Sandi Metz's excellent book: Practical Object-Oriented Design in Ruby. Sandi brings up the excellent point that "...knowing the name of a class and the responsibility for knowing the name of a message to send to that class may belong in different objects". The whole section is great, go read it.

I now think I'm convinced that doing Dependency Injection is a good thing (tm), even when you have a mocking framework that makes DI optional. I like all of these arguments:

   * Objects that support DI tend to have a much clearer set of dependencies
   * Some mocking frameworks force you to avoid the Arrange, Act, Assert pattern in your tests
   * Most mocking frameworks are hard to debug, you don't want some poor future maintainer to waste time on that, almost especially if the mocking framework isn't broken, and the problem is actually somewhere else.
   * Sandi Metz has more to say on this topic. We should all go read her books
