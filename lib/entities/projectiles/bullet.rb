module Entities
  module Projectiles
    class Bullet < Projectile

      def initialize(angle, x, y, vel_x, vel_y)
        super(angle, x, y, vel_x, vel_y)
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
