require 'spec_helper'

module PlanetDefense
  describe Player do
  
    before(:all) do
      @g = PlanetDefense::GameWindow.new
    end
    
    after(:all) do
      @g.close
    end
    
  end
end