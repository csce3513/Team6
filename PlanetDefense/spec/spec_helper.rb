require 'rspec'
require 'rubygems'
require 'gosu'
require 'chingu'

RSpec.configure do |c|
  c.mock_with :rspec
end

Dir['./../lib/*.rb'].map {|f| require f}


