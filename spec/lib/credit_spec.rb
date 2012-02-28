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
      it 'should have title at proper place' do
        $window.current_game_state.title_height.should == 100
      end
	  
	  it 'should appear below title' do
	  	$window.current_game_state.names_height.should == $window.current_game_state.title_height + $window.current_game_state.title_image.height + 20
	  end
    end
	
	context "after scrolling" do
	   it 'should have scrolled down' do
			20.times do
			  $window.current_game_state.draw
			end
			
  	      $window.current_game_state.names_height.should > 100
		end
	end
	
	context "reset to top" do
		it 'should reset names to below title' do
			@start_height = $window.current_game_state.title_height + $window.current_game_state.title_image.height + 20
			
			$window.current_game_state.reset
			
			$window.current_game_state.names_height.should == @start_height
		end
	end
	end
end