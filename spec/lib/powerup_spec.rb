require 'spec_helper'

module PlanetDefense
  describe PowerUp do
  
    before :all do
      @g = PlanetDefense::GameWindow.new
      @player = Player.create( )
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
      #Boundaries
      #----------

      it 'should bounce off the edges of the screen' do
        #Bouncing off the right side
        @powerup.vel_x = 5
        @powerup.x = $window.width + 100
        @powerup.move
        @powerup.x.should == 1024
        @powerup.vel_x.should == -5

        #Bouncing off the left side
        @powerup.vel_x = -5
        @powerup.x = -100
        @powerup.move
        @powerup.x.should == 0
        @powerup.vel_x.should == 5

        #Bouncing off the top side
        @powerup.vel_y = -5
        @powerup.y = -100
        @powerup.move
        @powerup.y.should == 0
        @powerup.vel_y.should == 5

        #Bouncing off the bottom side
        @powerup.vel_y = 5
        @powerup.y = $window.width + 100
        @powerup.move
        @powerup.y.should == 768
        @powerup.vel_y.should == -5
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