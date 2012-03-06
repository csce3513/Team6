require 'spec_helper'

module PlanetDefense
  describe Player do
  
    before :all do
      @g = PlanetDefense::GameWindow.new
      @player = Player.create(@g) 
    end
    
    after :all do
      @g.close
    end

    it { @g.should respond_to :draw }
    
    context "when initialized" do
      it 'should be at bottom middle of screen' do
        @player.x.should == $window.width / 2  
        @player.y.should == $window.height - 50
      end
    end

    context "when playing" do
      before :each do
        @g.update
      end


      #--------
      #MOVEMENT
      #--------

      it 'should move left across the screen on command' do
        @player.x = $window.width / 2
        20.times do
          @player.move_left
          @player.move
        end
        @player.x.should <= 512
      end

      it 'should move right across the screen on command' do
        @player.x = 512
        @player.vel_x = 0
        20.times do
          @player.move_right
          @player.move
        end
        @player.x.should >= 512
      end

      it 'should move up the screen on command' do
        20.times do
          @player.move_forward
          @player.move
        end
        @player.y.should <= 718
      end

    it 'should move down the screen on command' do
      @player.y = 718
      @player.vel_y = 0
      20.times do
        @player.move_backward
        @player.move
      end
    end

    it 'should move down the screen on command' do
      @player.y = 718
      @player.vel_y = 0
      20.times do
        @player.move_backward
        @player.move
      end
        @player.y.should >= 718
    end 

    #----------
    #BOUNDARIES
    #----------

      it 'should not exceed the left boundary' do
        1000.times do
          @player.move_left
        end
        @player.x.should > 0
      end

      it 'should not exceed the right boundary' do
        1000.times do
          @player.move_right
        end
        @player.x.should < 1024
      end

      it 'should not exceed the top boundary' do
        1000.times do
          @player.move_forward
        end
        @player.y.should > 0
      end

      it 'should not exceed the bottom boundary' do
        1000.times do
          @player.move_backward
        end
        @player.y.should < 768
      end


      #--------------
      #MAX VELOCITIES
      #--------------

      it 'should not exceed player max velocities' do
        1000.times do
            @player.move_left
        end
        @player.vel_x.should >= -7.5
        1000.times do
          @player.move_right
        end
        @player.vel_x.should <= 7.5
        1000.times do
          @player.move_forward
        end
        @player.vel_y.should >= -7.5
        1000.times do
          @player.move_backward
        end
        @player.vel_y.should <= 7.5  
      end
    

      #----------
      #COLLISIONS
      #----------

      it 'should collide with asteroids' do
        asteroids = 20.times.map { Asteroid.new(@g) }
        asteroids[0].x = @player.x
        asteroids[0].y = @player.y
        @player.hit_by?(asteroids).should == true
      end

      #------
      #LASERS
      #------

      it 'should be able to shoot lasers' do
        30.times do
          @player.shoot
          PlanetDefense::Laser.size.should > 0
        end

      end
      
      it 'should cooldown lasers over time down to 0 minimum' do
        @player.laser_heat = 100
        200.times do
          @lastHeat = @player.laser_heat
          @player.cool_down_laser
          if (@player.laser_heat > 0)
            @player.laser_heat.should < @lastHeat
          end
        end
        @player.laser_heat.should >= 0
      end

      it 'should heat up when shot to 100 maximum' do
        @player.laser_heat = 0
        10.times do
          @lastHeat = @player.laser_heat
          @player.lastShot = 0;
          @player.heat_up_laser
          @player.laser_heat.should > @lastHeat
        end
        @player.laser_heat.should <= 100
      end

      it 'should overheat at 100 heat, and give a firing penalty' do
        @player.laser_heat = 100
        @player.overheated?.should == true
        @player.lastShot.should > milliseconds()
      end

      it 'should overheat at 100 heat, and give a firing penalty' do
        @player.laser_heat = 100
        @player.overheated?.should == true
        @player.lastShot.should > milliseconds()
      end

      it 'should cooldown every @cooldown_time' do
          @player.laser_heat = 100
          if (@player.last_cooldown + @player.cooldown_time) < milliseconds()
            @player.move
            @player.laser_heat.should < 100
          end
      end

      it 'should have a restricted firing rate' do
        @no_shot = 0
        10.times do
          if (!@player.shoot)
            @no_shot += 1
          end
        end
          @no_shot.should > 0
      end
    end


  end
  end