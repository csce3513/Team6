require 'spec_helper'

module PlanetDefense
  describe Options do
  
    before :all do
      @options = PlanetDefense::Options.new
    end
    
    after :all do
    end

    context "when playing" do

    	it 'should be options class' do
	      @options.should be_kind_of(PlanetDefense::Options)
	    end

	    it { @options.should respond_to :easy }
	    it { @options.should respond_to :medium }
	    it { @options.should respond_to :hard }

    	#----
    	#INIT
    	#----

    	it 'should initialize to medium difficulty' do
    		@options.lives.should == 3
			@options.asteroid_number.should == 10
			@options.asteroid_max_velocity.should == 8
			@options.weapon_heatup_amount.should == 7
		    @options.alt_shot_cooldown.should == 10000
    	end

    	#----
    	#EASY
    	#----

    	it 'should respond to changing difficulty to easy' do
    		@options.easy
			@options.lives.should == 5
			@options.asteroid_number.should == 5
			@options.asteroid_max_velocity.should == 5
			@options.weapon_heatup_amount.should == 5
		    @options.alt_shot_cooldown.should == 5000
    	end

    	#----
    	#MED
    	#----

    	it 'should respond to changing difficulty to medium' do
    		@options.medium
    		@options.lives.should == 3
			@options.asteroid_number.should == 10
			@options.asteroid_max_velocity.should == 8
			@options.weapon_heatup_amount.should == 7
		    @options.alt_shot_cooldown.should == 10000
    	end

    	#----
    	#HARD
    	#----

    	it 'should respond to changing difficulty to hard' do
    		@options.hard
    		@options.lives.should == 1
			@options.asteroid_number.should == 15
			@options.asteroid_max_velocity.should == 10
			@options.weapon_heatup_amount.should == 9
		    @options.alt_shot_cooldown.should == 15000
    	end
   end
end
end