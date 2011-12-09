module Entities
  class Explosion < Entity
    include Sprite
    
    def initialize(window, x, y, vel_x=0.0, vel_y=0.0)
      super(:window => window,
            :x => x, :y => y,
            :vel_x => vel_x, :vel_y => vel_y,
            :width => frame_width(:explosion, window),
            :height => frame_height(:explosion, window),
            :z_order => Utils::ZOrder::Explosion)
      
      @physics = Physics::Dynamic.new(0.01)

      # play forward, then backward, then kill
      animate(:explosion, :once, 20,
              lambda { animate(:explosion, :once_reverse, 15,
                              lambda { kill })})
    end
    
    def update(delta)
      @physics.update(self, delta)
    end

  end

end
