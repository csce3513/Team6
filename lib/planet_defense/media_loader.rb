#Used to load images and sound once, then use the object instead of reloading every time.

module PlanetDefense
  attr_reader :medialoader
  class MediaLoader

    attr_accessor :asteroid

    def initialize()
      load_asteroid
      load_laser
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
    		:y => 
    			1, 
    	}
 
    	true
    end

    def load_laser
    end

    def load_ship
    end

    def load_game
    end
    
    

  end
end