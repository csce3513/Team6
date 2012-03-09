#Used to load images and sound once, then use the object instead of reloading every time.

module PlanetDefense
  attr_reader :medialoader
  class MediaLoader

    attr_accessor :asteroid, :weapon

    def initialize()
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
    		"asteroid1_1" => Gosu::Image.new($window, "media/gfx/asteroid1_1.png"),
    		"asteroid1_2" => Gosu::Image.new($window, "media/gfx/asteroid1_2.png"),
    		"asteroid1_3" => Gosu::Image.new($window, "media/gfx/asteroid1_3.png"),
    		"asteroid2_1" => Gosu::Image.new($window, "media/gfx/asteroid2_1.png"),
    		"asteroid2_2" => Gosu::Image.new($window, "media/gfx/asteroid2_2.png"),
    		"asteroid2_3" => Gosu::Image.new($window, "media/gfx/asteroid2_3.png"),
    		"asteroid3_1" => Gosu::Image.new($window, "media/gfx/asteroid3_1.png"),
    		"asteroid3_2" => Gosu::Image.new($window, "media/gfx/asteroid3_2.png"),
    		"asteroid3_3" => Gosu::Image.new($window, "media/gfx/asteroid3_3.png")
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