class Laser < Chingu::GameObject
  @@red = Gosu::Color.new(255, 255, 0, 0)
  @@white = Gosu::Color.new(255, 255, 255, 255)
  
  has_traits :collision_detection, :velocity
  attr_reader :owner, :bounding_box
  
  def initialize( options )
    @owner = options[:owner] || nil    
    @velocity = 10
    @speed = 4.0
    @bounding_box = Chingu::Rect.new([options[:x], options[:y], 3,3])
    @velocity_x, @velocity_y = @velocity

    @velocity_x = 40
    @velocity_y = 40
     
    @image = Gosu::Image.new($window, "gfx/laser.png") 
  end
  
  def on_collision(object = nil)
    # Spawn 5 white sparks and 5 red sparks ... maybe we should just go with red?
    # 5.times { Spark.create(:x => @x, :y => @y, :color => @@red.dup ) }
    # 5.times { Spark.create(:x => @x, :y => @y, :color => @@white.dup ) }
    # Sound["laser_hits_wall.wav"].play($settings['sound'])
    puts "HIT"
    destroy
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
  
end