module PlanetDefense
  attr_reader :media_loader
  class Options

    attr_accessor :lives, :asteroid_number, :asteroid_max_velocity, :weapon_heatup_amount, :powerup_number, :alt_shot_cooldown, :musicVolume, :sfxVolume
    attr_accessor :asteroid_damage
    def initialize
    	medium
        @musicVolume = 0.9
        @sfxVolume = 0.9
    end

    def easy
    	self.lives = 5
    	self.asteroid_number = 5
    	self.asteroid_max_velocity = 5
    	self.weapon_heatup_amount = 5
        self.alt_shot_cooldown = 5000
        self.powerup_number = 5
        self.asteroid_damage = 25
    	#@weapon_cooldown_rate
    	#@weapon_fire_rate
    end

    def medium
    	self.lives = 3
    	self.asteroid_number = 10
    	self.asteroid_max_velocity = 8
    	self.weapon_heatup_amount = 7
        self.alt_shot_cooldown = 10000
        self.powerup_number = 3
        self.asteroid_damage = 40
    end

    def hard
    	self.lives = 1
    	self.asteroid_number = 15
    	self.asteroid_max_velocity = 10
    	self.weapon_heatup_amount = 9
        self.alt_shot_cooldown = 15000
        self.powerup_number = 2
        self.asteroid_damage = 40
    end

    def music_volume(music)
        @musicVolume = music
    end

    def sfx_volume(sfx)
        @sfxVolume = sfx
    end
    
  end
end