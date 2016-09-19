# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "generic_controller"
  s.version     = "0.0.2"
  s.authors     = ["James Meldrum"]
  s.email       = ["htmldrum@tutanota.com"]
  s.homepage    = "https://github.com/htmldrum/generic_controller"
  s.summary     = %q{ActionController subclass with conveience}
  s.description = %q{An opinionated generic resource-oriented controller for rails.}
  s.license = "MIT"
  s.rubyforge_project = "generic_controller"

  s.files         =  Dir['lib/**/*.rb']
  s.files         += Dir['spec/**/*.rb']
  s.require_paths = ["lib"]

  s.add_dependency 'rails', '>= 4.0'
  s.add_dependency 'actionpack'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-rails'
end
