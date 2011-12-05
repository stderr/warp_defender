class Warp
  include Sprite

  def initialize(window, x, y)
    @window = window

    @width = @window.animations[:warp].first.width
    @height = @window.animations[:warp].first.height
    @x = x
    @y = y
  end
  
  def draw
    img = @window.animations[:warp][Gosu::milliseconds / 100 % @window.animations[:warp].size]

    img.draw(@x - @width/2.0, @y - @height/2.0, Utils::ZOrder::Warps, 1, 1)
  end

end
