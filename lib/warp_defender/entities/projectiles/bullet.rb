module Entities
  module Projectiles
    class Bullet < Projectile

      def initialize(angle, x, y, vel_x, vel_y)
        super(:x => x, :y => y, :angle => angle,
              :vel_x => vel_x + Gosu::offset_x(angle, 800.00),
              :vel_y => vel_y + Gosu::offset_y(angle, 800.00),
              :z_order => Utils::ZOrder::Player,
              :sprite => "bullet",
              :physics => :dynamic,
              :friction => 0)
        @render.state = "idle"
      end

      def lifetime
        2000
      end

      def update(delta)
        super(delta)
      end
    end
  end
end
