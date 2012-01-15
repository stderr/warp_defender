module Entities

  module Projectiles

    class Projectile < Entity
      def initialize(options = {})
        super(options)

        @behavior = Behaviors::Hunt.new(self, :turn_radius => 2.0)
        @render.state = "idle"
      end

      def update(delta)
        @physics.update(self, delta)
        kill if Gosu::milliseconds - @creation_time > lifetime
      end

    end

  end
end
