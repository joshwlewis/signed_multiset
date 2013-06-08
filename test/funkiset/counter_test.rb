require 'test_helper'

describe Funkiset::Counter do
  subject { Funkiset::Counter.new('a',3) }

  it "should have a key" do
    subject.must_respond_to :key
  end

  it "should have a number" do
    subject.must_respond_to :number
  end

end