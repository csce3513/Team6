require_relative '../spec_helper'

module PlanetDefense
	describe SaveGame do
		
		before :all do
		  @g = PlanetDefense::GameWindow.new
		end
		
		after :all do
		  @g.close
		end
		
		context "when saving the game" do
			it 'should serialize game objects' do
				$window.current_game_state.push_game_state( PlanetDefense::SaveGame )
				PlanetDefense::SaveGame.save
			end
		end	
	end
end