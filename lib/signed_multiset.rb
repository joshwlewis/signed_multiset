class SignedMultiset
  VERSION = "0.2.1"

  include Enumerable
  include Comparable

  attr_reader :entries

  # Create a new SignedMultiset instance.
  #
  # @param object [Enumerable, nil] An array of keys, or key-muliplicity pairs.
  def initialize(*args)
    @entries = {}
    obj = args.count == 1 ? args.first : args
    if obj.respond_to?(:each)
      obj.each { |k, v| increment(k, v || 1) }
    else
      self << obj
    end
  end

  # Get the non-zero key-multiplicity pairs.
  #
  # @return [Hash]
  def multiplicities
    entries.reject{|k,v| v == 0}
  end

  # Iterate over the multiplicity collection.
  #
  # @return [Enumerator]
  def each(*args, &block)
    if block_given?
      multiplicities.each { |k,v| yield(k,v) }
    else
      multiplicities.each(args)
    end
  end

  # Get the multiplicity for a key.
  #
  # @param key [Object] The key to get the multiplicity of
  # @return [Integer, nil] The multiplicity for the key, or nil if the key is
  #   not present, or has a zero multiplicity
  def [](key)
    multiplicities[key]
  end

  # Set the multiplicity for a key.
  #
  # @param key [Object] The key to set the multiplicity of
  # @param multiplicity [Integer] The desired multiplicity
  # @return [Integer] The multiplicity for the key
  def []=(key, multiplicity)
    entries[key] = multiplicity
    self[key]
  end

  # Increment the multiplicity for a key.
  #
  # @param key (see #[]=)
  # @param value [Integer] The desired increment value, positive or negative
  # @return (see #[]=)
  def increment(key, value)
    entries[key] ||= 0
    entries[key] += value
    self[key]
  end

  # Increment multiplicity by 1 for a key. This method is chainable.
  #
  # @param key [Object] The key to increment the multiplicity of
  # @return [self]
  def <<(key)
    increment(key, 1)
    self
  end

  # Remove key completely from the set, similar to [key]=0
  #
  # @param key [Object] The key to remove
  # @return [Integer] The multiplicity of the item removed.
  def delete(key)
    entries.delete(key)
  end

  # Creates a new instance of equal to current instance
  # @return [SignedMultiset]
  def dup
    self.class.new(multiplicities)
  end

  # Combine self with another SignedMultiset via addition to create a merged instance.
  #
  # @param other [SignedMultiset]
  # @return [SignedMultiset]
  def +(other)
    other.multiplicities.reduce(self.dup) do |m, (k, v)|
      m.increment(k,v); m
    end
  end

  # Combine self with another SignedMultiset via subtraction to create a merged instance.
  #
  # @param other (see #+)
  # @return (see #+)
  def -(other)
    other.multiplicities.reduce(self.dup) do |m, (k, v)|
      m.increment(k,-v); m
    end
  end

  # Combine self with another SignedMultiset via union to create a merged instance.
  #
  # @param other (see #+)
  # @return (see #+)
  def |(other)
    (keys | other.keys).reduce(self.class.new) do |m, k|
      m.increment(k, [self[k] || 0, other[k] || 0].max); m
    end
  end

  # Combine self with another SignedMultiset via intersection to create a merged instance.
  #
  # @param other (see #+)
  # @return (see #+)
  def &(other)
    (keys & other.keys).reduce(self.class.new) do |m, k|
      m.increment(k, [self[k], other[k]].min); m
    end
  end

  # Get the list of keys for self.
  #
  # @return [Array]
  def keys
    multiplicities.keys
  end

  # Get the multiplicity values for self.
  #
  # @return [Array]
  def values
    multiplicities.values
  end

  # Get the cardinality (sum of multiplicities) for self.
  #
  # @return [Integer]
  def cardinality
    values.inject(&:+)
  end
  alias_method :sum, :cardinality

  # Get the count of unique keys in the SignedMultiset.
  #
  # @return [Integer]
  def size
    keys.size
  end
  alias_method :length, :size

  # Compare self with another SignedMultiset
  #
  # @param other (see #+)
  # @return [-1,0,1]
  def <=>(other)
    if [:multiplicities, :cardinality, :size].all? { |m| other.respond_to?(m) }
      if multiplicities == other.multiplicities
        0
      elsif cardinality != other.cardinality
        cardinality <=> other.cardinality
      elsif size != other.size
        size <=> other.size
      else
        multiplicities <=> other.multiplicities
      end
    end
  end

  def to_hash
    multiplicities.dup
  end

  def to_a
    multiplicities.to_a
  end

  def to_s
    multiplicities.map{ |k,m| "#{k}: #{m}"}.join(', ')
  end

  def inspect
    "<#{self.class} #{to_s}>"
  end

end

def SignedMultiset(input)
  SignedMultiset.new(input)
end