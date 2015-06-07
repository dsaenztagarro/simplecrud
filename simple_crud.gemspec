# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_crud/version'

Gem::Specification.new do |spec|
  spec.name          = 'simplecrud'
  spec.version       = SimpleCrud::VERSION
  spec.authors       = ['David Saenz Tagarro']
  spec.email         = ['david.saenz.tagarro@gmail.com']

  spec.summary       = %q{CRUD Rails Controllers made easy}
  spec.description   = %q{CRUD Rails Controllers made easy}
  spec.homepage      = 'https://github.com/dsaenztagarro/simplecrud'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
end
