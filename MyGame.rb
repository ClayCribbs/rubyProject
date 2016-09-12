require 'gosu'
require_relative 'Bomb'
require_relative 'Player'

class GameWindow < Gosu::Window
  attr_accessor :x, :y # side note - are these used at all?

  def initialize
    super 640,440
    @background  = Gosu::Image.new("Media/grass2.png")
    @bombs = Array.new
    @x1, @y1 = 0, 0
    @player_x, @player_y = 300, 150
    @bomb_x, @bomb_y = 300, 150
    @player = Player.new
    @player.warp(@player_x,@player_y)
  end

  def update

	if button_down?(Gosu::KbRight) 
		if @x1 >= -3500
            @x1 -= 2
			@player.move_right
		else
		end
	end
	if button_down?(Gosu::KbLeft)  
		if @x1 <= -20
            @x1 += 2
			@player.move_left
		else
		end
	end
	if button_down?(Gosu::KbUp) 
		if @y1 <= -20
            @y1 += 2
			@player.move_up
		else
		end
	end
	if button_down?(Gosu::KbDown)
		if @y1 >= -3500
            @y1 -= 2
			@player.move_down
		else
		end
	end

    if button_down?(Gosu::KbSpace)
        @bombs.push(Bomb.new)
    end
    @coordinates = Gosu::Image.from_text(
      self, "#{@x1},#{@y1}", Gosu.default_font_name, 30)
  end

  def draw
    # background info
    @local_x = @x1 % -@background.width
    @local_y = @y1 % -@background.height
    @background.draw(@local_x, @y1, 0)
    @background.draw(@local_x + @background.width, @y1, 0) if @local_x < (@background.width - self.width)
    @background.draw(@x1, @local_y, 0)
    @background.draw(@x1, @local_y + @background.height, 0) if @local_y < (@background.height - self.height)
    @background.draw(@local_x - @background.width, @y1, 0) if @local_x > (@background.width - self.width)
    @background.draw(@x1, @local_y - @background.height, 0) if @local_y > (@background.height - self.height)

    @player.draw
    @bombs.each { |bomb| bomb.draw(@x1,@y1)}
    end

    def button_down(id) # Side note: Does this work correctly?
        $window.close if id == Gosu::KbEscape
    end
end
module Zorder
    Background, Bombs, Player, UI = *0..3
end



window = GameWindow.new
window.show