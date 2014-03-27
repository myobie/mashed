require 'delegate'

module Mashed
  class StringyHash < SimpleDelegator
    def self.stringify(object)
      if object.is_a?(Array)
        object.map { |value| StringyHash.stringify(value) }
      elsif object.is_a?(Hash)
        StringyHash.new(object.each_with_object({}) do |(k,v), h|
          h[k.to_s] = StringyHash.stringify(v)
        end)
      else
        object
      end
    end

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

    def key?(key)
      super(key.to_s)
    end

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
