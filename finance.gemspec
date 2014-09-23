# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'finance/version'

Gem::Specification.new do |spec|
  spec.name          = "finance"
  spec.version       = Finance::VERSION
  spec.authors       = ["James Johnston"]
  spec.email         = ["james@happysquare.com.au"]
  spec.summary       = %q{Collection of finance formulas, early stages of development}
  spec.description   = %q{This is a collection of some basic finance formulas, which I will develop as I go through: https://class.coursera.org/compfinance-007}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0.0"
end
