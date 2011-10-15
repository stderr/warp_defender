class Warp
  attr_reader :x, :y
  include Sprite

  def initialize(window, x, y)
    @window = window

    @x = x
    @y = y
  end
  
  def draw
    img = @window.animations[:warp][Gosu::milliseconds / 100 % @window.animations[:warp].size]
    
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0, Utils::ZOrder::Warps, 1, 1)
  end

end
