module Physics

  class Dynamic
    attr_accessor :accel, :angular_accel, :friction

    def initialize(friction=0.03, angular_friction=0.1)
      @accel = 0.0
      @angular_accel = 0.0
      @friction = friction
      @angular_friction = angular_friction
    end

    def update(entity, delta)
      # update velocity
      entity.vel_x += Gosu::offset_x(entity.angle, @accel) * delta
      entity.vel_y += Gosu::offset_y(entity.angle, @accel) * delta
      entity.vel_angle += @angular_accel * delta

      # update angle and position
      entity.angle += entity.vel_angle * delta
      entity.x     += entity.vel_x * delta
      entity.y     += entity.vel_y * delta

      # apply space-friction
      entity.vel_angle *= 1.0 - (@angular_friction * (1.0 - delta))
      entity.vel_x     *= 1.0 - (@friction * (1.0 - delta))
      entity.vel_y     *= 1.0 - (@friction * (1.0 - delta))


      # now reset acceleration (they are single use)
      @accel = 0.0
      @angular_accel = 0.0
    end

  end

end
