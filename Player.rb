class Player
  
  def initialize
    @front  = Gosu::Image.new("Media/front.png")
    @back  = Gosu::Image.new("Media/back.png")
    @left  = Gosu::Image.new("Media/left.png")
    @right  = Gosu::Image.new("Media/right.png")
    @playerup = Gosu::Image::load_tiles("media/walk_up.png",24,32)
    @playerright = Gosu::Image::load_tiles("media/walk_right.png",24,32)
    @playerdown = Gosu::Image::load_tiles("media/walk_down.png",24,32)
    @playerleft = Gosu::Image::load_tiles("media/walk_left.png",24,32)
    @facing = @front
    @myBombs = 0
    @maxBombs = 3
    @x = @y = 0
    @health = 100
    @lasthit = 0
  end


  def plantBomb
      @myBombs += 1
  end


  def myBombs
    return @myBombs
  end

  def myMaxBombs
    return @maxBombs
  end

  def removeBomb
    @myBombs -= 1
  end

  def move_up
    @y += 2
    @facing = @playerup[Gosu::milliseconds / 100 % @playerup.size]; 
  end

  def move_down
    @y -= 2
    @facing = @playerdown[Gosu::milliseconds / 100 % @playerdown.size];
  end

  def move_left
    @x += 2
    @facing = @playerleft[Gosu::milliseconds / 100 % @playerleft.size];
  end
    
  def move_right
    @x -= 2
    @facing = @playerright[Gosu::milliseconds / 100 % @playerright.size];
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def near_bomb(bombs,timer)
    bombs.each do |bomb|
    if Gosu::distance(bomb.getX,bomb.getY,300,150) < 25 then
        if timer-@lasthit > 3 
          @health -= 10
          @lasthit = timer
          true
        end
        else
        false
      end
    end

  end

  def getHealth
    return @health
  end


  def draw
    @facing.draw(300, 150, 0)
  end

end