require 'yaml'

module PlanetDefense
	class SaveGame < Chingu::GameState
		def save
			YAML::dump($window.game_objects)
		end
	end
end