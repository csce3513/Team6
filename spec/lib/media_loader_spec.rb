module PlanetDefense
  attr_reader :media_loader
  class MediaLoader

    attr_accessor :lives, :asteroid_number, :asteroid_max_velocity, :weapon_heatup_amount, :alt_shot_cooldown

    def initialize
    	medium
    end

    def easy
    	self.lives = 5
    	self.asteroid_number = 5
    	self.asteroid_max_velocity = 5
    	self.weapon_heatup_amount = 5
        self.alt_shot_cooldown = 5000
    	#@weapon_cooldown_rate
    	#@weapon_fire_rate
    end

    def medium
    	self.lives = 3
    	self.asteroid_number = 10
    	self.asteroid_max_velocity = 8
    	self.weapon_heatup_amount = 7
        self.alt_shot_cooldown = 10000
    end

    def hard
    	self.lives = 1
    	self.asteroid_number = 15
    	self.asteroid_max_velocity = 10
    	self.weapon_heatup_amount = 9
        self.alt_shot_cooldown = 15000
    end

  end
end