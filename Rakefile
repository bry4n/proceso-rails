require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rubygems/package_task'
require 'rspec/core/rake_task'
require 'rake/clean'

gem_spec = Gem::Specification.load("proceso-rails.gemspec")

Gem::PackageTask.new(gem_spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

RSpec::Core::RakeTask.new(:spec)

task :build => :clean
task :default => [:build, :spec]
