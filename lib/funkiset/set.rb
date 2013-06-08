module Funkiset
  class Set
    include Enumerable

    def initialize(*args)
      Hash[*args].each do |k,n|
        counters << Counter.new(k,n)
      end
    end

    def counters
      @counters ||= []
    end

    def each(*args, &block)
      if block_given?
        counters.each {|c| yield c }
      else
        counters.each(args)
      end
    end

    def counter(key)
      counters.find { |c| c.key == key }
    end

    def [](key)
      if c = counter(key)
        c.count
      end
    end

    def []=(key, count)
      modify_count(key, count)
      self[key]
    end

    def <<(key)
      modify_count(key){ |c| c + 1 }
      self
    end

    def keys
      map(&:key)
    end

    def counts
      map(&:count)
    end

    private

    def init_counter(key)
      unless c = counter(key)
        counters << c = Counter.new(key, 0)
      end
      c
    end

    def delete_zeros
      counters.delete_if{|c| c.count == 0 }
    end

    def modify_count(key, count=0, &block)
      c = init_counter(key)
      if block_given?
        c.count = yield(c.count)
      else
        c.count = count
      end
      delete_zeros
      counter(key)
    end

  end
end