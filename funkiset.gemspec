# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'funkiset/version'

Gem::Specification.new do |spec|
  spec.name          = "funkiset"
  spec.version       = Funkiset::VERSION
  spec.authors       = ["Josh Lewis"]
  spec.email         = ["josh.w.lewis@gmail.com"]
  spec.description   = %q{Data Structure for Multisets with negative multiplicities}
  spec.summary       = %q{Data Structure for Multisets with negative multiplicities}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"

end
