require "chingu"

class Asteroid < Chingu::GameObject
  def initialize(window)    
    
    #Getting window dimensions
    @screenWidth = $window.width  
    @screenHeight = $window.height  
    
    #Give asteroid random image
    @imageNum = rand(3) + 1  
    @image = Gosu::Image.new($window, "gfx/asteroid" + @imageNum.to_s() + ".bmp", false)  
    
    #Asteroids start at top, with random x and angle
    @x = rand(@screenWidth * 1.5) - (@screenWidth * 0.25)  
    @y = -50  
    @angle = rand(360)  
    @vel_angular = rand(2) + 1  
    #vel_y can be positive (down only)
    @vel_x = @vel_y = rand(9) + 1  
    #vel_x can be positive or negative (left or right)
    if (rand(2) == 1)
      @vel_x *= -0.15  
    end
    #vel_angular can be positive or negative (left or right spin)
    if (rand(2) == 1)
      @vel_angular *= -1  
    end
  end
  
  def on_collision(object = nil)    
    destroy
  end
  
  def hit_by?(objects)
    $window.game_objects.any? {|obj| Gosu::distance(@x, @y, obj.x, obj.y) <= 55 unless obj == nil }
  end
  
  def move
    @x += @vel_x  
    @y += @vel_y  
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
