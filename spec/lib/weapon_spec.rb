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
        @weapon.heat = 100
        sleep(1)
        if @weapon.cooldown?
          @weapon.heat.should == (100 - (milliseconds() - @weapon.last_cooldown) / @weapon.cooldown_rate) || 0
        end
      end
    end


  end
end