module PlanetDefense
	class Explosion < Chingu::GameObject
		
		def initialize(window)
			@screenWidth = $window.width
			@screenHeight = $window.height
			
			@options = { :loop => false, :file => "media/gfx/explosion_strip.png", :width => 50, :height => 100 }
			@explosion_anim = Chingu::Animation.new( @options )
		end
		
		def run(x, y)
			@explosion_anim.next!
			@explosion_anim.image.draw(@x,@y)
		end
	end
end