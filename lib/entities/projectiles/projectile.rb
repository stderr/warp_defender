module Entities

  module Projectiles

    class Projectile < Entity
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

      def update(delta)
        @physics.update(self, delta)
        kill if Gosu::milliseconds - @creation_time > lifetime
      end

    end

  end
end
