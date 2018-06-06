# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'harvest/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'harvested2'
  s.version     = Harvest::VERSION
  s.summary     = 'A Ruby Wrapper for the Harvest API http://www.getharvest.com/ V2'
  s.description = 'Harvested wraps the Harvest API concisely without the use of Rails dependencies. More information about the Harvest API can be found on their website (http://www.getharvest.com/api). For support hit up the Mailing List (http://groups.google.com/group/harvested)'

  s.authors  = ['Zach Moazeni', 'Jonathan Tapia']
  s.email    = ['zach.moazeni@gmail.com', 'jonathan.tapia@magmalabs.io']
  s.homepage = 'http://github.com/jtapia/harvested2'
  s.license  = 'MIT'

  s.require_path = 'lib'
  s.requirements << 'none'
  s.files = `git ls-files -z`.split("\x0")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  s.required_ruby_version     = '>= 2.2'
  s.required_rubygems_version = '>= 1.3.6'

  s.add_runtime_dependency('httparty')
  s.add_runtime_dependency('hashie')
  s.add_runtime_dependency('json')
end
