# -*- encoding: utf-8 -*-
require File.expand_path('../lib/eloquent/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Greg Furmanek"]
  gem.email         = ["greg.furmanek@gmail.com"]
  gem.description   = <<-EOD.gsub(/^    /, '')
    Static blog generator
  EOD
  gem.summary       = <<-EOD.gsub(/^    /, '')
    Static blog generator
  EOD
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "eloquent"
  gem.require_paths = ["lib"]
  gem.version       = Eloquent::VERSION

  gem.add_dependency 'rdiscount'
  gem.add_dependency 'haml'
  gem.add_dependency 'sass'

  #gem.add_development_dependency 'rspec'
  #gem.add_development_dependency 'guard-rspec'
  
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'm'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'minitest-matchers'
  gem.add_development_dependency 'guard-minitest'
end
