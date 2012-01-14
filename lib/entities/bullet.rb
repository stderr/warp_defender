module Entities
  class Bullet < Entity

    def initialize(angle, x, y, vel_x, vel_y)
      super(:x => x, :y => y, :angle => angle,
            :vel_x => vel_x + Gosu::offset_x(angle, 800.00),
            :vel_y => vel_y + Gosu::offset_y(angle, 800.00),
            :z_order => Utils::ZOrder::Player,
            :sprite => "bullet",
            :physics => :dynamic,
            :friction => 0)

      # make bullets frictionless
      #@physics = Physics::Dynamic.new(:friction => 0)

      #animate(:bullet, :loop, 100, @z_order)
      @render.state = "idle"
    end

    def update(delta)
      @physics.update(self, delta)

      # die after 2 seconds
      if Gosu::milliseconds - @creation_time > 2000
        kill
      end
    end

  end

end
