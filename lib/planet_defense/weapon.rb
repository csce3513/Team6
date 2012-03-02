module PlanetDefense
      attr_reader :weapon
      class Weapon

		def initialize()
			#How often (in ms) the weapon cools down by 1 (Rate of cooldown)
			@cooldown_rate = 100
			#Amount of heat generated each shot
			@heatup_amount = 5
			#Minimum time (in ms) between shots (firing rate)
			@fire_rate = 250
			#Length of time weapon is disabled if overheated
			@overheat_penalty = 1000
			#Time of last shot
			@last_shot = milliseconds()
                  #Time of last cooldown
                  @last_cooldown = milliseconds()
			#Current heat level
			@heat = 0
			#Boolean for if weapon is overheated
			@overheated = false
                  @gauge_color = Gosu::Color::GREEN
		end
            attr_accessor :cooldown_rate, :heatup_amount, :fire_rate, :overheat_penalty, :last_shot, :last_cooldown, :heat, :overheated, :gauge_color 
      
            def reset
                  initialize()
            end

            def cooldown?
                  if (milliseconds() - @last_cooldown) <= @cooldown_rate
                        if (@heat == 0)
                              @last_cooldown = milliseconds()
                              false
                        else
                              @heat = (milliseconds() - @last_cooldown) / @cooldown_rate
                              if (@heat < 0)
                                    @heat = 0
                              end
                              true
                        end
                  else
                        puts "test"
                        return false
                  end
            end

	end

end