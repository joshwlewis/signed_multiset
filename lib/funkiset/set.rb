module Funkiset
  class Set
    include Enumerable

    def initialize(*args)
      @entries = Hash[*args]
    end

    def entries
      @entries ||= {}
    end

    def counters
      entries.delete_if{|k,v| v == 0}
    end

    def each(*args, &block)
      if block_given?
        counters.each {|k,v| yield(k,v) }
      else
        counters.each(args)
      end
    end

    def counter(key)
      counters.find { |c| c.key == key }
    end

    def [](key)
      counters[key]
    end

    def []=(key, count)
      counters[key] = count
    end

    def <<(key)
      entries[key] ||= 0
      entries[key] += 1
      counters
    end

    def keys
      counters.keys
    end

    def counts
      map(&:count)
    end

  end
end