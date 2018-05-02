# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vestorforce/version'

Gem::Specification.new do |spec|
  spec.name          = 'vestorforce'
  spec.version       = Vestorforce::VERSION
  spec.authors       = ['Michael Polycarpou', 'Remy Carr']
  spec.email         = ['remy@vestorly.com']
  spec.summary       = %q(
    A wrapper around restforce for querying campaigns and campaign members.
  )
  spec.description   = %q(
    Salesforce api ruby abstraction
  )
  spec.homepage      = 'https://www.vestorly.com/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'restforce', '~> 2.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'database_cleaner', '~> 1.4'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-gem-adapter'
end
