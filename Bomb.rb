

class Bomb
  attr_reader :x, :y

  def initialize(animation, player_x, player_y)
    @animation = animation
    @color = Gosu::Color.new
    @x = player_x
    @y = player_y
  end

  def draw  
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x, @y, 0)
  end



end
