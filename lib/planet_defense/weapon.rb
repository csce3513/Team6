module PlanetDefense
  attr_reader :weapon
  class Weapon

    attr_accessor :cooldown_rate, :heatup_amount, :fire_rate, :overheat_penalty
    attr_accessor :last_shot, :last_cooldown, :last_overheat, :heat, :overheated, :gauge_color 

    def initialize(player)
      @player = player
      #How often (in ms) the weapon cools down by 1 (Rate of cooldown)
      @cooldown_rate = 25
      #Amount of heat generated each shot
      @heatup_amount = 0 #CHANGE BACK TO ~7
      #Minimum time (in ms) between shots (firing rate)
      @fire_rate = 35 #CHANGE BACK TO 100
      #Length of time weapon is disabled if overheated
      @overheat_penalty = 1000
      #Time of last shot
      @last_shot = 0
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
    
    def reset
      initialize(@player)
    end

    #Checks if it needs to be cooled down, and cools down by correct amount (passive, called in update)
    def cooldown?
      if milliseconds() >= @cooldown_rate + @last_cooldown
        if (@heat == 0)
          @last_cooldown = milliseconds()
          false
        else
          @heat = @heat - (milliseconds() - @last_cooldown) / @cooldown_rate
          if (@heat < 0)
            @heat = 0
          end
          @last_cooldown = milliseconds()
          true
        end
      else
        false
      end
    end

    #Heats up the weapon (called in shoot)
    def heatup
      @heat += @heatup_amount
    end

    #Adjusts the gauge color based on heat (passive, called in update)
    def gauge_color?
      if !@overheated
        if @heat >= 0 && @heat <= 25
          @gauge_color = Gosu::Color::GREEN
        elsif @heat > 25 && @heat < 50
          @gauge_color = Gosu::Color::YELLOW
        elsif @heat > 50 && @heat < 75
          @gauge_color = Gosu::Color.argb(0xffffa500)
        else @heat >= 75
          @gauge_color = Gosu::Color::RED
        end
      else
        @gauge_color = Gosu::Color::GRAY
      end
    end

    #Checks if the weapon is overheated (passive, called in update)
    def overheated?
      #If the heat is over 100, it is overheated
      if (@heat >= 100)
        @last_overheat = milliseconds()
        @overheated = true
      else
        #If overheat penalty time is over, not overheated anymore
        if @last_overheat + @overheat_penalty <= milliseconds()
          @overheated = false
        else
          @overheated = true
        end
      end
    end

    #Checks if the weapon is ready to fire (called in shoot)
    def fireable?
      if (!@overheated && @last_shot + @fire_rate < milliseconds())
        true
      else
        false
      end
    end

    #Calls all passive weapon checks (cooldown, overheated, gauge color)
    def update
      cooldown?
      overheated?
      gauge_color?
    end

    #Checks if everything is ready to fire, and fires
    def shoot
      if fireable?
        heatup
        PlanetDefense::Laser.create( :x => @player.x-20, :y => @player.y-15)
        PlanetDefense::Laser.create( :x => @player.x+20, :y => @player.y-15)
        @last_shot = milliseconds()
      end
      update
    end

  end
end