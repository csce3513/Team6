class GameOver < Chingu::GameState
  def initialize(options = {})
    super
    self.input = { :r => :replay }
    @font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 45)
    @font2 = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 25)
    Sound["media/sounds/game_over.wav"].play(0.5)
  end
          
  def draw
     super
     @font.draw_rel("GAME OVER", $window.width / 2, $window.height / 2, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED)
     @font2.draw_rel("- Press R to restart the game - ", $window.width / 2, ($window.height / 2) + 45, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED)
  end
   
  def replay
    pop_game_state()
    push_game_state( PlayState )
    # if $window.scores.position_by_score($last_score)
    #   push_game_state( EnterNameState )
    # else
    #   push_game_state( HighScoreState )
    # end
  end
  
end