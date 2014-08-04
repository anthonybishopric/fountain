# -*- encoding: utf-8 -*-

require File.expand_path('../lib/fountain/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'fountain'
  gem.version       = Fountain::VERSION
  gem.summary       = 'A Database Building DSL for Docker'
  gem.description   = 'Fountain is a DSL and command line utility for building Docker images containing large amounts of test data.'
  gem.license       = 'MIT'
  gem.authors       = ['abishopric']
  gem.email         = 'fountain@anthonybishopric.com'
  gem.homepage      = 'https://rubygems.org/gems/fountain'

  gem.required_ruby_version = ' ~> 2.1'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'commander'
  gem.add_runtime_dependency 'factory_girl'

  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
  gem.add_development_dependency 'rubocop'
end
