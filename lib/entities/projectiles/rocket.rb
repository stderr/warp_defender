module Entities
  module Projectiles
    class Rocket < Projectile

      def initialize(angle, x, y, vel_x, vel_y)
        super(:x => x, :y => y, :angle => angle,
              :vel_x => vel_x + Gosu::offset_x(angle, 200.00),
              :vel_y => vel_y + Gosu::offset_y(angle, 200.00),
              :z_order => Utils::ZOrder::Player,
              :sprite => "rocket",
              :physics => :dynamic,
              :friction => 0)
      end

      def lifetime
        4000
      end

      def update(delta)
        super(delta)
      end
    end
  end
end
