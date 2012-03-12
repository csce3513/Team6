module PlanetDefense
  class Parallax < PlayState
    def setup
      @parallax = Chingu::Parallax.create(:x => 150, :y => 150, :rotation_center => :top_left)
      @parallax << { :image => "wood.png", :repeat_x => true, :repeat_y => true}
      Chingu::Text.create("82x64 image with repeat_x and repeat_y set to TRUE", :x => 0, :y => 0, :size => 30, :color => @text_color)
    end
  end
end