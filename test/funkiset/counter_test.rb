require 'test_helper'

describe Funkiset::Counter do
  subject { Funkiset::Counter.new('a',3) }

  it "should have a key" do
    subject.must_respond_to :key
    subject.key.must_equal('a')
  end

  it "should have a count" do
    subject.must_respond_to :count
    subject.count.must_equal(3)
  end

end