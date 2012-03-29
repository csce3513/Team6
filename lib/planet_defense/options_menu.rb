module PlanetDefense
  class OptionsState < Chingu::GameState
    
    def initialize(options = {})
      super

      @options = [:difficulty, :volume, :back]
      @difficulties = [:easy, :medium, :hard]
      @current = 0
      @currentDifficulty = 0
      @volume = 10
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

      if @current == 1
        @volume -= 1
        @volume == 0 if @volume < 0
      end
    end

    def move_right
      if @current == 0
        @currentDifficulty += 1
        @currentDifficulty = 0 if @currentDifficulty >= @difficulties.length
      end

      if @current == 1
        @volume += 1
        @volume = 10 if @volume > 10
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

      y = 320
      x = $window.width / 2 - (@font.text_width("Medium") / 2)
      @font.draw("Easy", x - 150, y, 2) if @current == 0
      @font.draw("Medium", x, y, 2) if @current == 0
      @font.draw("Hard", x + 200 , y, 2) if @current == 0

      #Draw Volume bar when "Volume" is selected
      j = 0
      x_volume = $window.width/2 - 180
      if @current == 1
        while j <= @volume do
          $window.draw_quad(x_volume + 30*j, (y+10)+(3*(10-j)), @selected, x_volume + 30*j + 30, (y+10)+(3*(10-j)), @selected, x_volume + 30*j, y+40, @selected, x_volume + 30*j + 30, y+40, @selected, z = 0, mode = :default)
          j += 1
        end
      end

      case @currentDifficulty
        when 0
          #Easy
          $window.options.easy
            new_x = (x-150)-5
            $window.draw_quad(new_x, y+10, @diffSelect, new_x+@font.text_width("Easy")+10, y+10, @diffSelect, new_x, y+40, @diffSelect, new_x+@font.text_width("Easy")+10, y+40, @diffSelect ) if @current == 0
        when 1
          #Medium
          $window.options.medium
            $window.draw_quad(x-5, y+10, @diffSelect, x+@font.text_width("Medium")+5, y+10, @diffSelect, x-5, y+40, @diffSelect, x+@font.text_width("Medium")+5, y+40, @diffSelect ) if @current == 0
        when 2
          #Hard
          $window.options.hard
            new_x = (x+200)-5
            $window.draw_quad(new_x, y+10, @diffSelect, new_x+@font.text_width("Hard")+10, y+10, @diffSelect, new_x, y+40, @diffSelect, new_x+@font.text_width("Hard")+10, y+40, @diffSelect ) if @current == 0
        else
      end

      # @difficulties.each_with_index do |difficulty, j|
      #   
        
      # end

    end
    
    
    # Menu options callbacks:
    
    def on_back
      pop_game_state()
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