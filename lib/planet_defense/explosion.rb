module PlanetDefense
	class Explosion < Chingu::GameObject
		
		def initialize(options)
			super
			@x = options[:x]
			@y = options[:y]
			
			@anim_options = { :loop => true, :file => "media/gfx/explosion_strip.png", :width => 50, :height => 100, :delay => 10}
			@anim = Chingu::Animation.new( @anim_options )
			puts( @anim )
			@image = @anim.first
			puts( @anim.index )
		end
		
		def update
			@image = @anim.next
			
		end
		
		def draw
			@image.draw(@x, @y)
		end
	end
end