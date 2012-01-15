module Behaviors

  class Hunt < Behavior
    attr_reader :velocity

    def initialize(entity, options = {})
      super(entity)
      
      @turn_radius = options[:turn_radius] || 1.0
      # distance per second to move
      @velocity = Gosu::random(80, 200)
    end

    def spawn(width, height)
      super(width, height)
    end

    def position
    end

    def angle
      distance_x = @entity.target.x - @entity.x
      distance_y = @entity.target.y - @entity.y
      
      optimum_angle = Math.atan2(distance_y, distance_x).radians_to_gosu

      diff = Gosu::angle_diff(@entity.angle, optimum_angle)

      if diff > 1.0 
        turn_radius = diff < @turn_radius ? diff : @turn_radius
        @entity.angle + turn_radius
        
      elsif diff < -1.0
        turn_radius = diff.abs < @turn_radius ? diff.abs : @turn_radius
        @entity.angle - turn_radius
      else
        @entity.angle
      end
    end

  end

end
