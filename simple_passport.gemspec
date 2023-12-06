# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_passport/version'

Gem::Specification.new do |spec|
  spec.name          = 'simple_passport'
  spec.version       = SimplePassport::VERSION
  spec.authors       = ['Gennady Kalashnikov']
  spec.email         = ['gennady.kalashnikov@flant.com']

  spec.summary       = 'Short summary.'
  spec.description   = 'Longer description.'
  spec.homepage      = 'https://github.com/flant/simple_passport'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'minitest', '~> 5.1'
  spec.add_development_dependency 'rake', '~> 12.3'

  spec.add_dependency 'rails', '>= 5.2', '< 7.2'
end
