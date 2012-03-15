require 'rubygems' unless RUBY_VERSION =~ /1\.9/
require 'bundler/setup'
require 'chingu'
include Gosu
include Chingu
require_all  File.join("lib")

module PlanetDefense
  class GameWindow < Chingu::Window
    attr_accessor :music, :screenWith, :screenHeight, :window, :object_factor

    def initialize(width = 1024, height = 768, fullscreen = false, update_interval = 16.666666)
      super
      @counter = 0
      @media_loader = MediaLoader.new(self)
      @options = Options.new
      retrofy
      @screenWidth = 1024  
      @screenHeight = 768 
      @object_factor = 2.5 
      self.input = { :f1 => :debug, :q => :exit}
      @directions_to_xy = { :north => [0, -1], :east => [1, 0], :south => [0, 1], :west => [-1, 0] }
      push_game_state( MenuState )
    end

    attr_accessor :media_loader, :options
  
    def debug   
       push_game_state(Chingu::GameStates::Debug.new)
    end
  
    def width
      return @screenWidth  
    end
  
    def height
      return @screenHeight  
    end
  
    def update
      super
      close if current_scope == self

      #Testing performance
      #Print out framerate every 30 updates
      @counter = (@counter + 1) % 30
      if (@counter == 0)
        #puts "Framerate: #{$window.framerate}"
      end
    end

    def inside_window?(obj)
      obj.x >= 0 && obj.x <= $window.width && obj.y >= 0 && obj.y <= $window.height
    end
   
    def inside_window?(obj)
      obj.x >= 0 && obj.x <= $window.width && obj.y >= 0 && obj.y <= $window.height
    end
   
    def inside_window?(obj)
      obj.x >= 0 && obj.x <= $window.width && obj.y >= 0 && obj.y <= $window.height
    end

    def outside_window?(obj)
      not inside_window?(obj)
    end

    def directions_to_xy(directions = nil)
      x, y = 0, 0
      return [x,y]  unless directions
      directions.each do |direction, boolean|
        if boolean
          x += @directions_to_xy[direction][0]
          y += @directions_to_xy[direction][1]
        end
      end 
      return [x,y]
    end
  
  end

  unless defined? RSpec
    g = PlanetDefense::GameWindow.new(1024, 768, false)
    g.show
  end
end
