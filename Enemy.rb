

class Enemy

  def initialize(this_x,this_y)
    @thisEnemy_x = this_x
    @thisEnemy_y = this_y
    @seconds = 1
    @current_frame = 0
    @enemyup = Gosu::Image::load_tiles("Media/enemy_up.png",32,32)
    @enemyright = Gosu::Image::load_tiles("Media/enemy_right.png",32,32)
    @enemydown = Gosu::Image::load_tiles("Media/enemy_down.png",32,32)
    @enemyleft = Gosu::Image::load_tiles("Media/enemy_left.png",32,32)
    @img = @enemyup[Gosu::milliseconds / 100 % @enemyup.size]
    @health = 20
    @lasthit = 5
    @lastdirection = "up"
  end

  def warp(destination_X,destination_y)
    @thisEnemy_x = destination_x
    @thisEnemy_y = destination_y  
  end

  def getHealth()
    return @health
  end

  def returnSeconds
    return @seconds
  end

  def getX
    return @thisEnemy_x
  end

  def getY
    return @thisEnemy_y
  end

  def addSecond
    @seconds += 1
  end

  def resetSeconds(zero)
    @seconds = zero
  end

  def move_up
    @thisEnemy_y += 2
  end

  def move_down
    @thisEnemy_y -= 2
  end

  def move_left
    @thisEnemy_x += 2
  end
    
  def move_right
    @thisEnemy_x -= 2
  end


  def walk_up
      @thisEnemy_y += 1
      @lastdirection = "up"
      @img = @enemydown[Gosu::milliseconds / 100 % @enemyup.size]
  end

  def walk_down
      @thisEnemy_y -= 1
      @lastdirection = "down"
      @img = @enemyup[Gosu::milliseconds / 100 % @enemydown.size]
  end

  def walk_left
      @thisEnemy_x += 1
      @img = @enemyright[Gosu::milliseconds / 100 % @enemyleft.size]
      @lastdirection = "left"
  end
    
  def walk_right
      @thisEnemy_x -= 1
      @img = @enemyleft[Gosu::milliseconds / 100 % @enemyright.size]
      @lastdirection = "right"
  end

  def getLastDirection
    return @lastdirection
  end

  def setLastDirection(direction)
    @lastdirection = direction
  end

def near_bomb(bomb,timer)
    if Gosu::distance(bomb.getX,bomb.getY,300,150) < 45 then
        if timer-@lasthit > 3 
          @health -= 10
          @lasthit = timer
          true
        else
        false
      end
    end

  end

  def draw  ()
  @img.draw(@thisEnemy_x, @thisEnemy_y, 0)
  end
 


end
