require 'simplecov'
SimpleCov.start

require 'rspec'
require 'rubygems'
require 'gosu'
require 'chingu'

RSpec.configure do |c|
  c.mock_with :rspec
  # Use color in STDOUT
  c.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  c.tty = true

  # Use the specified formatter
  c.formatter = :progress # :progress, :html, :textmate
end

$: << './lib'

Dir['./../lib/planet_defense/*.rb'].map {|f| require f}


