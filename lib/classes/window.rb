require "classes/player"
require "classes/asteroid"

class Window < Gosu::Window

  def initialize
    @screenWidth = 800;
    @screenHeight = 600;
    super(@screenWidth, @screenHeight, false);
    self.caption = "Test";
    @background_image = Gosu::Image.new(self, "gfx/space-crown-nebula.jpg", true);
    @player = Player.new(self);
    @asteroids = Array.new(25);
    @count = 0;
  end
  def update
    
    #Asteroid Movement
    @asteroids.each{|asteroid|
      if asteroid != nil
        asteroid.move;
      end
    }
    #Player Movement
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.move_left;
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.move_right;
    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @player.move_forward;
    end
    if button_down? Gosu::KbDown or button_down? Gosu::GpDown then
    @player.move_backward;
    end
    
    @player.move;
    
    #Add an asteroid and check for clean up every 100 counts
    @count = (@count + 1) % 25;
    if (@count == 0)
      #Add asteroid to first nil in array
      @asteroids.length.times{|i|
        if (@asteroids[i] == nil)
           @asteroids[i] = Asteroid.new(self);
           break;
        end
      }
      #Clean up asteroids off the screen
      @asteroids.length.times{|i|
      if (@asteroids[i] != nil)
        if (@asteroids[i].getY > @screenHeight)
          @asteroids[i] = nil;
        end
      end
    }
    end

    
    
    
    
    
  end
  
  def draw
    @background_image.draw(0,0,0);
    @player.draw;
    
    #Asteroid Draw
    @asteroids.each{|asteroid|
      if asteroid != nil
        asteroid.draw;
      end
    }
  end
  
  def width
    return @screenWidth;
  end
  
  def height
    return @screenHeight;
  end
  
end
