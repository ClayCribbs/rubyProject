class Player
  
  def initialize()
    @playerup = Gosu::Image::load_tiles("media/walk_up.png",24,32)
    @playerright = Gosu::Image::load_tiles("media/walk_right.png",24,32)
    @playerdown = Gosu::Image::load_tiles("media/walk_down.png",24,32)
    @playerleft = Gosu::Image::load_tiles("media/walk_left.png",24,32)
    @front  = Gosu::Image.new("Media/front.png")
    @back  = Gosu::Image.new("Media/back.png")
    @left  = Gosu::Image.new("Media/left.png")
    @right  = Gosu::Image.new("Media/right.png")
    @facing = @front
    @myBombs = 0
    @maxBombs = 7
    @myArrows = 4
    @maxArrows = 5
    @x = 300
    @y = 150
    @health = 100
    @lasthit = 5
    @ouch = Gosu::Sample.new("Media/ouch.mp3")
    @timer = 5
    @direction = "down"
  end


  def plantBomb
    @myBombs += 1
  end

  def shootArrow
    @myArrows += 1
  end

  def getMyArrows
    return @myArrows
  end

  def getMaxArrows
    return @maxArrows
  end

  def removeArrow
    @myArrows -= 1
  end

  def addTimer
    @timer +=1
  end

  def getTimer
    return @timer
  end

  def getX
    return @x
  end

  def getY
    return @y
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
    @y -= 2
    @facing = @playerup[Gosu::milliseconds / 100 % @playerup.size]; 
    @direction = "down"
  end

  def move_down
    @y += 2
    @facing = @playerdown[Gosu::milliseconds / 100 % @playerdown.size];
    @direction = "up"
  end

  def move_left
    @x -= 2
    @facing = @playerleft[Gosu::milliseconds / 100 % @playerleft.size];
    @direction = "left"
  end
    
  def move_right
    @x += 2
    @facing = @playerright[Gosu::milliseconds / 100 % @playerright.size];
    @direction = "right"
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def getDirection
    return @direction
  end

  def changeType
      @playerup = Gosu::Image::load_tiles("media/female_up.png",32,32)
      @playerright = Gosu::Image::load_tiles("media/female_right.png",32,32)
      @playerdown = Gosu::Image::load_tiles("media/female_back.png",32,32)
      @playerleft = Gosu::Image::load_tiles("media/female_left.png",32,32)
      @front  = Gosu::Image.new("Media/femaleface_up.png")
      @back  = Gosu::Image.new("Media/femaleface_back.png")
      @left  = Gosu::Image.new("Media/femaleface_left.png")
      @right  = Gosu::Image.new("Media/femaleface_right.png")
      @facing = @playerdown[Gosu::milliseconds / 100 % @playerdown.size]; 
  end


  def near_bomb(bomb,timer)
    if Gosu::distance(bomb.getX,bomb.getY,300,150) < 35 then
        if timer-@lasthit > 3 
          @health -= 10
          @ouch.play
          @lasthit = timer
          true
        else
        false
      end
    end

  end

def near_enemy(enemy)
    if Gosu::distance(enemy.getX,enemy.getY,300,150) < 17 then
        if @timer > 15
          @timer = 0
          @health -= 20
          @ouch.play
          true
        else
        false
      end
    end

  end


  def getHealth
    return @health
  end


  def draw
    @facing.draw(300, 150,  ZOrder::Player)
  end

end

