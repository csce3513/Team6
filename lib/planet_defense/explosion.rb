module PlanetDefense
  class Explosion < Chingu::GameObject
    
    def initialize( options, frags )
      super
      @x = options[:x]
      @y = options[:y]
		
		
      @anim = Chingu::Animation.new( :loop => false, :file => "media/gfx/explosion_strip.png", :size=>[29,62], :delay => 1).retrofy
      @image = @anim.next
		
      self.factor = $window.object_factor
    end
    
    def update    
      @image = @anim.next
    
      destroy if outside_window?
    end
    
	 def draw
		@image.draw(@x,@y, 1)
		#3.times( @frags.draw(@x, @y
	 end
	 
	 def x
      @x  
    end
  
    def y
      @y
    end
  end
end