# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "onfleet/version"

Gem::Specification.new do |spec|
  spec.name          = "onfleet"
  spec.version       = Onfleet::VERSION
  spec.authors       = ["Eric Kreutzer"]
  spec.email         = ["eric@lugg.com"]
  spec.description   = "API client for onfleet.com"
  spec.summary       = "API client for onfleet.com"
  spec.homepage      = "https://github.com/luggg/onfleet-ruby"
  spec.license       = "MIT"

  spec.files         = "git ls-files".split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "net-http-spy"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack"
  spec.add_development_dependency "webmock"
  spec.add_dependency "nestful", "~> 1.1.0"
end
