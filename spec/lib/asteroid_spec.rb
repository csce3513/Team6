require 'spec_helper'

module PlanetDefense
  describe Player do
  
    before :all do
      @g = PlanetDefense::GameWindow.new
      @asteroid = Asteroid.create(@g) 
    end
    
    after :all do
      @g.close
    end

    it { @g.should respond_to :draw }
    
    context "when initialized" do
      it 'should be at bottom middle of screen' do
        @asteroid.x.should == $window.width / 2  
        @asteroid.y.should == $window.height - 50
      end
    end

    context "when playing" do
      before :each do
        @g.update
      end


      #--------
      #MOVEMENT
      #--------

      it 'should move right across the screen when @vel_x positive ' do
        @asteroid.x = $window.width / 2
		  @asteroid.vel_x = 1
        20.times do
          @asteroid.move
        end
        @asteroid.x.should == $window.width/2 + 20
      end

      it 'should move left across the screen when @vel_x negative' do
        @asteroid.x = $window.width / 2
		  @asteroid.vel_x = -1
        20.times do
          @asteroid.move
        end
        @asteroid.x.should == $window.width/2 - 20
      end

      it 'should move up the screen when @vel_y positive' do
        @asteroid.y = $window.height / 2
		  @asteroid.vel_y = 1
        20.times do
          @asteroid.move
        end
        @asteroid.y.should == $window.height/2 + 20
      end

      it 'should move down the screen when @vel_y negative' do
        @asteroid.x = $window.height / 2
		  @asteroid.vel_y = -1
        20.times do
          @asteroid.move
        end
        @asteroid.y.should == $window.height/2 - 20
      end

      #----------
      #COLLISIONS
      #----------

      it 'should collide with player' do
		  @player = Player.create( )
        asteroid.x = @player.x
        asteroid.y = @player.y
        @player.hit_by?(asteroids).should == true
      end

  end
end