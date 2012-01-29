class Player
  def initialize(window)
    #Settings for player movement
    @vel_max = 6;
    @acceleration = 0.5;
    @deceleration = 0.95;
    @vel_x = @vel_y = 0.0;
    
    #Getting window dimensions
    @screenWidth = window.width;
    @screenHeight = window.height;
    #Ship initially at bottom center
    @x = @screenWidth / 2;
    @y = @screenHeight - 50;
    
    @image = Gosu::Image.new(window, "gfx/shipNormal.bmp", false);
  end
  
  def move_left
    if (@vel_x.abs < @vel_max)
      @vel_x -= @acceleration;
    end
  end
  
  def move_right
    if (@vel_x.abs < @vel_max)
      @vel_x += @acceleration;
    end
  end
  
  def move_forward
    if (@vel_y.abs < @vel_max)
      @vel_y -= @acceleration;
    end
  end
  
  def move_backward
    if (@vel_y.abs < @vel_max)
      @vel_y += @acceleration;
    end
  end
  
  def move
    #Position
    @x += @vel_x;
    @y += @vel_y;
    
    #Limit x positions
    if (@x < 25)
      @x = 25;
    elsif (@x > @screenWidth - 25)
      @x = @screenWidth - 25;
    end
    
    #Limit y positions
    if (@y < 37)
      @y = 37;
    elsif (@y > @screenHeight - 37)
      @y = @screenHeight - 37;
    end

    #Automatic deceleration
    @vel_x *= @deceleration;
    @vel_y *= @deceleration;
  end
  
  def hit_by?(asteroids)
    asteroids.any? {|asteroid| Gosu::distance(@x, @y, asteroid.x, asteroid.y) <= 55 unless asteroid == nil }
  end
  
  def draw
    @image.draw_rot(@x, @y, 1, 0);
  end
end