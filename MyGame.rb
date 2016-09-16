require 'gosu'
require_relative 'Bomb'
require_relative 'Player'

class GameWindow < Gosu::Window

  def initialize
    super 640,440
    @background  = Gosu::Image.new("Media/grass2.png")
    @bombs = Array.new
    @x1, @y1 = 0, 0
    @player_x, @player_y = 300, 150
    @player = Player.new
    @player.warp(@player_x,@player_y)
    @health = 100
  end

  def update
   / @player.near_bomb(@bombs) /

	if button_down?(Gosu::KbRight) 
		if @x1 >= -3500
            @x1 -= 2
			@player.move_right
            @bombs.each { |bomb| bomb.move_right}

		else
		end
	end

	if button_down?(Gosu::KbLeft)  
		if @x1 <= -20
            @x1 += 2
			@player.move_left
            @bombs.each { |bomb| bomb.move_left}
		else
		end
	end
	
    if button_down?(Gosu::KbUp) 
		if @y1 <= -20
            @y1 += 2
			@player.move_up
            @bombs.each { |bomb| bomb.move_up}
		else
		end
	end
	
    if button_down?(Gosu::KbDown)
        if @y1 >= -3500 
            @y1 -= 2
			@player.move_down
            @bombs.each { |bomb| bomb.move_down}
		else
		end
	end

    if button_down?(Gosu::KbSpace)
        if @bombs.empty?           
            @bombs.push(Bomb.new(@player_x,@player_y))
            @player.plantBomb
        elsif @bombs[0].returnSeconds > 1 && @player.myBombs <= @player.myMaxBombs 

        
        end
    end

    @bombs.each do |bomb| 
        bomb.addSecond
        if bomb.returnSeconds == 99
            bomb.resetSeconds(0)
            @bombs.shift
            @player.removeBomb
        else
        end
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

    @player.draw
    @bombs.each { |bomb| bomb.draw()}
    end

end
module Zorder
    Background, Bombs, Player, UI = *0..3
end



window = GameWindow.new
window.show