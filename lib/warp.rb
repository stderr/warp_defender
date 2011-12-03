class Warp
  attr_reader :x, :y, :width, :height
  include Sprite

  def initialize(window, x, y)
    @window = window

    @width = @window.animations[:warp].first.width
    @height = @window.animations[:warp].first.height
    @x = x - @width/2
    @y = y - @height/2
  end
  
  def draw
    img = @window.animations[:warp][Gosu::milliseconds / 100 % @window.animations[:warp].size]

    img.draw(@x, @y, Utils::ZOrder::Warps, 1, 1)
  end

  def collides_with?(other)
    dx = (other.x + other.width/2.0) - (@x + @width/2.0)
    dy = (other.y + other.height/2.0) - (@y + @height/2.0)
    dr = other.width / 2.0 - @width / 2.0

    dx**2 + dy**2 < dr**2
  end

end
