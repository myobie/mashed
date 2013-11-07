module Mashed
  class Mash < BasicObject
    def singleton_method_added(symbol)
      @singleton_methods ||= []
      @singleton_methods << symbol
    end
    def singleton_method_removed(symbol)
      @singleton_methods ||= []
      @singleton_methods.delete symbol
    end
    def singleton_method_undefined(symbol)
      singleton_method_removed(symbol)
    end

    def to_hash
      @hash.to_hash
    end
    alias to_h to_hash

    def to_json(*args)
      to_hash.to_json(*args)
    end

    def puts(*args)
      ::Kernel.puts(*args)
    end

    klass = self
    define_method(:class) { klass }
    define_method(:methods) { klass.instance_methods + @singleton_methods + keys }

    def self.name
      "Mashed::Mash"
    end

    def initialize(hash)
      @singleton_methods ||= []
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

    def keys
      @hash.keys
    end

    def delete(key)
      wrap_up @hash.delete(key)
    end

    def method_missing(symbol, *args, &blk)
      string = symbol.to_s
      if @hash.key?(string)
        self[string]
      elsif string =~ /\?$/
        !!self[string[0..-2]]
      else
        nil
      end
    end

    def respond_to?(symbol)
      methods.map(&:to_s).include?(symbol.to_s)
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
