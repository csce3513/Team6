module PlanetDefense
	class Explosion < Chingu::GameObject
		
		def initialize(window)
			@screenWidth = $window.width
			@screenHeight = $window.height
			
			@options = { :loop => false, :file => "media/gfx/explosion_strip.png", :width => 50, :heigth => 100 }
			@explosion = Chingu::Animation.new( @options )
		end
		
		def run(x, y)
			@explosion.next!
			#@explosion.image(
		end
	end
end