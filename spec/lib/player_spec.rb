require 'spec_helper'

require_relative '../../lib/planet_defense/player'
require_relative '../../lib/planet_defense/play_state'
require_relative '../../lib/planet_defense/main'

module PlanetDefense
  describe Player do
  
    before(:all) do
      @g = PlanetDefense::GameWindow.new
      @player = Player.new(@g) 
    end
    
    after(:all) do
      @g.close
    end
    
    it 'Player should be at bottom middle of screen on init' do
      @player.x.should == $window.width / 2  
      @player.y.should == $window.height - 50
    end
    
  end
end