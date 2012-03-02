module PlanetDefense
  class Explosion < Chingu::GameObject
    
    def initialize( options )
      super
      @x = options[:x]
      @y = options[:y]

      @anim = Chingu::Animation.new( :file => "media/gfx/explosion_strip.png", :size=>[50,100], :delay => 10).retrofy
      @image = @anim.next
      self.factor = $window.object_factor
    end
  
    def x
      @x  
    end
  
    def y
      @y
    end
  
    def update    
      @image = @anim.next
    
      #PlayState.asteroids.each{|asteroid| puts asteroid.class unless asteroid == nil }
      destroy if outside_window?
    end
    
	 def draw
		@image.draw(@x,@y)
	 end
  end
end