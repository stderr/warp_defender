class Bullet

  attr_accessor :angle, :color

  def initialize(window, angle, x, y)
    @angle = angle
    @x = x
    @y = y
    @window = window

    @color = Gosu::Color.new(0xff000000)    
    @color.red = rand(255 - 40) + 40
    @color.green = rand(255 - 40) + 40
    @color.blue = rand(255 - 40) + 40
  end

  def move
    @x += Gosu::offset_x(@angle, 10.00)
    @y += Gosu::offset_y(@angle, 10.00)
  end

  def draw
    @window.draw_line(@x, @y, @color, @x + Gosu::offset_x(@angle, 5.0), @y + Gosu::offset_y(@angle, 5.0), @color)
  end

  def off_screen?
    @x > 1600 || @y > 1200 
  end

end

