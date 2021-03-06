module PlanetDefense
	class Explosion < Chingu::GameObject
    
    def initialize( options )
			super
			@life = 45
			@steps = 0
			@init_x = options[:x]
			@init_y = options[:y]
			@frags = Array.new(3) { |i| $window.media_loader.asteroid["asteroid" + options[:imageNum].to_s + "_" + (i+1).to_s] }

			@anim = $window.media_loader.asteroid[:explosion_anim].new_from_frames(0..45)
			@expl = @anim.next

			@rot = @vel_angular = rand(2) + 1
			@angle = @vel_angular

			@vel_x = Array.new(3) { |vel| vel = rand(rand(9) + 1 ) }
			@vel_y = Array.new(3) { |vel| vel = rand(rand(9) + 1 ) }
			@x = Array.new(3) { @init_x }
			@y = Array.new(3) { @init_y }

			self.factor = $window.object_factor
    end
    
    def update    
			@expl = @anim.next

			@angle += @vel_angular
			3.times{ |i| @x[i] += @vel_x[i]}
			3.times{ |i| @y[i] += @vel_y[i]}

			@steps = @steps+1

			destroy if @steps >= @life
    end
    
		def draw
			@expl.draw(@init_x,@init_y, 5)
			@i = 0

			if (@steps < 25)
				@frags.each do |f| 
					f.draw_rot(@x[@i], @y[@i], 1, @angle)
					@i = @i + 1
				end
			end
		end

		def x
		  @x  
		end

		def y
		  @y
		end

	end
end