# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eway_rapid/version'

Gem::Specification.new do |spec|
  spec.name          = 'eway_rapid'
  spec.version       = EwayRapid::VERSION
  spec.required_ruby_version = '>= 2.0.0'
  spec.author        = ['eWAY']
  spec.summary       = 'Ruby gem for eWAY\'s Rapid API'
  spec.description   = 'Easy online payments with eWAY and the eWAY Rapid Ruby gem.'
  spec.homepage      = 'https://www.eway.com.au'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_dependency 'json', '~> 2.3.0'
  spec.add_dependency 'rest-client', '~> 2.0'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'test-unit'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rubocop'
end
