module PlanetDefense
  class Player < Chingu::GameObject
    has_traits :collision_detection, :timer, :velocity
    attr_reader :player
    attr_accessor :vel_x, :vel_y, :laser_heat, :cooldown_time, :last_cooldown, :lastShot
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
      @cooldown_time = 15
      @last_cooldown = milliseconds()
      @laser_count = 0
      @laser_heat = 0
      @laser_gauge_color = Gosu::Color::GREEN
      @image = Gosu::Image.new($window, "media/gfx/shipNormal.bmp")  
      @font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 43)
      @particles = Chingu::Animation.new(:file => "media/gfx/fireball.png", :size => [32,32])

    end
  
    def create_particles

      Chingu::Particle.create( :x => @x, 
                              :y => @y+30, 
                              :animation => @particles,
                              :scale_rate => +0.02, 
                              :fade_rate => -20, 
                              :rotation_rate => +10,
                              :mode => :default
                              )
    end


    def move_left
      #create_particles
      if (@vel_x.abs < @vel_max)
        @vel_x -= @acceleration  
      end
    end
  
    def move_right
      #create_particles
      if (@vel_x.abs < @vel_max)
        @vel_x += @acceleration  
      end
    end
  
    def move_forward
      create_particles
      Particle.each { |particle| particle.y += 3; particle.x += 2 - rand(4) }
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

      #If it's been @cooldown_time since last cooldown, cooldown again
      if (@last_cooldown + @cooldown_time < milliseconds())
        cool_down_laser
      end

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
  
      Particle.size
      # Particle.each do |p|
      #   puts "#{p.x} - #{p.y}"
      #   p.destroy if p.outside_window?
      # end

    end
  
    def hit_by?(asteroids)
      asteroids.any? {|asteroid| Gosu::distance(@x, @y, asteroid.x, asteroid.y) <= 55 unless asteroid == nil }
    end
  
    def on_collision(object = nil)
      puts "#{object.class} #{object.x}/#{object.y}"
      puts "#{self.class} #{self.x}/#{self.y}"
    end
  
    def shoot
      #Laser only shoots if reloaded and not overheated
      if ((milliseconds() - @reloadTime) > @lastShot) && !overheated?
        @lastShot = milliseconds()
        PlanetDefense::Laser.create( :x => @x-20, :y => @y-15)
        PlanetDefense::Laser.create( :x => @x+20, :y => @y-15)
        heat_up_laser
        true
      else
        false
      end
    end

    #Checks if the laser is overheated (condition for laser to fire)
    def overheated?
      if (@laser_heat >= 100)
        #Prevents shooting for 1 second if overheated
        @lastShot = milliseconds() + 1000
        @laser_gauge_color = Gosu::Color::RED
        true
      else 
        false
      end
    end


    #Every shot heats up the laser (called in 'shoot')
    def heat_up_laser
      if (@laser_heat < 100)
        @laser_heat += 10
      end
    end

    #Laser cools down continuously (called in 'move', since it is continuously called)
    #Might make more sense to put this in play_state under update, after @player.move
    def cool_down_laser
      @laser_heat -= 1
      if (@laser_heat < 0)
        @laser_heat = 0
      else
        @last_cooldown = milliseconds()
      end
      #Color gauge red -> green
      if (@lastShot <milliseconds())
        @laser_gauge_color = Gosu::Color::GREEN
      end
    end

    def x
     @x  
    end

    def y
     @y
    end
  
    def draw
      @image.draw_rot(@x, @y, 500, 0)  

      @font.draw_rel("LASERS OVERHEATING!", 500, 50, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED) if (@laser_heat >= 85)
    end
  
    def reset
      @x = $window.width / 2  
      @y = $window.height - 50
    end

    def laser_heat
      @laser_heat
    end

    def laser_gauge_color
      @laser_gauge_color
    end
    
  end
end