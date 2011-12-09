module Entities
  class Warp < Entity
    include Sprite

    def initialize(window, x, y)
      super(:window => window,
            :x => x, :y => y,
            :width => frame_width(:warp, window),
            :height => frame_height(:warp, window),
            :z_order => Utils::ZOrder::Warps)

      draw_frame(:warp, 0)
    end

    def update(delta)
      @angle += 360/90*delta
    end

    def warp(entity)
      @window.sounds[:warp].play
      animate(:warp, :once, 100,
              lambda { self.animate(:warp, :once_reverse, 100) })
      entity.kill
    end
    
  end

end
