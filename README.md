# signed_multiset

[![Gem Version](https://badge.fury.io/rb/signed_multiset.png)](http://badge.fury.io/rb/signed_multiset)
[![Build Status](https://travis-ci.org/joshwlewis/signed_multiset.png?branch=master)](https://travis-ci.org/joshwlewis/signed_multiset)
[![Code Climate](https://codeclimate.com/github/joshwlewis/signed_multiset.png)](https://codeclimate.com/github/joshwlewis/signed_multiset)
[![Dependency Status](https://gemnasium.com/joshwlewis/signed_multiset.png)](https://gemnasium.com/joshwlewis/signed_multiset)

Signed Multiset is a Ruby implementation of a Multiset that allows negative membership.

You can think of it as a Multiset or Bag that allows for negative counts. It's functionality is very similar to Sorted Sets available in Redis (albeit without the storage functionality). It feels like a Ruby Hash or Array, but with some differences:

- A key (any ruby object) can be added to or removed from the SignedMultiset any number of times. The number of times it is included in the multiset (positive or negative) is referred to as it's multiplicity.

- A key can only be considered a member of the SignedMultiset if it's multiplicity is not 0. Setting it's multiplicity to 0 effectively removes that item from the SignedMultiset.

- The size or length of a SignedMultiset is the number of unique keys with non-zero multiplicities.

- The cardinality or sum of a SignedMultiset is the total sum of the multiplicities.

For futher reading, refer to [Negative Membership](http://projecteuclid.org/DPubS/Repository/1.0/Disseminate?view=body&id=pdf_1&handle=euclid.ndjfl/1093635499) by Wayne D. Blizard.

## Installation

Add this line to your application's Gemfile:

    gem 'signed_multiset'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install signed_multiset

## Usage

```ruby
require 'signed_multiset'

set = SignedMultiset.new(a: 1, b: 2, c: 3)
# => <SignedMultiset a: 1, b: 2, c: 3>

set[:b]
# => 2

set[:d] = -4
# => -4

set << :d
# => <SignedMultiset a: 1, b: 2, c: 3, d: -3>

set.increment(a, -1)
# => 0

set[:a]
# => nil

set
# => <SignedMultiset b: 2, c: 3, d: -3>

set.cardinality
# => 2

set.size
# => 3

other_set = SignedMultiset(:a, :c, :d, :d)
# => <SignedMultiset a: 1, c: 1, d: 2>

set + other_set
# => <SignedMultiset b: 2, c: 4, d: -1, a: 1>

set & other_set
# => <SignedMultiset c: 1, d: -3>

set | other_set
# => <SignedMultiset b: 2, c: 3, d: 2, a: 1>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
