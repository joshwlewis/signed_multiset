module Funkiset
  class Set
    include Enumerable

    def initialize(*args)
      Hash[*args].each do |k,n|
        items << Counter.new(k,n)
      end
    end

    def items
      @items ||= []
    end

    def each(*args, &block)
      if block_given?
        items.each {|i| yield i }
      else
        items.each(args)
      end
    end

    def add(key, number=1)
      if item = self[key]
        item.number += number
      else
        item = Counter.new(key, number)
        items << item
      end
      item
    end

    def [](key)
      items.find { |i| i.key == key }
    end

    def keys
      map(&:key)
    end

    def <<(key)
      add(key)
    end

  end
end