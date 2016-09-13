

class Bomb
  attr_reader :x, :y

  def initialize(this_x,this_y)
    @animation = Gosu::Image::load_tiles("media/BombExploding.png",32,64)
    @thisBomb_x = this_x
    @thisBomb_y = this_y
  end

  def warp(this_x,this_y)
    @thisBomb_x = this_x
    @thisBomb_y = this_y  
  end


  def draw  (thisBomb_x,thisBomb_y,local_x,local_y)
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(thisBomb_x+300, thisBomb_y+150, 0)
  end
 


end
