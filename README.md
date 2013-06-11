# signed_multiset

[![Build Status](https://travis-ci.org/joshwlewis/signed_multiset.png?branch=master)](https://travis-ci.org/joshwlewis/signed_multiset)
[![Code Climate](https://codeclimate.com/github/joshwlewis/signed_multiset.png)](https://codeclimate.com/github/joshwlewis/signed_multiset)
[![Dependency Status](https://gemnasium.com/joshwlewis/signed_multiset.png)](https://gemnasium.com/joshwlewis/signed_multiset)

Signed Multiset is a Ruby implementation of a Multiset that allows negative membership.

You can think of it as a Multiset or Bag that allows for negative counts. It feels like a Ruby Hash or Array, but with some differences:

- A key (any ruby object) can be added to or removed from the Multiset any number of times, and is referred to as it's multiplicity

- A key can only be considered a member of the Signed Multiset if it's multiplicity is not 0. Setting it's multiplicity to 0 effectively removes that item from the SignedMultiset.

- The size or length of a SignedMultiset is the number of unique keys with non-zero multiplicities.

- The cardinality or sum of a SignedMultiset is the total sum of the multiplicities.

For theory and proofs, refer to [Negative Membership](http://projecteuclid.org/DPubS/Repository/1.0/Disseminate?view=body&id=pdf_1&handle=euclid.ndjfl/1093635499) by Wayne D. Blizard.

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

s = SignedMultiset.new(a: 1, b: 2, c: 3)
#=> => <SignedMultiset a: 1, b: 2, c: 3>

s[:b]
#=> 2

s[:d] = -4
#=> -4

s << :d
#=> <SignedMultiset a: 1, b: 2, c: 3, d: -3>

s.increment(a, -1)
#=> 0

s[:a]
#=> nil
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
