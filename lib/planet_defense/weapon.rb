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
                  #Time of last overheat
                  @last_overheat = 0
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

            def heatup
                  @heat += @heatup_amount
                  if @heat > 100
                        @heat = 100
                  end
            end

            def gauge_color?
                  if !@overheated
                        if @heat >= 0 && @heat <= 33
                              @gauge_color = Gosu::Color::GREEN
                        elsif @heat > 33 && @heat < 66
                              @gauge_color = Gosu::Color::ORANGE
                        else @heat > 66
                              @gauge_color = Gosu::Color::RED
                        end
                  else
                        @gauge_color = Gosu::Color::GREY
                  end
            end

            def overheated?
                  #If the heat is over 100, it is overheated
                  if (@heat >= 100)
                        @overheated = true
                  else
                        #If overheat penalty time is over, not overheated anymore
                        if @last_overheat + @overheat_penalty =< milliseconds()
                              @overheated = false
                        else
                              @overheated = true
                        end
                  end
            end

            def update
                  overheated?
                  gauge_color?
            end

	end

end