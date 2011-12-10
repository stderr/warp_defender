module Entities
  class Explosion < Entity
    include Sprite
    
    def initialize(x, y, vel_x=0.0, vel_y=0.0)
      super(:x => x, :y => y,
            :vel_x => vel_x, :vel_y => vel_y,
            :width => frame_width(:explosion),
            :height => frame_height(:explosion),
            :z_order => Utils::ZOrder::Explosion)
      
      @physics = Physics::Dynamic.new(0.01)

      # play forward, then backward, then kill
      animate(:explosion, :once, 20, @z_order, :default,
              lambda { animate(:explosion, :once_reverse, 15, @z_order, :default,
                              lambda { kill })})
    end

    def update(delta)
      @physics.update(self, delta)
    end

  end

end
