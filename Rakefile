# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

task test: %i[rubocop spec]
task default: :test

desc 'Rubocop'
task :rubocop do
  RuboCop::RakeTask.new
end

desc 'Test'
Rake::TestTask.new do |task|
  task.libs << 'lib'
  task.libs << 'test'
  task.test_files = FileList['test/*_test.rb']
end

desc 'Spec'
RSpec::Core::RakeTask.new('spec') do |task|
  task.pattern = 'spec/**/*_spec.rb'
end

desc 'Yard'
YARD::Rake::YardocTask.new(:doc) do |task|
  task.files   = %w[lib/**/*.rb - README.md]
  task.options = %w[no-private]
end
