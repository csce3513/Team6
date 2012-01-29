$: << File.expand_path(File.dirname(__FILE__))  

require 'rubygems'
require 'gosu'
require "player"
require "asteroid"
require "chingu"

class Asteroids < Gosu::Window

  def initialize
    @screenWidth = 1024  
    @screenHeight = 768  
    super(@screenWidth, @screenHeight, false)  
    self.caption = "Planetary Defense"  
    @background_image = Gosu::Image.new(self, "gfx/space-with-earth.jpg", true)
    @music = Gosu::Song.new(self, "sounds/background.mp3")
    @player = Player.new(self)  
    @asteroids = 15.times.map { Asteroid.new(self) } 
    @font = Gosu::Font.new(self, "fonts/MuseoSans_300.otf", 43)
    @count = 0  
    @pause = false
    @running = true
    @score = 0
    @health = 100
  end
  
  def button_down(id)
    if id == Gosu::Button::KbP
      if @pause == false
        @pause = true
        @music.pause()
      else
        @pause = false
        @music.play()
      end
    end
    if id == Gosu::Button::KbQ
      @running = false
      close
    end
    if button_down? Gosu::Button::KbSpace
      refresh_game
    end
  end
  
  def update
    if @running == true and @pause == false
      
      #Asteroid Movement
      @asteroids.each{ |asteroid| asteroid.move unless asteroid == nil }
  
      if @player.hit_by? @asteroids
        @health -= 10
        @hit = true
        stop_game
      end

      #Player Movement
      if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
        @player.move_left  
      end
      if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
        @player.move_right  
      end
      if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
        @player.move_forward  
      end
      if button_down? Gosu::KbDown or button_down? Gosu::GpDown then
        @player.move_backward  
      end
    
      @player.move  
    
      #Add an asteroid and check for clean up every 100 counts
      @count = (@count + 1) % 25  
      if (@count == 0)
        #Add asteroid to first nil in array
        @asteroids.length.times{|i|
          if (@asteroids[i] == nil)
             @asteroids[i] = Asteroid.new(self)  
             break  
          end
        }
        
        #Clean up asteroids off the screen
        @asteroids.length.times{|i|
        if (@asteroids[i] != nil)
          if (@asteroids[i].y > @screenHeight)
            @asteroids[i] = nil  
          end
        end
      }
    end
  end
  end
  
  def draw
    @music.play(looping = true) unless @pause == true
    @background_image.draw(0,0,0)  
    @player.draw  
    
    # Notices on screen
    @font.draw_rel("The game is paused.", 500, 200, 10, 0.5, 0.5, 1, 1, Gosu::Color::WHITE) if @pause == true
    @font.draw_rel("You got hit!", 500, 200, 10, 0.5, 0.5, 1, 1, Gosu::Color::RED) if @hit == true
    
    #Asteroid Draw
    @asteroids.each{|asteroid| asteroid.draw unless asteroid == nil }
  end
  
  def refresh_game
    @running = true
    @hit = false
    @asteroids.each {|asteroid| asteroid.reset unless asteroid == nil}
  end
  
  def stop_game
    @running = false
  end
  
  def width
    return @screenWidth  
  end
  
  def height
    return @screenHeight  
  end
  
end

window = Asteroids.new
window.show