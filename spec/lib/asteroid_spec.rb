require 'spec_helper'

module PlanetDefense
  describe Asteroid do
  
    before :all do
      @g = PlanetDefense::GameWindow.new
      @asteroid = Asteroid.create(@g) 
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
        @asteroid.y = $window.height / 2
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
        
		  asteroids = 20.times.map { Asteroid.new(@g) }
        asteroids[0].x = @player.x
        asteroids[0].y = @player.y
        @player.hit_by?(asteroids).should == true
      end
		
		#----------
		#Explosions
		#----------
		
		it 'should create an explosion on collision with laser' do
		   #move to playstate
		   $window.current_game_state.push_game_state( PlanetDefense::PlayState )
			#create a laser
		   @laser_options = { :velocity => 0, :x => $window.width/2, :y =>  $window.height/2 }
			@laser = Laser.create( @laser_options )
			asteroids = 20.times.map { Asteroid.new(@g) }
			asteroids[0].x = $window.width/2
			asteroids[0].y = $window.height/2
			
			#check if hit by asteroid, if it is call on_collision for the asteroid
			@laser.hit?(asteroids)
			
			#this is super ghetto. It takes the game_objects of the current state, finds any explosions, converts that to a string,
			#	and then checks that string for "PlanetDefense::Explosion"
			$window.current_game_state.game_objects.of_class( PlanetDefense::Explosion ).to_s.should include("PlanetDefense::Explosion" )
		end
		
		end
   end
end