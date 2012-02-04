if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start
end


require 'rubygems' unless RUBY_VERSION =~ /1\.9/
require 'bundler/setup'
require 'gosu'
require 'chingu'
require 'rspec'

RSpec.configure do |c|
  c.color_enabled = true
  c.tty = true
  c.formatter = :documentation
end

require_relative '../lib/planet_defense/main'


