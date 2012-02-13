require 'spec_helper'

module PlanetDefense
  describe Player do
  
    before :all do
      @g = PlanetDefense::GameWindow.new
      @player = Player.new(@g) 
    end
    
    after :all do
      @g.close
    end

    # it { @g.should respond_to :move_left }
    # it { @g.should respond_to :move_right }
    # it { @g.should respond_to :move_down }
    # it { @g.should respond_to :move_up }
    # it { @g.should respond_to :move }
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
        
        @player.y.should >= 718
      end

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
        @player.x.should > 0
      end

      it 'should not exceed the bottom boundary' do
        1000.times do
          @player.move_backward
        end
        @player.x.should < 768
      end

      it 'should not exceed player max velocities' do
        1000.times do
          @player.move_left
        end
        @player.vel_x.should >= -6.5
        1000.times do
          @player.move_right
        end
        @player.vel_x.should <= 6.5
        1000.times do
          @player.move_forward
        end
        @player.vel_y.should >= -6.5
        1000.times do
          @player.move_backward
        end
        @player.vel_y.should <= 6.5  
      end
    end
    
    it 'should collide with asteroids' do
      asteroids = 20.times.map { Asteroid.new(@g) }
      asteroids[0].x = @player.x
      asteroids[0].y = @player.y
      asteroids.any? {|asteroid| Gosu::distance(@player.x, @player.y, asteroid.x, asteroid.y) <= 55 unless asteroid == nil }.should == true
    end

    it 'should shoot lasers' do
      5.times { @player.shoot }
      Laser.all.length.should > 0
    end
  end
end