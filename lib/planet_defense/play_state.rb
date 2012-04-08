module PlanetDefense
  class PlayState < Chingu::GameState
    attr_reader :player, :asteroids, :score, :timer, :level
    attr_accessor :pause

    def initialize( options = {:level => 0, :score => 0})
      super
      @player = Player.new(self)
      puts "Requesting LEVEL: #{options[:level]}"
      @level = PlanetDefense::Levels.return_level(options[:level])
      puts "Running LEVEL: #{@level[:number]}"

      if @level[:scroll] 
        @parallax = Chingu::Parallax.create(:x => 0, :y => 0, :rotation_center => :top_left)
        @parallax << { :image => "media/gfx/stars.jpg", :repeat_x => false, :zorder => 1, :repeat_y => true}
      end

      # Level Settings
      @background_image = @level[:background_image]
      @music = @level[:background_music]

      # Option Settings
      @@asteroids = $window.options.asteroid_number.times.map { Asteroid.new(self) } #change back to 8.times.map
      @planet_health = 1000
      @music.volume = $window.options.musicVolume
      @lives = $window.options.lives

      # View Items
      @life_image = Gosu::Image.new($window, "media/gfx/shipSmall.png", true)
      @font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 43)
      @health_font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 25)
      cursor = Gosu::Image.new($window, 'media/gfx/cursor.png', true)
      icons  = Gosu::Image.load_tiles($window, 'media/gfx/icons.png', 16, 16, false)
      @menu = RingMenu.new :radius => 400, :opaque => false, :modal => true, :icon_rotation => 2, 
        :x_radius => 200, :y_radius => 100 do |m|
        m.cursor cursor, :scale => 2.5
        m.font 'Helvetica', 20
        m.item('QUIT TO MENU',   icons[1], :scale => 2) { end_game }
        m.item('RETURN TO GAME',  icons[3], :scale => 2) { return_to_game }
        m.item('OPTIONS',   icons[2], :scale => 2) { push_game_state( OptionsState ) }
        m.item('HIGH SCORES',  icons[0], :scale => 2) { push_game_state( HighScoresState ) }

      # Defaults
      @count = 0
      @pause = false
      @running = true
      @win = false
      @@score = options[:score]
		  @hit = false
      @game_start = milliseconds()
      @time_allowed = @level[:time]
	  @timer = 0
      @music.play(looping = true) unless @pause == true || defined? RSpec

      end

    end

    def return_to_game
      PlanetDefense::RingMenu::Icon.destroy_all
      @pause = false
      pop_game_state()
    end
   
    def confirm_exit
      @pause = true
      push_game_state @menu
    end

    def end_game
      @running = false
      pop_game_state()
      push_game_state( MenuState )
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
      if id == Gosu::Button::KbEscape
        confirm_exit
      end
    end
  
    def update
      super
      @remaining_time = (@game_start + @time_allowed) - milliseconds()
      $window.caption = "Planet Defense #{PlanetDefense::VERSION} - Framerate: #{$window.framerate} - Time Left: #{(@remaining_time / 1000)+1} secs"
      
      camera_up if @level[:scroll]
      @player.make_stream if @level[:scroll]

      if @running == true and @pause == false

        # Win at 45 seconds
        if @timer > @time_allowed
          @running = false
          @music.pause()
          stop_game
          push_game_state( GameWon.new(:previous_level => @level[:number], :score => @@score) )
        end
		
		@timer = @timer + 1

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
            if (@@asteroids[i].x > $window.width || @@asteroids[i].x < 0)
              if (@@asteroids[i].y > $window.height)
                @@asteroids[i].reset
                @planet_health -= 25 unless @level[:scroll]
                @@score -= 1 unless @level[:scroll] && @@score != 0
              end
            end
          end
        }
      end
    end
    end
  
    def camera_up
      # This is essentially the same as @parallax.y += 2
      @parallax.camera_y -= 10
    end

    def draw
      super
      @background_image.draw(0,0,0)  
      @player.draw  

      # 20, 50
      @lives.times do |i|
        @life_image.draw((40*i)+30,20,1)  
      end

      # Notices on screen
      @font.draw_rel("The game is paused.", 500, 200, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE) if @pause == true
      @font.draw_rel("Asteroid Impact!", 500, 200, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED) if @hit == true
      @font.draw_rel("Press R to restart.", 500, 300, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED) if @hit == true
      #@font.draw_rel("Lives: #{@lives}", 100, 50, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE)
      @font.draw_rel("Score: #{@@score}", 900, 50, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE)
      @health_font.draw_rel("Planet Health", (@health_font.text_width("Planet Health")/2)+18, $window.height - 30, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE) unless @level[:scroll]
      @health_font.draw_rel("Laser Temp", (@health_font.text_width("Laser Temp")/2)+$window.width - 227, $window.height - 30, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE)




      #Gosu::Color.new(0xFF1D4DB5)
      #Asteroid Draw
      @@asteroids.each{|asteroid| asteroid.draw unless asteroid == nil }

      #Planet Health Bar BG
      $window.draw_quad(
        14, $window.height - 45, Gosu::Color::RED,
        14 + (@planet_health / 5), $window.height - 45, Gosu::Color::RED,
        14, $window.height - 15, Gosu::Color::RED,
        14 + (@planet_health / 5), $window.height - 15, Gosu::Color::RED,
      1) unless @level[:scroll]

      #Planet Health Bar FG
      $window.draw_quad(
        217, $window.height - 47, Gosu::Color::BLACK,
        12, $window.height - 47, Gosu::Color::BLACK,
        217, $window.height - 13, Gosu::Color::BLACK,
        12, $window.height - 13, Gosu::Color::BLACK,
      0) unless @level[:scroll]

      #Weapon's heat gauge
      #Filled color
      $window.draw_quad(
        $window.width - 230, $window.height - 45, @player.weapon.gauge_color,
        $window.width - 230 + (@player.weapon.heat * 2), $window.height - 45, @player.weapon.gauge_color,
        $window.width - 230, $window.height - 15, @player.weapon.gauge_color,
        $window.width - 230 + (@player.weapon.heat * 2), $window.height - 15, @player.weapon.gauge_color,
        1)

      #Black background
      $window.draw_quad(
        $window.width - 232, $window.height - 47, Gosu::Color::BLACK,
        $window.width - 12, $window.height - 47, Gosu::Color::BLACK,
        $window.width - 232, $window.height - 13, Gosu::Color::BLACK,
        $window.width - 12, $window.height - 13, Gosu::Color::BLACK,
        0)

      $window.game_objects.destroy_if { |object| object.outside_window? || object.color.alpha == 0 }
    end
  
    def finalize
      game_objects.each(&:destroy)
    end
  
    def refresh_game
      @running = true
      @hit = false
      game_objects.each(&:destroy)
      @music.play()
      @player.reset
      @@asteroids.each {|asteroid| asteroid.reset unless asteroid == nil}
      if @level[:scroll] 
        @parallax = Chingu::Parallax.create(:x => 0, :y => 0, :rotation_center => :top_left)
        @parallax << { :image => "media/gfx/stars.jpg", :repeat_x => false, :zorder => 1, :repeat_y => true}
      end
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