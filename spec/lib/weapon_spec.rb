require 'spec_helper'

module PlanetDefense
  describe Weapon do
  
    before :all do
      @weapon = Weapon.new(Player.create(PlanetDefense::GameWindow.new))
    end
    
    context "when initialized" do

      it 'should set initial values' do
        @weapon.cooldown_rate.should >= 0 
        @weapon.heatup_amount.should_not == nil
        @weapon.fire_rate.should >= 0 
        @weapon.overheat_penalty.should_not == nil 
        @weapon.last_shot.should == 0
        @weapon.last_cooldown.should_not == nil 
        @weapon.last_overheat.should == 0
        @weapon.heat.should == 0
        @weapon.overheated.should == false 
        @weapon.gauge_color.should == Gosu::Color::GREEN
      end

    end



    context "when calling weapon update" do
      before :each do
        @weapon.reset
      end

      it 'should cooldown according to cooldown_rate' do
        #Set heat to 100, then wait 1 second so it cools down
        @weapon.heat = 100
        @weapon.last_cooldown = milliseconds()
        cooldown_time = milliseconds()
        sleep(1)
        if @weapon.cooldown?
          @weapon.heat.should == 100 - (milliseconds() - cooldown_time) / @weapon.cooldown_rate
        end
        
        @weapon.last_cooldown = 0
        @weapon.heat = 0
        @weapon.cooldown?.should == false

        @weapon.last_cooldown = 0
        @weapon.heat = -1
        @weapon.cooldown?.should == true

        @weapon.last_cooldown = milliseconds() + 1000
        @weapon.cooldown?.should == false

      end

      it 'should heat up according to heatup_amount' do
        5.times do
          @weapon.heatup
        end
        @weapon.heat.should == (@weapon.heatup_amount * 5)

        @weapon.heat = 100
        @weapon.heatup
        @weapon.heat.should >= 100
      end

      it 'should overheat at 100 heat, and stay overheated for overheat_penalty time' do
        #100 heat, should be overheated
        @weapon.heat = 100
        @weapon.overheated?.should == true

        
        #Overheat penalty not met, should still be overheated
        @weapon.heat = 50
        @weapon.overheated?.should == true
        
        #Setting last overheat time to the past, should not be overheated
        @weapon.last_overheat = -1
        @weapon.overheated?.should == false

      end

      it 'should change the gauge color according to heat' do
        @weapon.heat += 20
        @weapon.gauge_color?.should == Gosu::Color::GREEN

        @weapon.heat += 20
        @weapon.gauge_color?.should == Gosu::Color::YELLOW
        
        @weapon.heat += 20
        @weapon.gauge_color?.should == Gosu::Color.argb(0xffffa500)
        
        @weapon.heat += 20
        @weapon.gauge_color?.should == Gosu::Color::RED

        @weapon.heat = 150
        @weapon.overheated?
        @weapon.gauge_color?.should == Gosu::Color::GRAY
      end

      it 'should have a restricted firing rate' do
        @weapon.fireable?.should == true

        @weapon.last_shot = milliseconds() + 1000
        @weapon.fireable?.should == false

        @weapon.overheated = true
        @weapon.fireable?.should == false
      end


      it 'should have an alternate firing mode on a cooldown' do
        3.times do
          #10000 is default (medium difficulty)
          if @weapon.last_alt_shot + 10000 < milliseconds()
            @weapon.alt_shoot.should == true
          else
            @weapon.alt_shoot.should == false
          end
          @weapon.last_alt_shot = milliseconds();
          @weapon.alt_shoot.should == false
        end
      end

      it 'should fire 3 waves of lasers when alt_firing' do
        @weapon.alt_shot_step.should == -1
        @weapon.alt_shoot
        @weapon.alt_shot_step.should == 0
        @weapon.last_alt_shot = 0
        @weapon.check_alt_shoot
        @weapon.alt_shot_step.should == 1
        @weapon.last_alt_shot = 0
        @weapon.check_alt_shoot
        @weapon.alt_shot_step.should == 2
        @weapon.last_alt_shot = 0
        @weapon.check_alt_shoot
        @weapon.alt_shot_step.should == -1
      end

      it 'should only fire when ready' do
        if @weapon.fireable?
          @weapon.shoot
          #Weird way to check, but if the weapon is fireable and shoot is called,
          #last shot should be within 5 milliseconds of when shoot is called
          @weapon.last_shot.should < milliseconds() + 5
        end
      end

    end
  end
end