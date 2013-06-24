# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'signed_multiset'

Gem::Specification.new do |spec|
  spec.name          = "signed_multiset"
  spec.version       = SignedMultiset::VERSION
  spec.authors       = ["Josh Lewis"]
  spec.email         = ["josh.w.lewis@gmail.com"]
  spec.description   = %q{Multisets with negative membership}
  spec.summary       = %q{You can think of it as a Multiset or Bag that allows for negative counts. It's functionality is very similar to Sorted Sets available in Redis (albeit without the storage functionality). It feels like a Ruby Hash or Array, but with some differences.}
  spec.homepage      = "http://github.com/joshwlewis/signed_multiset"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end