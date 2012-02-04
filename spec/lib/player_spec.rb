require 'spec_helper'

module PlanetDefense
  describe Player do
  
    before :each do
      @g = PlanetDefense::GameWindow.new
      @player = Player.new(@g) 
    end
    
    # after :all do
    #   @g.close
    # end
    
    context "when initialized" do
      it 'should be at bottom middle of screen' do
        @player.x.should == $window.width / 2  
        @player.y.should == $window.height - 50
      end
    end

    
  end
end