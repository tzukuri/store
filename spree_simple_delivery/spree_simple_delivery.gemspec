# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_simple_delivery'
  s.version     = '3.1.4'
  s.summary     = 'Removes the delivery option at checkout but still allows for stock tracking and shipment tracking'
  s.description = 'Removes the delivery option at checkout but still allows for stock tracking and shipment tracking'
  s.required_ruby_version = '>= 2.1.0'

  s.author    = 'Tzukuri'
  s.email     = 'hello@tzukuri.com'
  s.homepage  = 'https://tzukuri.com'
  s.license = 'BSD-3'

  # s.files       = `git ls-files`.split("\n")
  # s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.1.4'

  s.add_development_dependency 'capybara', '~> 2.6'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails', '~> 3.4'
  s.add_development_dependency 'sass-rails', '~> 5.0.0'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end
