require 'gosu'
require_relative 'Bomb'
require_relative 'Player'
require_relative 'Enemy'

class GameWindow < Gosu::Window

    def initialize
        super 640,440
        @background  = Gosu::Image.new("Media/grass2.png")
        @sword = Gosu::Image.new("Media/sword.png")
        @bombs = Array.new ### Contains all bombs
        @x1, @y1 = 0, 0 ### Background draw coordinates
        @player_x, @player_y = 300, 150  
        @player = Player.new
        @player.warp(@player_x,@player_y)
        @font = Gosu::Font.new(20)
        @justdropped = 0 ###bomb was recently dropped
        @gameover = false 
        @score = 0
        @bang = Gosu::Sample.new("Media/bang.mp3")
        @start = Gosu::Sample.new("Media/start.wav")
        @enemys = Array.new
        @dead = 0
        @lastdirection = "up"
        @count = rand(25)
        @seconds = 0
    end

    def update

        #if rand(100) < 40 and @bombs.size < 50 then
         #   @bombs.push(Bomb.new(rand(640),rand(440)))
        #end

        if rand(100) < 4 && @enemys.size < 5
            @enemys.push(Enemy.new(rand(600),rand(430)))
        end


    	if button_down?(Gosu::KbRight) 
    		if @x1 >= -3500
                @x1 -= 2
    			@player.move_right
                @bombs.each { |bomb| bomb.move_right}
                @enemys.each { |enemy| enemy.move_right}
    		end
    	end

    	if button_down?(Gosu::KbLeft)  
    		if @x1 <= -20
                @x1 += 2
    			@player.move_left
                @bombs.each { |bomb| bomb.move_left}
                @enemys.each { |enemy| enemy.move_left}
    		end
    	end
    	
        if button_down?(Gosu::KbUp) 
    		if @y1 <= -20
                @y1 += 2
    			@player.move_up
                @bombs.each { |bomb| bomb.move_up}
                @enemys.each { |enemy| enemy.move_up}
    		end
    	end
    	
        if button_down?(Gosu::KbDown)
            if @y1 >= -3500 
                @y1 -= 2
    			@player.move_down
                @bombs.each { |bomb| bomb.move_down}
                @enemys.each { |enemy| enemy.move_down}
    		end
    	end

        if button_down?(Gosu::KbSpace) and !@pressed
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

        @player.warp(@player_x,@player_y)
        @enemys.each do |enemy|
            if rand(20) == 1
                case (rand(2))
                    when 0
                        if enemy.getX < @player.getX
                            enemy.setLastDirection("left")
                        elsif enemy.getX > @player.getX
                            enemy.setLastDirection("right")
                        end
                    when 1
                        if enemy.getY > @player.getY  
                            enemy.setLastDirection("down")  
                        elsif enemy.getY < @player.getY
                            enemy.setLastDirection("up")
                        end
                    else
                end
                case (rand(500))
                    when 0
                        if enemy.getY > @player.getY
                            enemy.setLastDirection("up")
                        elsif enemy.getY < @player.getY
                            enemy.setLastDirection("down")  
                        end
                    when 1
                        if enemy.getX > @player.getX
                            enemy.setLastDirection("right")
                        elsif enemy.getX < @player.getX
                            enemy.setLastDirection("left")
                        end
                    else
                end
                @count = rand(8)
            end

            case (enemy.getLastDirection)
                when "left"
                        enemy.walk_left
                when "right"
                        enemy.walk_right
                when "down"
                        enemy.walk_down
                when "up"
                        enemy.walk_up
                else
            end
        end

        @bombs.each do |bomb| 
            bomb.addSecond
            if bomb.returnSeconds > 150
                @enemys.each do |enemy|
                    enemy.near_bomb(bomb,@score)
                    if enemy.getHealth <= 0
                        @dead = @enemys.index(enemy)
                        @enemys.delete_at(@dead) 
                    end
                end
                @player.near_bomb(bomb,@score)
                @bang.play
                @bombs.shift
                @player.removeBomb
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
            
            if@enemys.empty?
            else
                @enemys.each { |enemy| enemy.draw()}
            end

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




window = GameWindow.new
window.show