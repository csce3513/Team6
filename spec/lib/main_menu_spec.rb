require 'spec_helper'

module PlanetDefense
  describe MenuState do
  
    before :each do
      @g = PlanetDefense::GameWindow.new
      @cs = $window.current_game_state
    end
    
    after :each do
      @g.close
    end
    
    it 'should be correct gamestate' do
      @cs.should be_kind_of(PlanetDefense::MenuState)
    end

    it 'should go to options screen' do
      @cs.move_down
      @cs.go
      $window.current_game_state.should be_kind_of(PlanetDefense::OptionsState)
    end

   it 'should return to main menu when "Back" is selected' do
      @g.push_game_state(OptionsState)
      @cs.move_down
      @cs.move_down
      @cs.go
      $window.current_game_state.should be_kind_of(PlanetDefense::MenuState)
    end

    it 'should go to other menu options' do
      @cs.move_down
      @cs.go
      $window.current_game_state.should be_kind_of(PlanetDefense::OptionsState)
    end

  end
end
