module Funkiset
  class Counter
    attr_accessor :number
    attr_reader :key

    def initialize(key, number=1)
      @key = key
      @number = number.to_i
    end

  end
end