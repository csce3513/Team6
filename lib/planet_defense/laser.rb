module PlanetDefense
  class Laser < Chingu::GameObject
    has_traits :collision_detection, :velocity
    attr_reader :owner, :bounding_box
    @@red = Gosu::Color.new(255, 255, 0, 0)
    @@white = Gosu::Color.new(255, 255, 255, 255)
    has_trait :collision_detection
    @@size = 1
    def initialize( options )
      super
      @owner = options[:owner] || nil    
      @velocity = options[:velocity]
      @speed = 4.0
      @x = options[:x]
      @y = options[:y]
      @bounding_box = Chingu::Rect.new([options[:x], options[:y]-40, 3,3])
      @length = 5
      #Sound["media/sounds/laser.wav"].play(0.1)
      @@size = @@size + 1
      @velocity_x *= @speed
      @velocity_y *= @speed
      @anim = $window.media_loader.weapon[:laser_anim].new_from_frames(0..3)
      @image = @anim.next
      self.factor = $window.object_factor
      @angle = Gosu::angle(0,0,@velocity_x,@velocity_y)
    end
  
    def on_collision(object = nil)    
      destroy
    end
  
    def x
      @x  
    end
  
    def y
      @y
    end
  
    def size
      @@size
    end

    def update    
      @bounding_box.x = @x
      @bounding_box.y = @y
      @x += @velocity_x
      @y += @velocity_y
      @y -= 10
      @image = @anim.next
    
      #PlayState.asteroids.each{|asteroid| puts asteroid.class unless asteroid == nil }
    
      if self.hit? PlayState.asteroids
        PlayState.up_score
        self.destroy
      end
    
      self.each_bounding_box_collision(Laser, Asteroid, Player) do |me, obj|
        next if me == obj
        on_collision(obj)
        obj.on_collision(me) if obj.respond_to? :on_collision
      end
      destroy if outside_window?
    end
  
    def hit?(asteroids)
     asteroids.any? do |asteroid|
       unless asteroid == nil
         if Gosu::distance(@x, @y, asteroid.x, asteroid.y) <= 55
          asteroid.on_collision
         end
      end  
     end
    end
  end
end