

class Bomb

  def initialize(this_x,this_y)
    @animation = Gosu::Image::load_tiles("media/BombExploding.png",32,64)
    @thisBomb_x = this_x
    @thisBomb_y = this_y
    @seconds = 0
  end

  def warp(destination_X,destination_y)
    @thisBomb_x = destination_x
    @thisBomb_y = destination_y  
  end

  def draw  ()
    img = @animation[Gosu::milliseconds / 250 % 10];
    img.draw(@thisBomb_x, @thisBomb_y, 0)
  end
 
  def returnSeconds
    return @seconds
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


end
