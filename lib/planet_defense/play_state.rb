module PlanetDefense
  class PlayState < Chingu::GameState
    attr_reader :player, :asteroids, :score, :timer

    def initialize( options = {})
      super
      @player = Player.new(self)  
      @@asteroids = 20.times.map { Asteroid.new(self) }
      @background_image = Gosu::Image.new($window, "media/gfx/space-with-earth.jpg", true)
      @music = Gosu::Song.new($window, "media/sounds/background.wav")
      @font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 43)
      @count = 0  
      @pause = false
      @running = true
      @@score = 0
      @lives = 5
      @planet_health = 1000
      @music.volume = 0.3
      @music.play(looping = true) unless @pause == true || defined? RSpec
      $window.caption = "Planet Defense #{PlanetDefense::VERSION}"
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
      super
      if @running == true and @pause == false

        # Win game at 1000 points
        if @@score > 500
          pop_game_state()
          push_game_state( GameWon )
          @running = false
          @music.pause()
          stop_game
        end

        if @planet_health <= 0
          pop_game_state()
          push_game_state( GameOver )
          @music.pause()
          stop_game
        end

        #Asteroid Movement
        @@asteroids.each{ |asteroid| asteroid.move unless asteroid == nil }

        if @player.hit_by? @@asteroids
          @lives -= 1
          @@score >= 150 ? @@score -= 100 : @@score = 0
          if @lives == 0 
            pop_game_state()
            push_game_state( GameOver )
          end
          @hit = true
          Sound["media/sounds/explosion.wav"].play(0.4)
          @music.pause()
          stop_game
        end

        @player.move  
    
        #Add an asteroid and check for clean up every 100 counts
        @count = (@count + 1) % 25  
        if (@count == 0)
          #Add asteroid to first nil in array
          @@asteroids.length.times{|i|
            if (@@asteroids[i] == nil)
               @@asteroids[i] = Asteroid.new(self)  
               break  
            end
          }
        
          #Clean up asteroids off the screen
          @@asteroids.length.times{|i|
          if (@@asteroids[i] != nil)
            if (@@asteroids[i].y > $window.height)
              @@asteroids[i].reset
              @planet_health -= 25
            end
          end
        }
      end
    end
    end
  
    def draw
      super
      @background_image.draw(0,0,0)  
      @player.draw  
    
      # Notices on screen
      @font.draw_rel("The game is paused.", 500, 200, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE) if @pause == true
      @font.draw_rel("Asteroid Impact!", 500, 200, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED) if @hit == true
      @font.draw_rel("Press R to restart.", 500, 300, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED) if @hit == true
      @font.draw_rel("Lives: #{@lives}", 100, 50, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE)
      @font.draw_rel("Score: #{@@score}", 900, 50, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE)
      @font.draw_rel("Planet Health: #{@planet_health}", 175, $window.height - 50, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE)
    
      #Asteroid Draw
      @@asteroids.each{|asteroid| asteroid.draw unless asteroid == nil }
    end
  
    def finalize
      game_objects.each(&:destroy)
    end
  
    def refresh_game
      @running = true
      @hit = false
      @music.play()
      @player.reset
      @@asteroids.each {|asteroid| asteroid.reset unless asteroid == nil}
      game_objects.each(&:destroy)
    end
  
    def stop_game
      @running = false
    end
  
    def game_objects_size
      game_objects.size
    end
  
    def self.asteroids
      @@asteroids
    end
  
    def self.up_score
      @@score += 10
    end

  end
end