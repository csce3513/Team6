module PlanetDefense
  attr_reader :media_loader
  class Options

    attr_accessor :lives, :asteroid_number, :asteroid_max_velocity, :weapon_heatup_amount, :alt_shot_cooldown

    def initialize
    	medium
    end

    def easy
    	@lives = 5
    	@asteroid_number = 5
    	@asteroid_max_velocity = 5
    	@weapon_heatup_amount = 5
        @alt_shot_cooldown = 5000
    	#@weapon_cooldown_rate
    	#@weapon_fire_rate
    end

    def medium
    	@lives = 3
    	@asteroid_number = 10
    	@asteroid_max_velocity = 8
    	@weapon_heatup_amount = 7
        @alt_shot_cooldown = 10000
    end

    def hard
    	@lives = 1
    	@asteroid_number = 15
    	@asteroid_max_velocity = 10
    	@weapon_heatup_amount = 9
        @alt_shot_cooldown = 15000
    end

  end
end