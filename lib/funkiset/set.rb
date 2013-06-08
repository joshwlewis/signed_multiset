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
        counters.each { |k,v| yield(k,v) }
      else
        counters.each(args)
      end
    end

    def [](key)
      counters[key]
    end

    def []=(key, count)
      entries[key] = count
      counters[key]
    end

    def add(key, count)
      entries[key] ||= 0
      entries[key] += count
    end

    def <<(key)
      add(key, 1)
      self
    end

    def dup
      self.class.new(counters)
    end

    def merge(other)
      other.counters.reduce(self.dup) do |m, (k, v)|
        m.add(k,v); m
      end
    end
    alias_method :+, :merge

    def keys
      counters.keys
    end

    def counts
      counters.values
    end

    def to_s
      counters.map{ |k,c| "#{k}: #{c}"}.join(', ')
    end

    def inspect
      "<Funkiset::Set #{to_s}>"
    end

  end
end