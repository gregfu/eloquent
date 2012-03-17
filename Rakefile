#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rspec/core/rake_task"


RSpec::Core::RakeTask.new('spec')

desc "Generates code coverage report"
task :coverage do
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
    add_filter "/tmp/"
  end
  Rake::Task["spec"].invoke
end

task :default => [:spec]
