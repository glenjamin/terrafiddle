# Terrafiddle!

A mini ruby dsl for generating terraform files.

It's a terrible name, but a useful lib.


This is intended to be used in conjuction with human authored `.tf` files

## Installing

For now, just copy the `terrafiddle.rb` file into your project - it's less than 20 lines.

Perhaps at some point I'll make it an actual gem.

## Usage

Create a ruby file for building up some terraform config.

```ruby
require './terrafiddle'

resource :resource_type, "Name", {
  attr: 1,
  attr2: "value",
  attr3: "${another_resource.name.attribute}"
}
```

And then run it to generate some JSON

```sh
ruby stuff.tf.rb > stuff.tf.json
```

If you have a bunch of these, you'll probably want a Makefile. Here's an example:

```make
# Based on http://lincolnmullen.com/blog/make-and-pandoc/

TERRAFORMS := $(patsubst %.rb,%.json,$(wildcard *.tf.rb))

all : build plan

build : $(TERRAFORMS)

%.json : %.rb terrafiddle.rb
  ruby $< > $@

plan :
  terraform plan

clean :
  rm $(TERRAFORMS)

rebuild : clean build

graph : graph.png

graph.png :
  terraform graph | dot -Tpng > $@
```
