require 'yaml'

module PlanetDefense
	class SaveGame < Chingu::GameState
	
		def initialize( options = {})
			super
			@font = Gosu::Font.new($window, "media/fonts/MuseoSans_300.otf", 24)
			@text_input = PlanetDefense::TextInput.create(:x => $window.width/2-100, :y => $window.height/2, 
														:width => 200, :height => @font.height*2, :font => @font)			
			@background_image = Gosu::Image.new($window, "media/gfx/space.jpg", true)
			@title_image = Gosu::Image.new($window, "media/gfx/title.png", true)

			self.input = { 
				:up => :move_up,
				:down => :move_down,
				:left => :move_left,
				:right => :move_right,
			}
		end
		
		
		def setup
		  @game_objects.destroy_all

		end
		
		  
		def move_up
		end
		
		def move_down		  
		end
		
		def move_left
		end

		def move_right
		end
		
		def update
			super
			@text_input.update
		end
		
		def draw
			super
			@background_image.draw(0,0,0)
			@title_image.draw(($window.width/2)-@title_image.width/2,100,50)
		end
		
		def self.save
			
		end
	end
end