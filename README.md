# Mashed

A Mash.

## Installation

Add this line to your application's Gemfile:

    gem 'mashed'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mashed

## Usage

```ruby
Mash = Mashed::Mash

m = Mash.new(title: "Hello", starred: false, completed_at: nil)

m.title # => "Hello"
m.methods # => ["title", "starred", "completed_at"]

tasks = Api(:tasks, :v1).get("/tasks", list_id: "inbox").json.map { |hash| Mash.new(hash) }

tasks.each do |task|
  puts tasks.title
end
```

### A Mash Is Not A Hash

```ruby
Mash = Mashed::Mash

m = Mash.new(a: "A", b: "B")
m.map { |key, value| puts [key, value].inspect } # => raise

# assuming activesupport is present...

m.with_indifferent_access # => nil
# there is no key of "with_indifferent_access" for the internal hash
```

### There is also a StringyHash

```ruby
h = StringyHash.stringify(a: "A", b: "B")

h["a"] === h[:a] # => true

h[:something_new] = "foo"
h.key?(:something_new) # => true
h.key?("something_new") # => true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## StringyHash

To help make the Mash work there also is a StringyHash class. It's a
simple delegate to the normal Hash except that it tries to enforce that
all incoming and outgoing keys are strings.

### Usage

```ruby
StringyHash = Mash::StringyHash

sh = StringyHash.new(title: "Hello", starred: false, completed_at: nil)
sh.keys # => ["title", "starred", "completed_at"]
sh[:title] # => "Hello"
sh["title"] # => "Hello"

class Title
  def to_s
    "title"
  end
end

sh[Title.new] # => "Hello"
```
