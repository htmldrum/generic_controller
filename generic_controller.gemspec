# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "generic_controller/version"

Gem::Specification.new do |s|
  s.name        = "generic_controller"
  s.version     = GenericController::VERSION
  s.authors     = ["James Meldrum"]
  s.email       = ["htmldrum@tutanota.com"]
  s.homepage    = "https://github.com/htmldrum/generic_controller"
  s.summary     = %q{ActionController subclass with conveience}
  s.description = %q{An opinionated generic resource-oriented controller for rails.}

  s.rubyforge_project = "generic_controller"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec'
  s.add_runtime_dependency 'rails'
end
