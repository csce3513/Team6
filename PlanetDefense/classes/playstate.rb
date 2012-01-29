class PlayState < Chingu::GameState
  attr_reader :player

  def initialize
    @player = Player.new(self)  
    @asteroids = 15.times.map { Asteroid.new(self) }
    @background_image = Gosu::Image.new($window, "gfx/space-with-earth.jpg", true)
    @music = Gosu::Song.new($window, "sounds/background.mp3")
    @font = Gosu::Font.new($window, "fonts/MuseoSans_300.otf", 43)
    @count = 0  
    @pause = false
    @running = true
    @score = 0
    @health = 100
    @bullets = 5

    @music.play(looping = true) unless @pause == true
  end

  def button_down(id)
    if id == Gosu::Button::KbP
      if @pause == false
        @pause = true
        @music.pause()
      else
        @pause = false
        @music.play()
      end
    end
    if id == Gosu::Button::KbQ
      @running = false
      close
    end
    if $window.button_down? Gosu::Button::KbR
      refresh_game
    end
  end
  
  def update
    $window.caption = "Planetary Defense v0.0.1 [FPS:#{$window.fps} - dt:#{$window.milliseconds_since_last_tick}]"
    if @running == true and @pause == false
      
      #Asteroid Movement
      @asteroids.each{ |asteroid| asteroid.move unless asteroid == nil }
  
      if @player.hit_by? @asteroids
        @health -= 10
        @hit = true
        stop_game
      end
      
      self.input = { :escape => :close }
      
      @player.move  
    
      #Add an asteroid and check for clean up every 100 counts
      @count = (@count + 1) % 25  
      if (@count == 0)
        #Add asteroid to first nil in array
        @asteroids.length.times{|i|
          if (@asteroids[i] == nil)
             @asteroids[i] = Asteroid.new(self)  
             break  
          end
        }
        
        #Clean up asteroids off the screen
        @asteroids.length.times{|i|
        if (@asteroids[i] != nil)
          if (@asteroids[i].y > $window.height)
            @asteroids[i] = nil  
          end
        end
      }
    end
  end
  end
  
  def draw
    @background_image.draw(0,0,0)  
    @player.draw  
    
    # Notices on screen
    @font.draw_rel("The game is paused.", 500, 200, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE) if @pause == true
    @font.draw_rel("Asteroid Impact!", 500, 200, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED) if @hit == true
    @font.draw_rel("Hit R to restart.", 500, 300, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED) if @hit == true
    
    #Asteroid Draw
    @asteroids.each{|asteroid| asteroid.draw unless asteroid == nil }
  end
  
  def refresh_game
    @running = true
    @hit = false
    @asteroids.each {|asteroid| asteroid.reset unless asteroid == nil}
  end
  
  def stop_game
    @running = false
  end
end
