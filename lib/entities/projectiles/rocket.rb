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
        @behavior = Behaviors::Hunt.new(self)
        @target = nil
        @detection_range = 500
      end

      def lifetime
        4000
      end

      def update(delta)
        super(delta)

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
        elsif
          @angle = @behavior.angle
          # new_angle = @behavior.angle
          # if new_angle < 0
          #   new_angle = 360 - new_angle.abs
          # end

          # # not time scaled but this is temporary code
          # if @angle > new_angle
          #   @angle -= 240 * ((340 - 300) / 240) * delta
          # elsif @angle < new_angle
          #   @angle += 240 * ((340 - 300) / 240) * delta
          # end

          # if @angle < 0
          #   @angle = 360 - @angle.abs
          # end

          @vel_x = Gosu::offset_x(@angle, 300)
          @vel_y = Gosu::offset_y(@angle, 300)
        end
      end
    end
  end
end
