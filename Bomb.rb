

class Bomb
  attr_reader :x, :y

  def initialize
    @animation = Gosu::Image::load_tiles("media/BombExploding.png",32,64)
    @thisBomb_x = 300
    @thisBomb_y = 150
  end

  def draw  (thisBomb_x,thisBomb_y)
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(thisBomb_x+300, thisBomb_y+150, 0)
  end



end
