require 'gosu'
require_relative 'Bomb'
require_relative 'Player'
require_relative 'Enemy'
require_relative 'Menu'
require_relative 'Arrow'

class GameWindow < Gosu::Window

    def initialize
        super 640,440
        @background  = Gosu::Image.new("media/grass2.png")
        @front = Gosu::Image::load_tiles("media/walk_down_select.png",24,32)
        @femaleFront = Gosu::Image::load_tiles("media/female_back.png",32,32)
        @bombs = Array.new ### Contains all bombs
        @x1, @y1 = 0, 0 ### Background draw coordinates
        @player_x, @player_y = 300, 150  
        @player = Player.new
        @player.warp(@player_x,@player_y)
        @font = Gosu::Font.new(20)
        @justdropped = 0 ###bomb was recently dropped
        @gameover = false 
        @score = 0
        @bang = Gosu::Sample.new("media/bang.mp3")
        @start = Gosu::Sample.new("media/start.wav")
        @enemys = Array.new
        @dead = 0
        @lastDirection = "up"
        @count = rand(25)
        @horde = 50
        @start = 0
        @menu = Menu.new
        @animation = @front[Gosu::milliseconds / 100 % @front.size]
        @animation2 = @femaleFront[Gosu::milliseconds / 100 % @femaleFront.size]
        @arrows = Array.new
        @thisdirection = "up"
    end

    def update
        #if rand(100) < 40 and @bombs.size < 50 then
         #   @bombs.push(Bomb.new(rand(640),rand(440)))
        #end

        if @menu.getStart == 0
            if button_down?(Gosu::KbLeft)  
                @menu.changeLeft
            end

            if button_down?(Gosu::KbRight)
                @menu.changeRight
            end

            if button_down?(Gosu::KbSpace)
                if @menu.getChoice == 1
                    @player.changeType
                end
                @menu.select
            end
        end

        if @gameover == false && @menu.getStart == 1
            if rand(100) < 8 && @enemys.size < @horde
                @enemys.push(Enemy.new(rand(600),rand(430),rand(4)))
            end

        	if button_down?(Gosu::KbRight) 
        		if @x1 >= -3500
                    @x1 -= 2
        			@player.move_right
                    @bombs.each { |bomb| bomb.move_right}
                    @enemys.each { |enemy| enemy.move_right}
                    @arrows.each { |arrow| arrow.move_right}
        		end
        	end

        	if button_down?(Gosu::KbLeft)  
        		if @x1 <= -20
                    @x1 += 2
        			@player.move_left
                    @bombs.each { |bomb| bomb.move_left}
                    @enemys.each { |enemy| enemy.move_left}
        		    @arrows.each { |arrow| arrow.move_left}
                end
        	end
        	
            if button_down?(Gosu::KbUp) 
        		if @y1 <= -20
                    @y1 += 2
        			@player.move_up
                    @bombs.each { |bomb| bomb.move_up}
                    @enemys.each { |enemy| enemy.move_up}
                    @arrows.each { |arrow| arrow.move_up}
        		end
        	end
        	
            if button_down?(Gosu::KbDown)
                if @y1 >= -3500 
                    @y1 -= 2
        			@player.move_down
                    @bombs.each { |bomb| bomb.move_down}
                    @enemys.each { |enemy| enemy.move_down}
                    @arrows.each { |arrow| arrow.move_down}
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
                @pressed = nil
            end

            if button_down?(Gosu::KbB) and !@pressed2
                @pressed2= true
                if @arrows.empty?
                    @arrows.push(Arrow.new(@player.getDirection))                        
                elsif @player.getMyArrows <= @player.getMaxArrows - 1 
                    @arrows.push(Arrow.new(@player.getDirection))
                else
                end
            elsif not button_down?(Gosu::KbB)
                @pressed2 = nil
            end


            @player.warp(@player_x,@player_y)

            @enemys.each do |enemy|
                @player.near_enemy(enemy)
                if rand(20) == 1
                    case (rand(4))
                        when 0
                            if enemy.getX < @player.getX
                                enemy.setLastDirection("left")
                            end
                        when 1
                            if enemy.getX > @player.getX
                                enemy.setLastDirection("right")
                            end
                        when 2
                            if enemy.getY > @player.getY  
                                enemy.setLastDirection("down")  
                            end
                        when 3
                            if enemy.getY < @player.getY
                                enemy.setLastDirection("up")
                            end
                        else
                    end
                end
                
                if rand(500) == 1
                    case (rand(5))
                        when 0
                            if enemy.getY > @player.getY
                                enemy.setLastDirection("up")
                            end
                        when 1
                            if enemy.getY < @player.getY
                                enemy.setLastDirection("down")  
                            end
                        when 2
                            if enemy.getX < @player.getX
                                enemy.setLastDirection("right")
                            end
                        when 3 
                            if enemy.getX > @player.getX
                                enemy.setLastDirection("left")
                            end
                        else
                    end
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
            

            @player.addTimer
            @bombs.each do |bomb| 
                bomb.addSecond
                if bomb.returnSeconds > 150
                    @enemys.each do |enemy|
                        enemy.near_bomb(bomb,@score,enemy.getX,enemy.getY)
                        if enemy.getHealth <= 0
                            @dead = @enemys.index(enemy)
                            @enemys.delete_at(@dead) 
                            @score += 20
                        end
                    end
                    @player.near_bomb(bomb,@score)
                    @bang.play
                    @bombs.shift
                    @player.removeBomb
                end
            end

            if @arrows.empty? == false
                @arrows.each do |arrow|
                    @enemys.each do |enemy|
                        enemy.near_arrow(arrow.getX,arrow.getY,enemy.getX,enemy.getY)
                    end
                    thisdirection = arrow.getDirection
                    case (thisdirection)
                        when "left"
                            arrow.shoot_left
                        when "right"
                            arrow.shoot_right
                        when "down"
                            arrow.shoot_down
                        when "up"
                            arrow.shoot_up
                        else
                    end
                    if (arrow.getX > 640 || arrow.getX < 0 || arrow.getY > 440 || arrow.getY < 0)
                        @arrows.shift
                        @player.removeArrow
                    end
                end
            end

            @horde += 1

            if @player.getHealth <= 0
                @gameover = true
            end
            
            if @gameover != true
                @score += 1
            end

        end
    end

    def draw
        if @menu.getStart == 0
            @menu.draw
        end
        if @menu.getStart == 1
            if @gameover == false
                @local_x = @x1 % -@background.width
                @local_y = @y1 % -@background.height
                @background.draw(@local_x, @y1, 0, ZOrder::Background)
                @background.draw(@local_x + @background.width, @y1,  ZOrder::Background) if @local_x < (@background.width - self.width)
                @background.draw(@x1, @local_y,  ZOrder::Background)
                @background.draw(@x1, @local_y + @background.height,  ZOrder::Background) if @local_y < (@background.height - self.height)
                @coordinates
                @player.draw
                @font.draw("Health: #{@player.getHealth}", 10, 10,  ZOrder::UI)
                
                if @arrows.empty?
                else
                    @arrows.each { |arrow| arrow.draw()}
                end


                if @enemys.empty?
                else
                    @enemys.each { |enemy| enemy.draw()}
                end

                if @bombs.empty?
                else
                    @bombs.each { |bomb| bomb.draw()} 
                end
            else
            @font.draw("GAME OVER",280,150, ZOrder::UI)
            end
            @font.draw("Score: #{@score/10}", 150, 10,  ZOrder::UI)
        end
    end
end

module ZOrder
    Start, Background, Enemies, Player, Bombs, UI = *0..5
end


window = GameWindow.new
window.show