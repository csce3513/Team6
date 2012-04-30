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
        @player.vel_x.should >= -10
        1000.times do
          @player.move_right
        end
        @player.vel_x.should <= 10
        1000.times do
          @player.move_forward
        end
        @player.vel_y.should >= -10
        1000.times do
          @player.move_backward
        end
        @player.vel_y.should <= 10  
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

      #----------
      #Image
      #----------

      it 'should change image based on speed' do
        #"Animation" for ship turning
        @player.vel_x = @player.vel_max
        @player.draw
        @player.image.should == $window.media_loader.ship[:rightHard]

        @player.vel_x = @player.vel_max * 0.50
        @player.draw
        @player.image.should == $window.media_loader.ship[:right]

        @player.vel_x = 0
        @player.draw
        @player.image.should == $window.media_loader.ship[:normal]

        @player.vel_x = @player.vel_max * -1.0
        @player.draw
        @player.image.should == $window.media_loader.ship[:leftHard]

        @player.vel_x = @player.vel_max * -0.50
        @player.draw
        @player.image.should == $window.media_loader.ship[:left]
      end
    end


  end
  end