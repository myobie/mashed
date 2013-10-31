module Mashed
  class Mash < BasicObject
    def to_hash
      @hash.to_hash
    end
    alias to_h to_hash

    def puts(*args)
      ::Kernel.puts(*args)
    end

    klass = self
    define_method(:class) { klass }

    def self.name
      "Mashed::Mash"
    end

    def initialize(hash)
      hash = if hash.respond_to?(:to_h)
        hash.to_h
      else
        hash.to_hash
      end
      @hash = hash.stringify
    end

    def is_a?(other)
      other == self.class
    end
    alias kind_of? is_a?

    def [](key)
      key = key.to_s
      wrap_up @hash[key]
    end

    # NOTE: this will be incompatible because the array items will be strings
    def methods
      @hash.keys
    end

    def delete(key)
      wrap_up @hash.delete(key)
    end

    def method_missing(symbol, *args, &blk)
      string = symbol.to_s
      if @hash.key?(string)
        self[string]
      end
    end

    def inspect
      "#<Mashed::Mash @hash=>#{@hash.inspect}>"
    end
    alias to_s inspect

    private

    def wrap_up(thing)
      if thing.respond_to?(:to_ary)
        thing.map { |t| wrap(t) }
      else
        wrap(thing)
      end
    end

    def wrap(thing)
      if thing.respond_to?(:to_hash)
        self.class.new thing
      else
        thing
      end
    end
  end
end
