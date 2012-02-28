require_relative '../spec_helper'

module PlanetDefense
  describe GameState do
  
    before :all do
      @g = PlanetDefense::GameWindow.new
    end
    
    after :all do
      @g.close
    end
    
    it 'should be correct gamestate' do
      $window.current_game_state.should be_kind_of(PlanetDefense::GameState)
    end
	
	context "when initialized" do
      it 'should appear below title' do
        @g.title_height.should == 189990
      end
    end

  end
end