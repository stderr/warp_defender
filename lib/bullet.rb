class Bullet

  attr_accessor :angle

  def initialize(window, angle, x, y)
    @angle = angle
    @x = x
    @y = y
    @window = window

    @animation =  @window.animations[:bullet]
    @image = @animation.first
    @width = @image.width
    @height = @image.height

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
    dx = other.x - @x
    dy = other.y - @y
    dr = other.width/2.0 + @width/2.0

    dx**2 + dy**2 < dr**2
  end

  def off_screen?
    @x > @window.width || @x < 0 || @y < 0 || @y > @window.height 
  end

  def kill
    @dead = true
  end

  def dead?
    @dead
  end

end

