module PlanetDefense
	class Explosion < Chingu::GameObject
    
    def initialize( options )
			super
			@life = 20
			@steps = 0
			@@init_x = options[:x]
			@@init_y = options[:y]
			@frags = options[:frags]
			@anim = Chingu::Animation.new( :loop => false, :file => "media/gfx/explosion.png", :size=>[50,50], :delay => 10)
			@expl = @anim.next

			@rot = @vel_angular = rand(2) + 1
			@angle = @vel_angular

			@vel_x = Array.new(3) { |vel| vel = rand(rand(9) + 1 ) }
			@vel_y = Array.new(3) { |vel| vel = rand(rand(9) + 1 ) }
			@x = Array.new(3) { @@init_x }
			@y = Array.new(3) { @@init_y }

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
		@expl.draw(@@init_x,@@init_y, 1)
		@i = 0
		@frags.each do
		|f| f.draw_rot(@x[@i], @y[@i], 1, @angle)
		@i = @i + 1
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