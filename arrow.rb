class Arrow

	def initialize (direction)
		@direction = direction
		@thisArrow_x = 300
		@thisArrow_y = 150
		@current_frame = 0
		@animation = Gosu::Image.new("media/sword.png")
		@seconds = 0
	end
	
  def warp(destination_X,destination_y)
    @thisArrow_x = destination_x
    @thisArrow_y = destination_y  
  end

  def returnSeconds
    return @seconds
  end

  def getX
    return @thisArrow_x
  end

  def getY
    return @thisArrow_y
  end

  def addSecond
    @seconds += 1
  end

  def resetSeconds(zero)
    @seconds = zero
  end

  def move_up
    @thisArrow_y += 2
  end

  def move_down
    @thisArrow_y -= 2
  end

  def move_left
    @thisArrow_x += 2
  end
    
  def move_right
    @thisArrow_x -= 2
  end

  def shoot_up
  	@animation = Gosu::Image.new("media/swordDown.png")
    @thisArrow_y += 5
  end

  def shoot_down
  	@animation = Gosu::Image.new("media/sword.png")
    @thisArrow_y -= 5
  end

  def shoot_left
  	@animation = Gosu::Image.new("media/swordLeft.png")
    @thisArrow_x -= 5
  end
    
  def shoot_right
  	@animation = Gosu::Image.new("media/swordRight.png")
    @thisArrow_x += 5
  end

  def getDirection
  	return @direction
  end

  def draw  ()
  img = @animation
  img.draw(@thisArrow_x, @thisArrow_y,  ZOrder::Bombs)
  end
 

end