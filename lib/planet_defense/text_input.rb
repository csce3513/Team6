module PlanetDefense
	class TextInput < Chingu::GameObject
		def initialize(options)
			super
			@x = options[:x]
			@y = options[:y]
			@width = options[:width]
			@height = options[:height]
			@font = options[:font]
			
			$window.text_input = Gosu::TextInput.new()
			@text  = Chingu::Text.create(:x => @x, :y => @y)
		end
		
		def update
			super
			@text.text = $window.text_input.text
		end
		
		def draw
			super
			@rect = Chingu::Rect.new(@x - @width/10, @y - @height/4, @width, @height)
			@color = Gosu::Color.argb(0xff808080)
			$window.fill_rect(@rect, @color, 55)
			@font.draw(@text.text, @x, @y, 55, 1)
		end
		
		def to_s
			@text.text
		end
	end
end