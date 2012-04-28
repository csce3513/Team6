module PlanetDefense
  class HelpState < Chingu::GameState

    attr_accessor :OptionsState, :current, :currentDifficulty, :musicVolume, :sfxVolume

    
    def initialize(options = {})
      super

      @fontHeader = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 43)
      @fontContent = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 16)
      @background_image = Gosu::Image.new($window, "media/gfx/space.jpg", true)
      @title_image = Gosu::Image.new($window, "media/gfx/title.png", true)
          
      @player = Player.new(self)
      @player.y = 600 + 50
      @player.x = 550 + 75
      @player.weapon.alt_shot_count = 5

      @asteroid1 = $window.media_loader.asteroid["asteroid1"]
      @asteroid2 = $window.media_loader.asteroid["asteroid2"]
      @asteroid3 = $window.media_loader.asteroid["asteroid3"]
      @powerup1 = $window.media_loader.powerup["powerup_1"].new_from_frames(0..3)
      @powerup2 = $window.media_loader.powerup["powerup_2"].new_from_frames(0..3)
      @angle = 1
    end
    
    def setup
      @game_objects.destroy_all
    end

    def update
      super
      @player.move
      @angle += 2
      pop_game_state() if $window.button_down?(Gosu::KbEscape)
    end
    
    def draw
      super
      
      @player.draw

      @powerup1_image = @powerup1.next
      @powerup2_image = @powerup2.next


      @background_image.draw(0,0,0)
      @title_image.draw(($window.width/2)-@title_image.width/2,100,50)
      @x1 = 150
      @x2 = 550
      @asteroids_y = 200
      @fontHeader.draw("Asteroids", @x1, @asteroids_y, 2)
      @fontContent.draw("Asteroids will move towards the planet.", @x1 + 10, @asteroids_y + 25 * 2, 2)
      @fontContent.draw("Blow them up before they crash into it", @x1 + 10, @asteroids_y + 25 * 3, 2)
      @fontContent.draw("to protect the planet's health.", @x1 + 10, @asteroids_y + 25 * 4, 2)
      @asteroid1.draw_rot(@x2, @asteroids_y + 70, 1, @angle)
      @asteroid2.draw_rot(@x2 + 75, @asteroids_y + 70, 1, @angle)
      @asteroid3.draw_rot(@x2 + 150, @asteroids_y + 70, 1, @angle)

      @powerups_y = 400
      @fontHeader.draw("Power-Ups", @x1, @powerups_y, 2)
      @fontContent.draw("Pick up power-ups to give yourself a boost!", @x1 + 10, @powerups_y + 25 * 2, 2)
      @fontContent.draw("Red gives an alternate fire", @x1 + 10, @powerups_y + 25 * 3, 2)
      @fontContent.draw("Blue lowers your weapon's heat", @x1 + 10, @powerups_y + 25 * 4, 2)
      @powerup1_image.draw_rot(@x2, @powerups_y + 70, 1, @angle)
      @powerup2_image.draw_rot(@x2 + 150, @powerups_y + 70, 1, @angle)


      @ship_y = 600
      @fontHeader.draw("Ship", @x1, @ship_y, 2)
      @fontContent.draw("Use the arrow keys to move", @x1 + 10, @ship_y + 25 * 2, 2)
      @fontContent.draw("Spacebar will fire your primary lasers", @x1 + 10, @ship_y + 25 * 3, 2)
      @fontContent.draw("B will fire your alternate lasers", @x1 + 10, @ship_y + 25 * 4, 2)

    end

    def on_back
      pop_game_state()
    end

  end
end