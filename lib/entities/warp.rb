module Entities
  class Warp < Entity
    attr_reader :current_defense, :max_defense
    include Sprite
    
    def initialize(x, y)
      super(:x => x, :y => y,
            :width => frame_width(:warp),
            :height => frame_height(:warp),
            :z_order => Utils::ZOrder::Warps)
      
      @max_defense = @current_defense = 10
      draw_frame(:warp, 0)
      
    end

    def update(delta)
      @angle += 360/90*delta
    end

    def warp(entity)
      $window.sounds[:warp].play
      animate(:warp, :once, 100,
              lambda { self.animate(:warp, :once_reverse, 100) })
      entity.kill
      @current_defense -= 1.0
    end
    
    def map_color
      Gosu::Color::BLUE
    end

  end

end
