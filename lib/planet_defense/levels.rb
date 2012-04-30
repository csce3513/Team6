module PlanetDefense
  class Levels 
    attr_accessor :background_image, :background_music
    
    def initialize(options = {})
    end

    
    def self.return_level(level_num = 0)
      @level = {}

      case level_num 
        ##########
        # LEVEL 0 - Saturn
        ##########
        when 0
          @level[:number] = 0
          @level[:background_image] = Gosu::Image.new($window, "media/gfx/saturn.jpg", true)
          @level[:background_music] = Gosu::Song.new($window, "media/sounds/background.wav")
          @level[:time] = 15000
        ##########
        # LEVEL 1 - Travel to Jupiter
        ##########
        when 1
          @level[:number] = 1
          @level[:background_image] = Gosu::Image.new($window, "media/gfx/stars.jpg", true)
          @level[:background_music] = Gosu::Song.new($window, "media/sounds/background.wav")
          @level[:time] = 30000
          @level[:scroll] = true
        ##########
        # LEVEL 2 - Jupiter 
        ##########
        when 2
          @level[:number] = 2
          @level[:background_image] = Gosu::Image.new($window, "media/gfx/jupiter.jpg", true)
          @level[:background_music] = Gosu::Song.new($window, "media/sounds/background.wav")
          @level[:time] = 15000
        ##########
        # LEVEL 3 - Travel to Mars
        ##########
        when 3
          @level[:number] = 3
          @level[:background_image] = Gosu::Image.new($window, "media/gfx/stars.jpg", true)
          @level[:background_music] = Gosu::Song.new($window, "media/sounds/background.wav")
          @level[:scroll] = true
          @level[:time] = 30000
        ##########
        # LEVEL 4 - Mars
        ##########
        when 4
          @level[:number] = 4
          @level[:background_image] = Gosu::Image.new($window, "media/gfx/mars.jpg", true)
          @level[:background_music] = Gosu::Song.new($window, "media/sounds/background.wav")
          @level[:time] = 30000
        ##########
        # LEVEL 5 - Travel to Moon
        ##########
        when 5
          @level[:number] = 5
          @level[:background_image] = Gosu::Image.new($window, "media/gfx/stars.jpg", true)
          @level[:background_music] = Gosu::Song.new($window, "media/sounds/background.wav")
          @level[:scroll] = true
          @level[:time] = 30000
        ##########
        # LEVEL 6 - Moon
        ##########
        when 6
          @level[:number] = 6
          @level[:background_image] = Gosu::Image.new($window, "media/gfx/moon.jpg", true)
          @level[:background_music] = Gosu::Song.new($window, "media/sounds/background.wav")
          @level[:time] = 15000
        ##########
        # LEVEL 7 - Travel to Earth
        ##########
        when 7
          @level[:number] = 7
          @level[:background_image] = Gosu::Image.new($window, "media/gfx/stars.jpg", true)
          @level[:background_music] = Gosu::Song.new($window, "media/sounds/background.wav")
          @level[:scroll] = true
          @level[:time] = 30000
        ##########
        # LEVEL 4 - Earth
        ##########
        when 8
          @level[:number] = 8
          @level[:background_image] = Gosu::Image.new($window, "media/gfx/earth.jpg", true)
          @level[:background_music] = Gosu::Song.new($window, "media/sounds/background.wav")
          @level[:time] = 15000
        ##########
        # Default
        ##########
        else
          @level[:number] = 0
          @level[:background_image] = Gosu::Image.new($window, "media/gfx/space-with-earth.jpg", true)
          @level[:background_music] = Gosu::Song.new($window, "media/sounds/background.wav")
          @level[:time] = 15000
        end

        @level

      end

  end
end