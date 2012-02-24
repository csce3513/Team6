module PlanetDefense
  class MenuState < Chingu::GameState
    
    def initialize(options = {})
      super

      #@options = [ :start, :highscores, :credits, :options, :quit ]
      @options = [ :start, :options, :credits, :quit ]
      @current = 0
      @selected = Color.new(150,220,69,82)
      @font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 43)
      @background_image = Gosu::Image.new($window, "media/gfx/space.jpg", true)
      @title_image = Gosu::Image.new($window, "media/gfx/title.png", true)
      self.input = { 
        :up => :move_up,
        :down => :move_down,
        :space => :go,
        :enter => :go,
        :return => :go
      }
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
      @@asteroids.length.times{|i|
          if (@@asteroids[i] != nil)
            if (@@asteroids[i].y > $window.height)
              @@asteroids[i].reset 
            end
          end
        }
    end
    
    def draw
      super
      #Asteroid Draw
      @@asteroids.each{|asteroid| asteroid.draw unless asteroid == nil }
      @background_image.draw(0,0,0)

      @title_image.draw(($window.width/2)-@title_image.width/2,100,50)

      @options.each_with_index do |option, i|
        y = 380+(i*40)
        if i == @current
          #draw_quad(x1, y1, c1, x2, y2, c2, x3, y3, c3, x4, y4, c4, z = 0, mode = :default)
          $window.draw_quad(0, y+10, @selected, $window.width, y+10, @selected, $window.width, y+40, @selected, 0, y+40, @selected, 50 )
        end
        @font.draw(option.to_s.capitalize, ($window.width/2)-@font.text_width(option.to_s.capitalize)/2, y,50)
      end
    end
    
    
    # Menu options callbacks:
    
    def on_start
      switch_game_state( PlayState )
    end
    
    def on_quit
      pop_game_state()
      self.close
    end
    
    def on_credits
      push_game_state( CreditsState )
    end
    
    def on_options
      push_game_state( OptionsState )
    end
    
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