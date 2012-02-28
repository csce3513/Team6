module PlanetDefense
  class CreditsState < Chingu::GameState
    
    def initialize(options = {})
      super

      #@options = [ :start, :highscores, :credits, :options, :quit ]
      @options = []
      @current = 0
      @selected = Color.new(150,220,69,82)
      @font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 43)
      @background_image = Gosu::Image.new($window, "media/gfx/space-with-earth.jpg", true)
      @title_image = Gosu::Image.new($window, "media/gfx/title.png", true)
	  @credits_image = Gosu::Image.new($window, "media/gfx/credits.png", true)
      self.input = { 
        :up => :move_up,
        :down => :move_down,
        :space => :go,
        :enter => :go,
        :return => :go
      }
	  @names_height = 0
	  @names_width = 400
      @music = Gosu::Song.new($window, "media/sounds/background.wav")
      @music.volume = 0.3
      @music.play(looping = true) unless @pause == true || defined? RSpec
      $window.caption = "Planet Defense #{PlanetDefense::VERSION}"
      @@asteroids = 20.times.map { Asteroid.new(self) }
    end
    
    def setup
      @game_objects.destroy_all

      # @bg_music = Song["sad robot.ogg"]
      # @bg_music.volume = $settings['music']
      # @bg_music.play(true)
    end
    
      
    def move_up
      @current -= 1
      @current = @options.length-1 if @current < 0
      # Sound["menu_change.wav"].play($settings['sound'])
    end
    
    def move_down
      @current += 1
      @current = 0 if @current >= @options.length
      # Sound["menu_change.wav"].play($settings['sound'])
    end

    def go
      met = "on_" + @options[@current].to_s
      self.send(met)
      # Sound["menu_select.wav"].play($settings['sound'])
    end

    def update
      super
      #Asteroid Movement
      @@asteroids.each{ |asteroid| asteroid.move unless asteroid == nil }
    end
    
    def draw
      super
      #Asteroid Draw
      @@asteroids.each{|asteroid| asteroid.draw unless asteroid == nil }
      @background_image.draw(0,0,0)
	  
	  @names_height > $window.height ? @names_height = 0 : @names_height += 1

      @title_image.draw(($window.width/2)-@title_image.width/2, 100, 50)
	  @credits_image.draw(($window.width/2)-@credits_image.width, $window.height/2, 50)
	  
	  #@font.draw("CREDITS", ($window.width/2)-@font.text_width("CREDITS")/2, 300, 50)
	  
	  @offset = 50
	  
	  @font.draw("By: Addam Hardy", @names_width, @names_height, 0)
	  @font.draw("Michael Gammon", @names_width, @names_height + @offset, 0)
	  @font.draw("Bryan Glazer", @names_width, @names_height + @offset*2, 0)
	  @font.draw("Denton Alford", @names_width, @names_height + @offset*3, 0)
	  @font.draw("Denton Alford", @names_width, @names_height + @offset*4, 0)
    end
    
    
    # Menu options callbacks:
    
    def on_start
      switch_game_state( PlayState )
    end
    
    def on_quit
      self.close
    end
    
    # def on_credits
    #   push_game_state( CreditState )
    # end
    
    # def on_options
    #   push_game_state( OptionState)
    # end
    
    # def on_highscores
    #   push_game_state( HighScoreState )
    # end
    
  end

  class MenuTitleImage < Chingu::GameObject
    has_trait :timer
    
    def initialize(options)
      super
      
      # @image = Image["menu_title.png"]
      # @rotation_center = :center_center
      # @mode = :additive unless options[:silent]
      @color = Color.new(255,255,255,255)
      after(250) { @mode = :default }
      @zorder = 400
      # Sound["explosion.wav"].play($settings['sound']) unless options[:silent]
    end
    
    def draw
      if @mode == :additive
        5.times { super }
      else
        super
      end
    end
  end
end