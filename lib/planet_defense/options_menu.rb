module PlanetDefense
  class OptionsState < Chingu::GameState
    
    def initialize(options = {})
      super

      @options = [:difficulty, :volume, :back]
      @difficulties = [:easy, :medium, :hard]
      @current = 0
      @currentDifficulty = 0
      @selected = Color.new(150,220,69,82)
      @diffSelect = Color.new(150,220,69,82)
      @font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 43)
      @background_image = Gosu::Image.new($window, "media/gfx/space.jpg", true)
      @title_image = Gosu::Image.new($window, "media/gfx/title.png", true)

      self.input = { 
        :up => :move_up,
        :down => :move_down,
        :left => :move_left,
        :right => :move_right,
        :space => :go,
        :enter => :go,
        :return => :go
      }
          
    end
    
    def setup
      @game_objects.destroy_all

    end
    
      
    def move_up
      @current -= 1
      @current = @options.length-1 if @current < 0
    end
    
    def move_down
      @current += 1
      @current = 0 if @current >= @options.length
    end

    def move_left
      if @current == 0
        @currentDifficulty -= 1
        @currentDifficulty = @difficulties.length-1 if @currentDifficulty < 0
      end
    end

    def move_right
      if @current == 0
        @currentDifficulty += 1
        @currentDifficulty = 0 if @currentDifficulty >= @difficulties.length
      end
    end

    def go
      met = "on_" + @options[@current].to_s
      self.send(met)
    end

    def update
      super
      
    end
    
    def draw
      super
      
      
      @background_image.draw(0,0,0)
      @title_image.draw(($window.width/2)-@title_image.width/2,100,50)

      @options.each_with_index do |option, i|
        y = 380+(i*40)
        if i == @current
          #draw_quad(x1, y1, c1, x2, y2, c2, x3, y3, c3, x4, y4, c4, z = 0, mode = :default)
          $window.draw_quad(0, y+10, @selected, $window.width, y+10, @selected, $window.width, y+40, @selected, 0, y+40, @selected )
        end
        @font.draw(option.to_s.capitalize, ($window.width/2)-@font.text_width(option.to_s.capitalize)/2, y,0)
      end

      @difficulties.each_with_index do |difficulty, j|
        y = 320
        x = 180 + ((j+1) * $window.width/7) 

        if j == @currentDifficulty
          $window.draw_quad(x-5, y+10, @diffSelect, x+@font.text_width(difficulty.to_s.capitalize)+5, y+10, @diffSelect, x+@font.text_width(difficulty.to_s.capitalize)+5, y+40, @diffSelect, x-5, y+40, @diffSelect ) if @current == 0
        end
        @font.draw(difficulty.to_s.capitalize, x, y, 2) if @current == 0
      end

    end
    
    
    # Menu options callbacks:
    
    def on_back
      switch_game_state( MenuState )
    end
    
    def on_difficulty
    end
    
    def on_volume
    end
    
    
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