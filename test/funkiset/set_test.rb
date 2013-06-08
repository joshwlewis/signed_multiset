require 'test_helper'

describe Funkiset::Set do
  subject { Funkiset::Set.new(foo: 4, bar: 2) }
  describe "initialize" do
    it "must accept a hash" do
      subject.keys.must_equal([:foo, :bar])
    end
    it "must accept no arguments" do
      set = Funkiset::Set.new
      set.keys.must_equal([])
    end
    it "must accept pairs" do
      set = Funkiset::Set.new('a', 1, 'b', 2)
      set.keys.must_equal(['a','b'])
    end
  end

  describe "counters" do
    it "must be an Enumerable" do
      subject.counters.must_be_kind_of(Enumerable)
    end
    it "must contain Counters" do
      assert subject.counters.all? { |i| i.is_a?(Funkiset::Counter) }
    end
  end

  describe "<<" do
    it "should increment existing keys" do
      subject[:bar].must_equal(2)
      subject << :bar
      subject[:bar].must_equal(3)
    end
    it "should add new keys" do
      subject[:baz].must_be_nil
      subject << :baz
      subject[:baz].must_equal(1)
    end
  end

  describe "[]" do
    it "must find existing keys and return count" do
      subject[:foo].must_equal(4)
      subject[:bar].must_equal(2)
    end
    it "must return nil for missing keys" do
      subject[:baz].must_be_nil
    end
  end

  describe "[]=" do
    it "must set count for exisiting keys" do
      subject[:foo].must_equal(4)
      subject[:foo] = -1
      subject[:foo].must_equal(-1)
    end

    it "must add key and set count for new keys" do
      subject[:baz].must_be_nil
      subject[:baz] = 3
      subject[:baz].must_equal(3)
    end
  end

end