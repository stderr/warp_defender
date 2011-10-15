class Bullet

  attr_accessor :angle

  def initialize(window, angle, x, y)
    @angle = angle
    @x = x
    @y = y
    @window = window
  end

  def move
    @x += Gosu::offset_x(@angle, 10.00)
    @y += Gosu::offset_y(@angle, 10.00)
  end

  def draw
    img = @window.animations[:bullet][Gosu::milliseconds / 100 % @window.animations[:grunt].size]
    img.draw_rot(@x, @y, Utils::ZOrder::Player, @angle)
  end

  def off_screen?
    @x > 1600 || @y > 1200 
  end

end

