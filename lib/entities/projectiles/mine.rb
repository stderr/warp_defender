module Entities
  module Projectiles
    
    class Mine < Projectile
      def initialize(angle, x, y, vel_x, vel_y)
        super(:x => x, :y => y, :angle => angle,
              :z_order => Utils::ZOrder::Player,
              :sprite => "mine",
              :physics => :static)
        @render.state = "idle"
      end

      def lifetime
        10000000
      end
      
      def update(delta)
        super(delta)
      end

    end

  end
end
