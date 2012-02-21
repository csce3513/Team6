module PlanetDefense
  class Player < Chingu::GameObject
    has_traits :collision_detection, :timer, :velocity
    attr_reader :player
    attr_accessor :vel_x, :vel_y
    has_trait :bounding_box
  
    def initialize( options = {} )
    
      #Settings for player movement
      @vel_max = 7  
      @acceleration = 1  
      @deceleration = 0.95  
      @vel_x = @vel_y = 0.0  
      @x = $window.width / 2  
      @y = $window.height - 50
      @lastShot = milliseconds()
      @reloadTime = 100 #In milliseconds
      @laser_count = 0
      @cooling_down = false
      @image = Gosu::Image.new($window, "media/gfx/shipNormal.bmp")  
      @font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 43)
    end
  
    def move_left
      if (@vel_x.abs < @vel_max)
        @vel_x -= @acceleration  
      end
    end
  
    def move_right
      if (@vel_x.abs < @vel_max)
        @vel_x += @acceleration  
      end
    end
  
    def move_forward
      if (@vel_y.abs < @vel_max)
        @vel_y -= @acceleration  
      end
    end
  
    def move_backward
      if (@vel_y.abs < @vel_max)
        @vel_y += @acceleration  
      end
    end

    def move
      #Position
      @x += @vel_x  
      @y += @vel_y  
    
      #Limit x positions
      if (@x < 25)
        @x = 25  
      elsif (@x > $window.width - 25)
        @x = $window.width - 25  
      end
    
      #Limit y positions
      if (@y < 37)
        @y = 37  
      elsif (@y > $window.height - 37)
        @y = $window.height - 37  
      end

      #Automatic deceleration
      @vel_x *= @deceleration  
      @vel_y *= @deceleration  
    
      move_left if $window.button_down?(Gosu::KbLeft) or $window.button_down?(Gosu::GpLeft)
      move_right if $window.button_down?(Gosu::KbRight) or $window.button_down?(Gosu::GpRight)
      move_forward if $window.button_down?(Gosu::KbUp) or $window.button_down?(Gosu::GpUp)
      move_backward if $window.button_down?(Gosu::KbDown) or $window.button_down?(Gosu::GpDown)
    
      shoot if $window.button_down?(Gosu::KbSpace) or $window.button_down?(Gosu::GpButton0)
     
    end
  
    def hit_by?(asteroids)
      asteroids.any? {|asteroid| Gosu::distance(@x, @y, asteroid.x, asteroid.y) <= 55 unless asteroid == nil }
    end
  
    def on_collision(object = nil)
      puts "#{object.class} #{object.x}/#{object.y}"
      puts "#{self.class} #{self.x}/#{self.y}"
    end
  
    def shoot
      cooling_down?

      if (milliseconds() - @reloadTime) > @lastShot && @cooling_down == false
        @lastShot = milliseconds()
        Laser.create( :x => @x-20, :y => @y-15)
        Laser.create( :x => @x+20, :y => @y-15)
        @laser_count += 1
        if @laser_count == 20
          @cooling_down = true
        end
      end
    end

    def cooling_down?
      if (milliseconds() - 1500) > @lastShot
        @cooling_down = false
        @laser_count = 0
      end
    end

    def x
     @x  
    end

    def y
     @y
    end
  
    def draw
      @image.draw_rot(@x, @y, 1, 0)  
      @font.draw_rel("LASERS ARE RECHARGING!", 500, 50, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED) if @cooling_down
    end
  
    def reset
      @x = $window.width / 2  
      @y = $window.height - 50
    end
    
  end
end