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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
