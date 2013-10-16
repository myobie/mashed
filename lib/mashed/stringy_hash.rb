require 'delegate'

module Mashed
  module ExtendHash
    def stringify
      dup.each_with_object({}) { |(k,v), h| h[k.to_s] = v }
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
