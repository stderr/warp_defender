class Warp
  include Sprite

  def initialize(window, x, y)
    @window = window

    @width = @window.animations[:warp].first.width
    @height = @window.animations[:warp].first.height
    @x = x
    @y = y
    @angle = 0
    @z_order = Utils::ZOrder::Warps

    draw_frame(:warp, 0)
  end

  def warp(entity)
    @window.sounds[:warp].play
    animate(:warp, :once, 100,
            lambda { self.animate(:warp, :once_reverse, 100) })
    entity.kill
  end
  
end
