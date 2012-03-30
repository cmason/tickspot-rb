# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tickspot/version"

Gem::Specification.new do |s|
  s.name        = "tickspot-rb"
  s.version     = Tickspot::VERSION
  s.authors     = ["Chris Mason"]
  s.email       = ["chris@chaione.com"]
  s.homepage    = "https://github.com/cmason/tickspot-rb"
  s.description = %q{Ruby wrapper for the Tick API  http://tickspot.com/api}
  s.summary     = s.description

  s.rubyforge_project = "tickspot-rb"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  # specify any dependencies here; for example:
  s.add_runtime_dependency 'hashie'
  s.add_runtime_dependency 'httparty'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
end
