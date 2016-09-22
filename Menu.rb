class Menu
	def initialize
		@front = Gosu::Image::load_tiles("media/walk_down_select.png",24,32)
		@femaleFront = Gosu::Image::load_tiles("media/female_back.png",32,32)
		@animation = @front[Gosu::milliseconds / 100 % @front.size]
		@animation2 = @femaleFront[Gosu::milliseconds / 100 % @femaleFront.size]
		@start = 0
		@font = Gosu::Font.new(20)
		@choice = 0
	end

	def changeLeft
		  @femaleFront = Gosu::Image::load_tiles("media/female_back.png",32,32)
		  @front = Gosu::Image::load_tiles("media/walk_down_select.png",24,32)
		  @choice = 0
	end

	def changeRight
		  @front = Gosu::Image::load_tiles("media/walk_down.png",24,32)
		  @femaleFront = Gosu::Image::load_tiles("media/female_back_select.png",32,32)
		  @choice = 1
	end

	def getChoice
		return @choice
	end

	def select
		  @start = 1
	end

	def getStart
		return @start
	end

	def draw
	  @font.draw("Choose Your Character",215,150, ZOrder::Start)
	  @animation = @front[Gosu::milliseconds / 100 % @front.size]
	  @animation.draw(250,185,0)
	  @animation2 = @femaleFront[Gosu::milliseconds / 100 % @femaleFront.size]
	  @animation2.draw(350,185,0)
	end
end