module PlanetDefense
  attr_reader :media_loader
  class Options

    attr_accessor :lives, :asteroid_number, :asteroid_max_velocity, :weapon_heatup_amount, :musicVolume, :sfxVolume

    def initialize
    	medium
    end

    def easy
        $window.currentDifficulty = 0
    	@lives = 5
    	@asteroid_number = 5
    	@asteroid_max_velocity = 5
    	@weapon_heatup_amount = 5
    	#@weapon_cooldown_rate
    	#@weapon_fire_rate
    end

    def medium
        $window.currentDifficulty = 1
    	@lives = 3
    	@asteroid_number = 10
    	@asteroid_max_velocity = 8
    	@weapon_heatup_amount = 7
    end

    def hard
        $window.currentDifficulty = 2
    	@lives = 1
    	@asteroid_number = 15
    	@asteroid_max_velocity = 10
    	@weapon_heatup_amount = 9
    end

    def music_volume(music = 0.9)
        @musicVolume = music
        puts @musicVolume
    end

    def sfx_volume(sfx = 0.9)
        @sfxVolume = sfx
    end
    
  end
end