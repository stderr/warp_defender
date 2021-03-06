module Entities
  module Projectiles
    class Rocket < Projectile
      attr_accessor :target

      def initialize(angle, x, y, vel_x, vel_y)
        super(:x => x, :y => y, :angle => angle,
              :vel_x => vel_x + Gosu::offset_x(angle, 300.00),
              :vel_y => vel_y + Gosu::offset_y(angle, 300.00),
              :z_order => Utils::ZOrder::Player,
              :sprite => "rocket",
              :physics => :dynamic,
              :friction => 0)
        @render.state = "idle"
        @behavior = Behaviors::Hunt.new(self, :turn_radius => 3.0)
        @target = nil
        @detection_range = 500
      end

      def lifetime
        4000
      end

      def kill
        super()
        blast = Entities::Blast.new(@x, @y, @vel_x*0.7, @vel_y*0.7)
        $window.game_engine.level.bullets << blast
      end

      def update(delta)
        super(delta)

        if @target and @target.dead?
          @target = nil
        end

        # look for a target in range
        if not @target
          closest = nil
          closest_distance = nil
          $window.game_engine.level.current_enemies.each do |entity|
            distance = Math.sqrt((@x - entity.x) ** 2 + (@y - entity.y) ** 2)
            if not closest or distance < closest_distance
              closest = entity
              closest_distance = distance
            end

            if closest and closest_distance < @detection_range
              @target = closest
            end
          end
        else
          @angle = @behavior.angle

          @vel_x = Gosu::offset_x(@angle, 300)
          @vel_y = Gosu::offset_y(@angle, 300)
        end
      end
    end
  end
end
