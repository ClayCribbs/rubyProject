class Bomb
  attr_reader :x, :y

  def initialize(animation, player_x, player_y)
    @animation = animation
    @x = player_x
    @y = player_y
  end

  def draw  
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0, 0)
  end
end
