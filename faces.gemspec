# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faces/version'

Gem::Specification.new do |spec|
  spec.name          = 'faces'
  spec.version       = Faces::VERSION
  spec.author        = 'Nick Pellant'
  spec.email         = 'nick@nickpellant.com'
  spec.description   = %q{A generalised framework for the implementation of multiple avatar providers.}
  spec.summary       = spec.description
  spec.homepage      = "http://github.com/nickpellant/faces"
  spec.license       = 'MIT'
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack'
  spec.add_dependency 'hashie', ['>= 1.2', '< 3']
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
