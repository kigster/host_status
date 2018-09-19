# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'host_status/version'

Gem::Specification.new do |spec|
  spec.name          = 'host_status'
  spec.version       = HostStatus::VERSION
  spec.authors       = ['Konstantin Gredeskoul']
  spec.email         = %w(kigster@gmail.com)

  spec.summary       = %q{A generalized interface for obtaining a status of an application running on a given host, intended to be used in Canary Deploys. Supports any number of backend adapters such as NewRelic.}
  spec.description   = %q{A generalized facade that aggregates metrics for a given host running a particular application using any number of adapters and plugins including third-party APIs.}
  spec.homepage      = 'https://github.com/kigster/host_status'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-configurable'
  spec.add_dependency 'dry-types'
  spec.add_dependency 'dry-struct'
  spec.add_dependency 'activesupport', '> 3'

  spec.add_dependency 'hashie'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'awesome_print'
end
