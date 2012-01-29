class Laser < Chingu::GameObject
  has_traits :collision_detection, :velocity
  attr_reader :owner, :bounding_box
  
  def initialize( options )
    super 
    @owner = options[:owner] || nil    
    @velocity = 10
    @speed = 4.0
    @bounding_box = Chingu::Rect.new([options[:x], options[:y], 3,3])
    @velocity_x, @velocity_y = @velocity
    @x = options[:x]
    @y = options[:y]
    @velocity_x = 40
    @velocity_y = 40
    Sound["sounds/laser.wav"].play(0.2)

    @velocity_x *= @speed
    @velocity_y *= @speed
  
    @anim = Chingu::Animation.new( :file => "gfx/laser.jpg", :size=>[2,8]).retrofy
    @image = @anim.next
    self.factor = $window.object_factor
  
    @angle = Gosu::angle(0,0,@velocity_x,@velocity_y)
  
  end
  
  def update    
    @bounding_box.x = @x
    @bounding_box.y = @y
    @image = @anim.next
    self.each_bounding_box_collision(Laser, Asteroid, Player) do |me, obj|
      next if me == obj or me.owner == obj
      on_collision(obj)
      obj.on_collision(me) if obj.respond_to? :on_collision
    end
    
    destroy if outside_window?
  end
  
  def draw
     @image.draw_rot(@x, @y, 20, 20)  
  end
   
end