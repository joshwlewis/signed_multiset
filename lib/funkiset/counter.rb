module Funkiset
  class Counter
    attr_accessor :count
    attr_reader :key

    def initialize(key, count)
      @key = key
      @count = count
    end

    def to_s
      "#{key}: #{count}"
    end

    def inspect
      "<Funkiset::Counter #{to_s}>"
    end

    def to_hash
      {key => count}
    end

  end
end