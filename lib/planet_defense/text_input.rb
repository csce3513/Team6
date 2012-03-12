module PlanetDefense
	class TextInput < Chingu::GameObject
		def initialize(options)
			@x = options[:x]
			@y = options[:y]
			
			$window.text_input = Gosu::TextInput.new()
			@text  = Chingu::Text.create(:x => @x, :y => @y)
		end
		
		def update
			@text.text = $window.text_input.text
		end
	end
end