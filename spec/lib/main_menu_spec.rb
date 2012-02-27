require 'spec_helper'

module PlanetDefense
  describe MenuState do
  
    before :all do
      @g = PlanetDefense::GameWindow.new
    end
    
    after :all do
      @g.close
    end
    
    it 'should be correct gamestate' do
      $window.current_game_state.should be_kind_of(PlanetDefense::MenuState)
    end

    it 'should return to main menu when "Back" is selected' do
      @g.push_game_state(OptionsState)
      @cs.move_down
      @cs.move_down
      @cs.go
      $window.current_game_state.should be_kind_of(PlanetDefense::MenuState)
    end

  end
end