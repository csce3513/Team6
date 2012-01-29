class Laser < Chingu::GameObject
  has_traits :collision_detection, :velocity
  attr_reader :owner, :bounding_box
  @@red = Gosu::Color.new(255, 255, 0, 0)
  @@white = Gosu::Color.new(255, 255, 255, 255)
  has_trait :collision_detection
  
  def initialize( options )
    super
    @owner = options[:owner] || nil    
    @velocity = options[:velocity]
    @speed = 4.0
    @x = options[:x]
    @y = options[:y]
    @bounding_box = Chingu::Rect.new([options[:x], options[:y], 3,3])
    @length = 5
    Sound["sounds/laser.wav"].play(0.2)
    
    @velocity_x, @velocity_y = @velocity

    @velocity_x *= @speed
    @velocity_y *= @speed
    @anim = Chingu::Animation.new( :file => "gfx/laser.png", :size=>[2,8], :delay => 4).retrofy
    @image = @anim.next
    self.factor = $window.object_factor

    @angle = Gosu::angle(0,0,@velocity_x,@velocity_y)

  end
  
  def on_collision(object = nil)    
    destroy
  end
  
  def move
    @x += @velocity_x
    @y += @velocity_y 
  end
  
  def x
    @x  
  end
  
  def y
    @y
  end
  
  def update    
    @bounding_box.x = @x
    @bounding_box.y = @y
    @image = @anim.next
    self.each_bounding_box_collision(Laser, Asteroid, Player) do |me, obj|
      puts 'collision'
      next if me == obj or me.owner == obj
      on_collision(obj)
      obj.on_collision(me) if obj.respond_to? :on_collision
    end
    destroy if outside_window?
  end
   
end