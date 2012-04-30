require 'spec_helper'

module PlanetDefense
  describe PowerUp do
  
    before :all do
      @g = PlanetDefense::GameWindow.new
      @powerup = PowerUp.create(@g, PlanetDefense::Player.new) 
    end
    
    after :all do
      @g.close
    end

    it { @g.should respond_to :draw }

    context "when playing" do
      before :each do
        @g.update
      end


      #--------
      #MOVEMENT
      #--------

      it 'should move right across the screen when @vel_x positive ' do
        @powerup.x = $window.width / 2
		  @powerup.vel_x = 1
        20.times do
          @powerup.move
        end
        @powerup.x.should == $window.width/2 + 20
      end

      it 'should move left across the screen when @vel_x negative' do
        @powerup.x = $window.width / 2
		  @powerup.vel_x = -1
        20.times do
          @powerup.move
        end
        @powerup.x.should == $window.width/2 - 20
      end

      it 'should move up the screen when @vel_y positive' do
        @powerup.y = $window.height / 2
		  @powerup.vel_y = 1
        20.times do
          @powerup.move
        end
        @powerup.y.should == $window.height/2 + 20
      end

      it 'should move down the screen when @vel_y negative' do
        @powerup.y = $window.height / 2
		  @powerup.vel_y = -1
        20.times do
          @powerup.move
        end
        @powerup.y.should == $window.height/2 - 20
      end

      #----------
      #COLLISIONS
      #----------

      it 'should collide with player' do
		  @player = Player.create( )
      @powerup.x = @player.x
      @powerup.y = @player.y
      @powerup.collision?.should == true
      end
		
		end
   end
end