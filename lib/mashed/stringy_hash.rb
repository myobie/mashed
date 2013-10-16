require 'delegate'

module Mashed
  module ExtendHash
    def stringify
      StringyHash.new(dup.each_with_object({}) { |(k,v), h| h[k.to_s] = v })
    end
  end

  class StringyHash < SimpleDelegator
    def stringify
      dup
    end

    def [](key)
      super(key.to_s)
    end

    def []=(key, value)
      super(key.to_s, value)
    end
    alias store []=

    def delete(key, &blk)
      super(key.to_s, &blk)
    end

    def merge(other_hash, &blk)
      super(other_hash.stringify, &blk)
    end

    def merge!(other_hash, &blk)
      super(other_hash.stringify, &blk)
    end

    def replace(other_hash, &blk)
      super(other_hash.stringify, &blk)
    end

    def update(other_hash, &blk)
      super(other_hash.stringify, &blk)
    end
  end
end

Hash.send :include, Mashed::ExtendHash
