module PlanetDefense
  attr_reader :media_loader
  class Options

    attr_accessor :lives, :asteroid_number, :asteroid_max_velocity, :weapon_heatup_amount

    def initialize
    	medium
    end

    def easy
    	@lives = 5
    	@asteroid_number = 5
    	@asteroid_max_velocity = 5
    	@weapon_heatup_amount = 5
    	#@weapon_cooldown_rate
    	#@weapon_fire_rate
    end

    def medium
    	@lives = 3
    	@asteroid_number = 10
    	@asteroid_max_velocity = 8
    	@weapon_heatup_amount = 7
    end

    def hard
    	@lives = 1
    	@asteroid_number = 15
    	@asteroid_max_velocity = 10
    	@weapon_heatup_amount = 9
    end

    def volume(value)
        @volume = value
    end

  end
end