module Funkiset
  class Set
    include Enumerable
    include Comparable

    def self.[](*list)
      new(list)
    end

    def initialize(object=nil)
      if object.is_a?(Enumerable)
        object.each { |k, v| increment(k, v || 1) }
      end
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

    def increment(key, count)
      entries[key] ||= 0
      entries[key] += count
    end

    def <<(key)
      increment(key, 1)
      self
    end

    def dup
      self.class.new(counters)
    end

    def +(other)
      other.counters.reduce(self.dup) do |m, (k, v)|
        m.increment(k,v); m
      end
    end

    def -(other)
      other.counters.reduce(self.dup) do |m, (k, v)|
        m.increment(k,-v); m
      end
    end

    def |(other)
      (keys | other.keys).reduce(self.class.new) do |m, k|
        m.increment(k, [self[k] || 0, other[k] || 0].max); m
      end
    end

    def &(other)
      (keys & other.keys).reduce(self.class.new) do |m, k|
        value = [self[k], other[k]].min
        m.increment(k, value); m
      end
    end

    def keys
      counters.keys
    end

    def counts
      counters.values
    end

    def sum
      counts.inject(&:+)
    end
    alias_method :cardinality, :sum

    def size
      keys.size
    end

    alias_method :length, :size

    def <=>(other)
      if [:counters, :sum, :size].all? { |m| other.respond_to?(m) }
        if counters == other.counters
          0
        elsif sum != other.sum
          sum <=> other.sum
        elsif size != other.size
          size <=> other.size
        else
          counters <=> other.counters
        end
      end
    end

    def to_hash
      counters.dup
    end

    def to_a
      counters.to_a
    end

    def to_s
      counters.map{ |k,c| "#{k}: #{c}"}.join(', ')
    end

    def inspect
      "<Funkiset::Set #{to_s}>"
    end

  end
end