require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc "Build Docco Docs"
task :docco do
  `docco lib/**/*.rb`
end

require 'fileutils'
desc "copy the mashed.html to index.html"
task :copy_to_index do
  `cp docs/mashed.html docs/index.html`
end

task :docs => [:docco, :copy_to_index]
