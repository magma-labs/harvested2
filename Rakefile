require 'rubygems'
require 'rake'
require "bundler/setup"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "harvested"
    gem.summary = %Q{A Ruby Wrapper for the Harvest API http://www.getharvest.com/}
    gem.description = %Q{Harvested wraps the Harvest API concisely without the use of Rails dependencies. More information about the Harvest API can be found on their website (http://www.getharvest.com/api). For support hit up the Mailing List (http://groups.google.com/group/harvested)}
    gem.email = "zach.moazeni@gmail.com"
    gem.homepage = "http://github.com/zmoazeni/harvested"
    gem.authors = ["Zach Moazeni"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError => e
  p e
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => %w(spec features)

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

desc 'Removes all data on harvest'
task 'clean_remote' do
  require 'harvested'
  require "spec/support/harvested_helpers"
  HarvestedHelpers.clean_remote
end