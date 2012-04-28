module PlanetDefense
  class AltProjectile < Chingu::GameObject
    has_traits :collision_detection, :velocity
    attr_reader :owner, :bounding_box
    @@red = Gosu::Color.new(255, 255, 0, 0)
    @@white = Gosu::Color.new(255, 255, 255, 255)
    has_trait :collision_detection
    @@size = 1
    def initialize( options )
      super
      @updates = 0.0
      @owner = options[:owner] || nil    
      @velocity = options[:velocity]
      @x_coeff = options[:x_coeff]
      @y_coeff = options[:y_coeff]
      @x = options[:x]
      @y = options[:y]
      @vel_y = 5
      @bounding_box = Chingu::Rect.new([options[:x], options[:y]-40, 3,3])
      @length = 5
      @@size = @@size + 1

      @anim = $window.media_loader.weapon[:alt_laser_anim].new_from_frames(0..3)
      @image = @anim.next
      self.factor = $window.object_factor
      @angle = Gosu::angle(0,0,@velocity_x,@velocity_y)
    end
  
    def on_collision(object = nil)    
      destroy
    end
  
    def x
      @x  
    end
  
    def y
      @y
    end
  
    def size
      @@size
    end

    def update   
      @updates += 0.1
      @bounding_box.x = @x
      @bounding_box.y = @y

      #if @function == "sin"
       # @x += (Math.sin(@updates) * 20 * @coefficient)
       # puts "Updated: #{@coefficient} * #{@function}"
      #elsif @function == "cos"
      #  @x -= (Math.sin(@updates) * 20 * @coefficient)
      #  puts "Updated: #{@coefficient} * #{@function}"
      #end

      @x += 1 / @updates * @x_coeff

      @y -= @vel_y * (0.5 + @y_coeff)
      @image = @anim.next
    
      #PlayState.asteroids.each{|asteroid| puts asteroid.class unless asteroid == nil }
    
      if ($window.current_game_state.to_s == "PlanetDefense::PlayState")
        if self.hit? PlayState.asteroids
          PlayState.up_score
          self.destroy
        end
      end
      #destroy if outside_window?
      if @y < 50
        destroy
      end
    end
  
    def hit?(asteroids)
     asteroids.any? do |asteroid|
       unless asteroid == nil
         if Gosu::distance(@x, @y, asteroid.x, asteroid.y) <= 55
          asteroid.on_collision
          return true #Laser can only hit 1 asteroid, so leave loop after a collision
         end
      end  
     end
    end
  end
end