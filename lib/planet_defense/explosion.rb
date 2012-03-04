module PlanetDefense
  class Explosion < Chingu::GameObject
    
    def initialize( options, frags )
      super
      @x = options[:x]
      @y = options[:y]
		@frags = options[:frags]
      @anim = Chingu::Animation.new( :loop => false, :file => "media/gfx/explosion_strip.png", :size=>[29,62], :delay => 1).retrofy
      @image = @anim.next
		
		@rot = @vel_angular = rand(2) + 1
		@vel_x = Array.new(3) { |vel| vel = rand(rand(9) + 1 )
		@vel_y = Array.new(3) { |vel| vel = rand(rand(9) + 1 )
		
      self.factor = $window.object_factor
    end
    
    def update    
      @image = @anim.next
    
      destroy if outside_window?
    end
    
	 def draw
		@image.draw(@x,@y, 1)
		@frags.each{ |frag| frag.draw
	 end
	 
	 def x
      @x  
    end
  
    def y
      @y
    end
  end
end