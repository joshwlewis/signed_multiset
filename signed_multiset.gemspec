# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'signed_multiset/version'

Gem::Specification.new do |spec|
  spec.name          = "signed_multiset"
  spec.version       = SignedMultiset::VERSION
  spec.authors       = ["Josh Lewis"]
  spec.email         = ["josh.w.lewis@gmail.com"]
  spec.description   = %q{Multisets with negative membership}
  spec.summary       = %q{Signed Multiset is a Ruby implementation of a Multiset that allows negative membership. You can think of it as a Multiset or Bag that allows for negative counts. It feels like a Ruby Hash or Array, but with some differences.}
  spec.homepage      = "http://github.com/joshwlewis/signed_multiset"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"

end
