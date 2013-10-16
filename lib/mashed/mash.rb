module Mashed
  class Mash < BasicObject
    def to_hash
      @hash
    end

    def initialize(hash)
      @hash = hash.stringify
    end

    # NOTE: this will be incompatible because the array items will be strings
    def methods
      @hash.keys
    end

    def method_missing(symbol, *args, &blk)
      string = symbol.to_s
      if @hash.key?(string)
        @hash[string]
      end
    end
  end
end
