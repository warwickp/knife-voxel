# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "knife-voxel/version"

Gem::Specification.new do |s|
  s.name        = "knife-voxel"
  s.version     = Knife::Voxel::VERSION
  s.authors     = ["James W. Brinkerhoff"]
  s.email       = ["jwb@voxel.net"]
  s.homepage    = "http://api.voxel.net/"
  s.summary     = "Voxel hAPI Support for Chef's knife command"
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "voxel-hapi"
end
