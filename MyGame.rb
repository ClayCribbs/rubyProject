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
    @font = Gosu::Font.new(20)
    @justdropped = 0
    @index = 0
    @gameover = false
    @score = 0
  end

  def update

    if rand(100) < 20 and @bombs.size < 25 then
        @bombs.push(Bomb.new(rand(640),rand(440)))
    end

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


    if button_down?(Gosu::KbSpace) and !@pressed
        @index+=1
        @pressed=true
        if @bombs.empty?
            @bombs.push(Bomb.new(@player_x,@player_y))
            @player.plantBomb
        elsif @bombs[0].returnSeconds > 50 && @player.myBombs <= @player.myMaxBombs-1 
            @bombs.push(Bomb.new(@player_x,@player_y))
            @player.plantBomb
        end
    elsif not button_down?(Gosu::KbSpace)
        @pressed=nil
    end

    
    @bombs.each do |bomb| 
        bomb.addSecond
        if bomb.returnSeconds == 200
            @player.near_bomb(@bombs,@score);
            @bombs.shift
            @player.removeBomb
        else
        end

    end

    if @player.getHealth <= 0
        @gameover = true
    end
    
    if @gameover != true
        @score += 1
    end
   
end

  def draw
    # background info
    if @gameover == false
        @local_x = @x1 % -@background.width
        @local_y = @y1 % -@background.height
        @background.draw(@local_x, @y1, 0)
        @background.draw(@local_x + @background.width, @y1, 0) if @local_x < (@background.width - self.width)
        @background.draw(@x1, @local_y, 0)
        @background.draw(@x1, @local_y + @background.height, 0) if @local_y < (@background.height - self.height)
        @coordinates
        @player.draw
        @font.draw("Health: #{@player.getHealth}", 10, 10, 0)
        if @bombs.empty?
        else
            @bombs.each { |bomb| bomb.draw()} 
        end
    else
        @font.draw("GAME OVER",280,150,0)
    end
    @font.draw("Score: #{@score/10}", 150, 10, 0)
end
end
module Zorder
    Background, Bombs, Player, UI = *0..3
end



window = GameWindow.new
window.show