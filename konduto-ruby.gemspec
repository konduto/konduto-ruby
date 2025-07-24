# frozen_string_literal: true

require_relative 'lib/konduto-ruby'

Gem::Specification.new do |spec|
  spec.name         = 'konduto-ruby'
  spec.version      = KondutoRuby::VERSION
  spec.authors      = ['Gabriel Custodio', 'Jonathan Cardoso de Campos', 'Konduto Development Team']
  spec.date         = Time.now.utc.strftime('%Y-%m-%d')
  spec.email        = [%(gcmartins93@gmail.com jonathancardosodecampos@gmail.com support@konduto.com)]
  spec.homepage     = 'https://github.com/konduto/konduto-ruby'
  spec.summary      = ''
  spec.description  = 'A wrapper for konduto antifraud API'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')
  spec.files        = Dir['{lib}/**/*.rb', 'LICENSE', '*.md']
  spec.require_path = 'lib'
  spec.license      = 'MIT'

  # tests
  spec.add_development_dependency  'factory_girl', '~> 4.9'
  spec.add_development_dependency  'minitest', '~> 5.16.3'
  spec.add_development_dependency  'rake', '~> 12.3.3'
  spec.add_development_dependency  'rubocop', '~> 1.35.0'
  spec.add_development_dependency  'rubocop-minitest'
  spec.add_development_dependency  'simplecov'
end
