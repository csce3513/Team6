module PlanetDefense
	class Explosion < Chingu::GameObject
		
		def initialize(options)
			@x = options[:x]
			@y = options[:y]
			
			@anim_options = { :loop => false, :file => "media/gfx/explosion_strip.png", :width => 50, :height => 100 }
			@explosion_anim = Chingu::Animation.new( @anim_options )
			@explosion_anim.next!
			@image = @explosion_anim.image	
			puts("initialize");
		end
		
		def update
			@explosion_anim.next!
			@image = @explosion_anim.image
			puts("update")
		end
		
		def draw
			puts("draw")
		end
	end
end