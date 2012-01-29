GAMEROOT = File.dirname(File.expand_path($0))
require 'rubygems' unless RUBY_VERSION =~ /1\.9/
$: << File.join(GAMEROOT,"lib")
ENV['PATH'] = File.join(GAMEROOT,"lib") + ";" + ENV['PATH']

require 'gosu'
require "chingu"
require_all  File.join(GAMEROOT,"classes")

class Asteroids < Chingu::Window
  attr_accessor :music, :screenWith, :screenHeight, :window

  def initialize
    @screenWidth = 1024  
    @screenHeight = 768  
    super(@screenWidth, @screenHeight, false)  
    self.caption = "Planetary Defense"  
    push_game_state( PlayState )
  end
  
  def width
    return @screenWidth  
  end
  
  def height
    return @screenHeight  
  end
  
end

g = Asteroids.new
g.show