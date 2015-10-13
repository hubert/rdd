# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rdd/version'

Gem::Specification.new do |spec|
  spec.name          = "rdd"
  spec.version       = RDD::VERSION
  spec.authors       = ["hubert"]
  spec.email         = ["hubert77@gmail.com"]
  spec.description   = %q{resume driven development}
  spec.summary       = %q{rdd ftw}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'ruby-progressbar', '~> 1.7'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", '~> 10.4'
  spec.add_development_dependency 'rspec', '~> 3.3'
end
