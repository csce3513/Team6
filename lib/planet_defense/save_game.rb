require 'yaml'

module PlanetDefense
	class SaveGame < Chingu::GameState
		def initialize( options = {})
			super
		end
		
		def update
		end
		
		def draw
		end
		
		def self.save
			YAML::dump($window.game_objects)
		end
	end
end