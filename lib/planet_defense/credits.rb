module PlanetDefense
  class CreditsState < Chingu::GameState
    attr_reader :title_height, :names_height, :title_image
    
    def initialize(options = {})
      super

      #@options = [ :start, :highscores, :credits, :options, :quit ]
      @options = []
      @current = 0
      @selected = Color.new(150,220,69,82)
      @font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 43)

      @background_image = Gosu::Image.new($window, "media/gfx/space.jpg", true)
      @title_image = Gosu::Image.new($window, "media/gfx/title.png", true)
      @credits_image = Gosu::Image.new($window, "media/gfx/credits.png", true)
      self.input = { 
        :escape => :back
      }
      @title_height = 100
      @names_height = @title_height + @title_image.height + 20
      @names_width = $window.width/2
      @music = Gosu::Song.new($window, "media/sounds/background.wav")
      @music.volume = 0.3
      @music.play(looping = true) unless @pause == true || defined? RSpec
      $window.caption = "Planet Defense #{PlanetDefense::VERSION}"
    end

    def update
      super

    end
    
    def draw
      super
      #Asteroid Draw
      @background_image.draw(0,0,0)

      @names_height > $window.height ? reset : @names_height += 1

      @title_image.draw(($window.width/2)-@title_image.width/2, @title_height, 50)
      @credits_image.draw(($window.width/2)-@credits_image.width, $window.height/2, 50)

      @offset = 50

      @font.draw("Addam Hardy", @names_width, @names_height, 0)
      @font.draw("Michael Gammon", @names_width, @names_height + @offset, 0)
      @font.draw("Bryan Glazer", @names_width, @names_height + @offset*2, 0)
      @font.draw("Denton Alford", @names_width, @names_height + @offset*3, 0)
    end

    # Menu options callbacks:
    
    def back
      pop_game_state()
    end

	 def reset
		@names_height = @title_height + @title_image.height + 20
	 end
	 
    
  end
end