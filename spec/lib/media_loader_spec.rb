require 'spec_helper'

module PlanetDefense
    describe MediaLoader do
  
        before :all do
          @g = PlanetDefense::GameWindow.new
          @media_loader = PlanetDefense::MediaLoader.new(@g) 
        end
        
        after :all do
          @g.close
        end

        it { @media_loader.should respond_to :load_asteroid }
        it { @media_loader.should respond_to :load_weapon }

        context "when playing" do

            it 'should load files into animations and images' do
                @media_loader.asteroid["asteroid1_1"].should be_kind_of(Gosu::Image)
                @media_loader.asteroid["asteroid1_2"].should be_kind_of(Gosu::Image)
                @media_loader.asteroid["asteroid1_3"].should be_kind_of(Gosu::Image)
                @media_loader.asteroid["asteroid2_1"].should be_kind_of(Gosu::Image)
                @media_loader.asteroid["asteroid2_2"].should be_kind_of(Gosu::Image)
                @media_loader.asteroid["asteroid2_3"].should be_kind_of(Gosu::Image)
                @media_loader.asteroid["asteroid3_1"].should be_kind_of(Gosu::Image)
                @media_loader.asteroid["asteroid3_2"].should be_kind_of(Gosu::Image)
                @media_loader.asteroid["asteroid3_3"].should be_kind_of(Gosu::Image)
                @media_loader.asteroid[:explosion_anim].should be_kind_of(Chingu::Animation)

                @media_loader.weapon[:laser_anim].should be_kind_of(Chingu::Animation)
                @media_loader.weapon[:alt_laser_anim].should be_kind_of(Chingu::Animation)
            end
        end
    end
end