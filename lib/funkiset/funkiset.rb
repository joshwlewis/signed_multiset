class Funkiset

  include Enumerable
  include Comparable

  # Create a new instance with a list of objects.
  #
  # @param *list [Object] A list of objects to add to the set
  def self.[](*list)
    new(list)
  end

  # Create a new Funkiset instance.
  #
  # @param object [Enumerable, nil] An array of keys, or key-muliplicity pairs.
  def initialize(object=nil)
    if object.is_a?(Enumerable)
      object.each { |k, v| increment(k, v || 1) }
    end
  end

  # Get the non-zero key-multiplicity pairs.
  #
  # @return [Hash]
  def multiplicities
    entries.delete_if{|k,v| v == 0}
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
    multiplicities[key]
  end

  # Increment the multiplicity for a key.
  #
  # @param key (see #[]=)
  # @param value [Integer] The desired increment value, positive or negative
  # @return (see #[]=)
  def increment(key, value)
    entries[key] ||= 0
    entries[key] += value
  end

  # Increment multiplicity by 1 for a key. This method is chainable.
  #
  # @param key [Object] The key to increment the multiplicity of
  # @return [self]
  def <<(key)
    increment(key, 1)
    self
  end

  # Creates a new instance of equal to current instance
  # @return [Funkiset]
  def dup
    self.class.new(multiplicities)
  end

  # Combine self with another Funkiset via addition to create a merged instance.
  #
  # @param other [Funkiset]
  # @return [Funkiset]
  def +(other)
    other.multiplicities.reduce(self.dup) do |m, (k, v)|
      m.increment(k,v); m
    end
  end

  # Combine self with another Funkiset via subtraction to create a merged instance.
  #
  # @param other (see #+)
  # @return (see #+)
  def -(other)
    other.multiplicities.reduce(self.dup) do |m, (k, v)|
      m.increment(k,-v); m
    end
  end

  # Combine self with another Funkiset via union to create a merged instance.
  #
  # @param other (see #+)
  # @return (see #+)
  def |(other)
    (keys | other.keys).reduce(self.class.new) do |m, k|
      m.increment(k, [self[k] || 0, other[k] || 0].max); m
    end
  end

  # Combine self with another Funkiset via intersection to create a merged instance.
  #
  # @param other (see #+)
  # @return (see #+)
  def &(other)
    (keys & other.keys).reduce(self.class.new) do |m, k|
      value = [self[k], other[k]].min
      m.increment(k, value); m
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

  # Get the count of unique keys in the Funkiset.
  #
  # @return [Integer]
  def size
    keys.size
  end
  alias_method :length, :size

  # Compare self with another Funkiset
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
    multiplicities.map{ |k,c| "#{k}: #{c}"}.join(', ')
  end

  def inspect
    "<Funkiset #{to_s}>"
  end

  private

  # Get the key-multiplicity pairs (even those with zero multiplicities).
  #
  # @return [Hash]
  def entries
    @entries ||= {}
  end

end