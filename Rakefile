$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'
require 'rspec/core/rake_task'
# require "zeitwerk"
# loader = Zeitwerk::Loader.for_gem
# loader.setup
require "helper"
# puts Helper::BASE_URL

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
