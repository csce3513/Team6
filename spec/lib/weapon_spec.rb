require 'spec_helper'

module PlanetDefense
  describe Weapon do
  
    before :all do
      @weapon = Weapon.new()
    end
    
    context "when initialized" do

      it 'should set initial values' do
        @weapon.cooldown_rate.should >= 0 
        @weapon.heatup_amount.should_not == nil
        @weapon.fire_rate.should >= 0 
        @weapon.overheat_penalty.should_not == nil 
        @weapon.last_shot.should_not == nil 
        @weapon.last_cooldown.should_not == nil 
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
        sleep(1)
        if @weapon.cooldown?
          @weapon.heat.should == (100 - (milliseconds() - @weapon.last_cooldown) / @weapon.cooldown_rate) || 0
        end
      end

      it 'should heat up according to heatup_amount' do
        5.times do
          @weapon.heatup
        end
        @weapon.heat.should == @weapon.heatup_amount * 5
      end

      it 'should change the gauge color according to heat' do
        @weapon.heat += 33
        @weapon.gauge_color?.should == Gosu::Color::GREEN
        
        @weapon.heat += 33
        @weapon.gauge_color?.should == Gosu::Color::ORANGE
        
        @weapon.heat += 33
        @weapon.gauge_color?.should == Gosu::Color::RED

        @weapon.heat = 100
        @weapon.overheated?
        @weapon.gauge_color?.should == Gosu::Color::GREY
      end

    end
  end
end