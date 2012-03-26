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
			
			@selected = Color.new(150,220,69,82)
			
			@current = 0
			
			@menu_options = [:'save game', :back]
			
			self.input = { 
				:up => :move_up,
				:down => :move_down,
				:left => :move_left,
				:right => :move_right,
				:return => :go
			}
		end
		
		
		def setup
		  @game_objects.destroy_all

		end
		
		  
		def move_up
			@current -= 1
			@current = @menu_options.length-1 if @current < 0
		end
		
		def move_down
			@current += 1
			@current = 0 if @current >= @menu_options.length
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
			
			@color = Color.new(150,220,69,82)
			
			@font.draw("Save game as:", $window.width/2-100,  $window.height/2 - 50, 0)
			
			@menu_options.each_with_index do |option, i|
				option_y = 480+(i*@font.height*2)
				@rect = Chingu::Rect.new(0, option_y - @font.height/4, $window.width, @font.height*1.5)
				if i == @current
					$window.fill_rect(@rect, @color, 0)
				end
				@font.draw(option.to_s.capitalize, ($window.width/2)-@font.text_width(option.to_s.capitalize)/2, option_y,0)
			end
		end
		
		def save
			output = File.new(@text_input.to_s + '.yml', 'w')
			playstate = game_states.last
			output.puts YAML.dump(playstate)
		end
		
		def go
			if(@current == 0)
				save
			else
				pop_game_state
			end
		end
		
	end
end