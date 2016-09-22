class Bomb

  def initialize(this_x,this_y)
    @thisBomb_x = this_x
    @thisBomb_y = this_y
    @seconds = 1
    @current_frame = 0
    @animation = Gosu::Image::load_tiles("media/BombExploding.png",32,64)
  end

  def warp(destination_X,destination_y)
    @thisBomb_x = destination_x
    @thisBomb_y = destination_y  
  end

  def returnSeconds
    return @seconds
  end

  def getX
    return @thisBomb_x
  end

  def getY
    return @thisBomb_y
  end

  def addSecond
    @seconds += 1
  end

  def resetSeconds(zero)
    @seconds = zero
  end

  def move_up
    @thisBomb_y += 2
  end

  def move_down
    @thisBomb_y -= 2
  end

  def move_left
    @thisBomb_x += 2
  end
    
  def move_right
    @thisBomb_x -= 2
  end

  def draw  ()
  img = @animation[@seconds / 15 % 10]
  img.draw(@thisBomb_x, @thisBomb_y,  ZOrder::Bombs)
  end
 

end


