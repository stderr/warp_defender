class Bullet

  attr_accessor :angle

  def initialize(window, angle, x, y)
    @angle = angle
    @x = x
    @y = y
    @window = window

    @animation =  @window.animations[:bullet]
    @image = @animation.first

    @dead = false
  end

  def move
    @x += Gosu::offset_x(@angle, 10.00)
    @y += Gosu::offset_y(@angle, 10.00)
  end

  def draw
    @image.draw_rot(@x, @y, Utils::ZOrder::Player, @angle) if !@dead
   
    @image = @animation[Gosu::milliseconds / 100 % @animation.size]
  end

  def width
    @image.width
  end

  def height
    @image.height
  end
  
  def collides_with?(other)
    @x + width > other.x and @x < other.x + other.width and
      ((@y+height > other.y and @y < other.y+other.height) or (@y < other.y+other.height and @y+height > other.y))
  end

  def off_screen?
    @x > Gosu::screen_width || @x < 0 || @y < 0 || @y > Gosu::screen_height 
  end

  def kill
    @dead = true
  end

  def dead?
    @dead
  end

end

