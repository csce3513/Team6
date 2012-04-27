module PlanetDefense
  class PowerUp < Chingu::GameObject
	 attr_accessor :vel_x, :vel_y, :frags
	 
    def initialize(window, player)    
      #Getting window dimensions
      @screenWidth = $window.width  
      @screenHeight = $window.height  
      @player = player
      #Give asteroid random image
      @type = rand(2) + 1
      puts "made type #{@type}"
      @anim = $window.media_loader.powerup["powerup_" + @type.to_s].new_from_frames(0..3)
      @image = @anim.next

      #Asteroids start at top, with random x and angle
      @x = rand(@screenWidth * 1.5) - (@screenWidth * 0.25)  
      @y = -50  
      @angle = rand(360)  
      @vel_angular = rand(2) + 1  

      @vel_x = rand(3)+1
      @vel_y = rand(3)+1
      if (rand(2) == 1)
        @vel_x *= -1
      end
      if (rand(2) == 1)
        @vel_y *= -1
      end

      #vel_angular can be positive or negative (left or right spin)
      if (rand(2) == 1)
        @vel_angular *= -1  
      end
    end

    def on_collision   
      #puts "#{self.class} #{self.x}/#{self.y}"

		  #self.reset
      # PlayState.asteroids.delete self
      # PlayState.asteroids.push( Asteroid.new($window) )
    end
  
    def move
      @image = @anim.next
      @x += @vel_x  
      @y += @vel_y

      if ((@x - @player.x).abs < 40) and ((@y - @player.y).abs < 50)
        #Effect goes here
        if (@type == 1)
          @player.weapon.heat = @player.weapon.heat - 30
        elsif (@type == 2)
          @player.weapon.alt_shot_count = @player.weapon.alt_shot_count + 1
        end
        initialize($window, @player)
      end

      if (@x < 0) or (@x > 1024)
        @vel_x = @vel_x * -1
        if (@x < 0)
          @x = 0
        else
          @x = 1024
        end
      end

      if (@y < 0) or (@y > 768)
        @vel_y = @vel_y * -1
        if (@y < 0)
          @y = 0
        else
          @y = 768
        end
      end

      @angle += @vel_angular  
    
    end
  
    def draw
      @image.draw_rot(@x, @y, 1, @angle)
    end
  
    def x
      @x  
    end
  
    def y
      @y
    end
  
    def reset
      @y = 0
      @x = rand(@screenWidth)
    end
  end
end
