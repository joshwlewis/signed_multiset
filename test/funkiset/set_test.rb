require 'test_helper'

describe Funkiset::Set do
  subject { Funkiset::Set.new(foo: 4, bar: 2) }
  describe "initialize" do
    it "must accept no arguments" do
      set = Funkiset::Set.new
      set.keys.must_equal([])
    end
    it "must accept a hash" do
      set = Funkiset::Set.new(alpha: 1, beta: 2)
      set.keys.must_equal([:alpha, :beta])
    end
    it "must accept pairs" do
      set = Funkiset::Set.new('a', 1, 'b', 2)
      set.keys.must_equal(['a','b'])
    end
  end

  describe "items" do
    it "must be an Enumerable" do
      subject.items.must_be_kind_of(Enumerable)
    end
    it "must contain Counters" do
      assert subject.items.all? { |i| i.is_a?(Funkiset::Counter) }
    end
  end

  describe "add" do
    describe "existing keys" do
      it "without a number" do
        subject[:foo].number.must_equal(4)
        subject.add(:foo)
        subject[:foo].number.must_equal(5)
      end
      it "with a number" do
        subject[:bar].number.must_equal(2)
        subject.add(:bar,4)
        subject[:bar].number.must_equal(6)
      end
    end
  end


end