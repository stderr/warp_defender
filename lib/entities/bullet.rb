module Entities
  class Bullet < Entity
    include Sprite

    def initialize(window, angle, x, y, vel_x, vel_y)
      super(:window => window, :x => x, :y => y, :angle => angle,
            :vel_x => vel_x + Gosu::offset_x(angle, 800.00),
            :vel_y => vel_y + Gosu::offset_y(angle, 800.00),
            :width => frame_width(:grunt, window),
            :height => frame_height(:grunt, window),
            :z_order => Utils::ZOrder::Player)

      # make bullets frictionless
      @physics = Physics::Dynamic.new(0)

      animate(:bullet, :loop, 100)
    end

    def update(delta)
      @physics.update(self, delta)
    end

  end

end
