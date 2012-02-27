require 'spec_helper'

module PlanetDefense
  describe MenuState do
  
    before :each do
      @g = PlanetDefense::GameWindow.new
      @currentState = $window.current_game_state
    end
    
    after :each do
      @g.close
    end
    
    it 'should be correct gamestate' do
      @currentState.should be_kind_of(PlanetDefense::MenuState)
    end

    it 'should go to options screen' do
      @currentState.move_down
      @currentState.go
      $window.current_game_state.should be_kind_of(PlanetDefense::OptionsState)
    end

   it 'should return to main menu when "Back" is selected' do
      @g.push_game_state(OptionsState)
      @currentState.move_down
      @currentState.move_down
      @currentState.go
      $window.current_game_state.should be_kind_of(PlanetDefense::MenuState)
    end


  end
end
