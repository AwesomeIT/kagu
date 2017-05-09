# frozen_string_literal: true
require './lib/kagu/version'
require 'date'

Gem::Specification.new do |gem|
  gem.name    = 'kagu'
  gem.version = Kagu::VERSION
  gem.date    = Date.today.to_s

  gem.summary = 'Models for Turaco and Myna'
  gem.description = 'ActiveRecord models and specifications for an API project with Kafka workers'

  gem.authors  = ['David Stancu', 'Paulina Levit']
  gem.email    = 'dstancu@nyu.edu'
  gem.homepage = 'http://github.com/birdfeed/kagu'

  gem.add_dependency('activerecord')
  gem.add_dependency('activesupport')
  gem.add_dependency('aws-sdk')
  gem.add_dependency('devise', '4.2.1')
  gem.add_dependency('elasticsearch-model')
  gem.add_dependency('pg')
  gem.add_dependency('rake')

  gem.add_development_dependency('codeclimate-test-reporter')
  gem.add_development_dependency('database_cleaner')
  gem.add_development_dependency('factory_girl')
  gem.add_development_dependency('guard')
  gem.add_development_dependency('guard-rspec')
  gem.add_development_dependency('guard-rubocop')
  gem.add_development_dependency('pry')
  gem.add_development_dependency('pry-byebug')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('rubocop')
  gem.add_development_dependency('simplecov')
  gem.add_development_dependency('standalone_migrations')

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
end
