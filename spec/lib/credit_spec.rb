require_relative '../spec_helper'

module PlanetDefense
  describe GameState do
  
    before :all do
      @g = PlanetDefense::GameWindow.new
      @cs = $window.current_game_state
    end
    
    after :all do
      @g.close
    end
    
    it 'should be able to enter CreditsState from MenuState' do
      @cs.move_down
      @cs.move_down
      @cs.go
      $window.current_game_state.should be_kind_of(PlanetDefense::CreditsState)
    end
	
	context "when initialized" do
      it 'should appear below title' do
        $window.current_game_state.title_height.should == 100
      end
    end

  end
end