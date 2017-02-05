require File.expand_path("../lib/kagu", __FILE__)

Gem::Specification.new do |gem|
  gem.name    = 'kagu'
  gem.version = Kagu::VERSION
  gem.date    = Date.today.to_s

  gem.summary = "Models for Turaco and Myna"
  gem.description = "ActiveRecord models and specifications for an API project with Kafka workers"

  gem.authors  = ['David Stancu', 'Paulina Levit']
  gem.email    = 'dstancu@nyu.edu'
  gem.homepage = 'http://github.com/birdfeed/kagu'

  gem.add_dependency('rake')
  gem.add_dependency('activerecord')
  gem.add_dependency('activesupport')
  gem.add_development_dependency('rspec')

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
end