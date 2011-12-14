module Entities
  class Bullet < Entity
    include LegacySprite

    def initialize(angle, x, y, vel_x, vel_y)
      super(:x => x, :y => y, :angle => angle,
            :vel_x => vel_x + Gosu::offset_x(angle, 800.00),
            :vel_y => vel_y + Gosu::offset_y(angle, 800.00),
            :width => frame_width(:grunt),
            :height => frame_height(:grunt),
            :z_order => Utils::ZOrder::Player)

      # make bullets frictionless
      @physics = Physics::Dynamic.new(0)

      animate(:bullet, :loop, 100, @z_order)
    end

    def update(delta)
      @physics.update(self, delta)
    end

  end

end
