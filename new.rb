require 'gosu'

class GameWindow < Gosu::Window
  attr_accessor :x, :y # side note - are these used at all?

  def initialize
    super 640,440
    @background  = Gosu::Image.new("Media/grass2.png")
    @front  = Gosu::Image.new("Media/front.png")
    @back  = Gosu::Image.new("Media/back.png")
    @left  = Gosu::Image.new("Media/left.png")
    @right  = Gosu::Image.new("Media/right.png")
    @playerup = Gosu::Image::load_tiles("media/walk_up.png",24,32)
    @playerright = Gosu::Image::load_tiles("media/walk_right.png",24,32)
    @playerdown = Gosu::Image::load_tiles("media/walk_down.png",24,32)
    @playerleft = Gosu::Image::load_tiles("media/walk_left.png",24,32)
    @animation = Gosu::Image::load_tiles("media/BombExploding.png",24,32)
    @x1, @y1 = 0, 0
    @player_x, @player_y = 300, 150
    @facing = "front"
  end

  def update

	if button_down?(Gosu::KbRight) 
		if @x1 >= -3500
			@x1 -= 3
		else
		end
	end
	if button_down?(Gosu::KbLeft)  
		if @x1 <= -20
			@x1 += 3
		else
		end
	end
	if button_down?(Gosu::KbUp) 
		if @y1 <= -20
			@y1 += 3
		else
		end
	end
	if button_down?(Gosu::KbDown)
		if @y1 >= -3500
			@y1 -= 3
		else
		end
	end


    @coordinates = Gosu::Image.from_text(
      self, "#{@x1},#{@y1}", Gosu.default_font_name, 30)
  end

  def draw
    # the important bits!
    @local_x = @x1 % -@background.width
    @local_y = @y1 % -@background.height
    @background.draw(@local_x, @y1, 0)
    @background.draw(@local_x + @background.width, @y1, 0) if @local_x < (@background.width - self.width)
    @background.draw(@x1, @local_y, 0)
    @background.draw(@x1, @local_y + @background.height, 0) if @local_y < (@background.height - self.height)
    @background.draw(@local_x - @background.width, @y1, 0) if @local_x > (@background.width - self.width)
    @background.draw(@x1, @local_y - @background.height, 0) if @local_y > (@background.height - self.height)
    
	

  	if @facing == "back"
		img = @back
 	elsif @facing == "left"
    	img = @left
 	elsif @facing == "right"
    	img = @right
    else
    	img = @front
    end


    if button_down?(Gosu::KbUp)
		img = @playerup[Gosu::milliseconds / 100 % @playerup.size]; 
		@facing = "back"
 	end
 	if button_down?(Gosu::KbDown)
    	img = @playerdown[Gosu::milliseconds / 100 % @playerdown.size];
    	@facing = "front" 
    end
    if button_down?(Gosu::KbLeft)
    	img = @playerleft[Gosu::milliseconds / 100 % @playerleft.size];
 		@facing = "left"
 	end
 	if button_down?(Gosu::KbRight)
    	img = @playerright[Gosu::milliseconds / 100 % @playerright.size];
    	@facing = "right"
    end

	img.draw(@player_x, @player_y, 0)

    @coordinates.draw(0, 0, 1)


  end

  def button_down(id) # Side note: Does this work correctly?
    $window.close if id == Gosu::KbEscape
  end
 	
end

window = GameWindow.new
window.show