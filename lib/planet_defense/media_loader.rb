#Used to load images and sound once, then use the object instead of reloading every time.
#Instantiated in main as media_loader, so in most classes, so examples to access items in media_loader:
#  $window.media_loader.asteroid[:explosion_anim]
#  @window.media_loader.weapon[:laser_anim]

module PlanetDefense
  attr_reader :media_loader
  class MediaLoader

    attr_accessor :asteroid, :weapon

    def initialize(window)
    	@window = window
      load_asteroid
      load_weapon
      load_ship
      load_game
    end

    def load_asteroid
    	@asteroid = {
    		:explosion_anim => 
    			(Chingu::Animation.new(
    				:loop => false, 
    				:file => "media/gfx/explosion.png", 
    				:size=>[50,50], 
    				:delay => 15
				)
				),
    		"asteroid1_1" => Gosu::Image.new(@window, "media/gfx/asteroid1_1.bmp"),
    		"asteroid1_2" => Gosu::Image.new(@window, "media/gfx/asteroid1_2.bmp"),
    		"asteroid1_3" => Gosu::Image.new(@window, "media/gfx/asteroid1_3.bmp"),
    		"asteroid2_1" => Gosu::Image.new(@window, "media/gfx/asteroid2_1.bmp"),
    		"asteroid2_2" => Gosu::Image.new(@window, "media/gfx/asteroid2_2.bmp"),
    		"asteroid2_3" => Gosu::Image.new(@window, "media/gfx/asteroid2_3.bmp"),
    		"asteroid3_1" => Gosu::Image.new(@window, "media/gfx/asteroid3_1.bmp"),
    		"asteroid3_2" => Gosu::Image.new(@window, "media/gfx/asteroid3_2.bmp"),
    		"asteroid3_3" => Gosu::Image.new(@window, "media/gfx/asteroid3_3.bmp"),
            "asteroid1" => Gosu::Image.new(@window, "media/gfx/asteroid1.bmp"),
            "asteroid2" => Gosu::Image.new(@window, "media/gfx/asteroid2.bmp"),
            "asteroid3" => Gosu::Image.new(@window, "media/gfx/asteroid3.bmp"),
    	}
 
    	true
    end

    def load_weapon
    	@weapon = {
    		:laser_anim => 
    			(Chingu::Animation.new( :file => "media/gfx/laser.png", :size=>[2,8], :delay => 10).retrofy)
    	}
    end

    def load_ship
    end

    def load_game
    end
    
    

  end
end