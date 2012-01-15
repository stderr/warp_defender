module Behaviors
  class Homing < Behavior
    attr_reader :velocity
    
    def initialize(entity)
      super(entity)
    end

    def angle
      distance_x = @entity.target.x - @entity.x
      distance_y = @entity.target.y - @entity.y
      
      optimum_angle = Math.atan2(distance_y, distance_x).radians_to_gosu
      #optimum_angle += optimum_angle if optimum_angle < 0 

      diff = Gosu::angle_diff(@entity.angle, optimum_angle)

      if diff > 1.0 
        @entity.angle + 3.0
      elsif diff < -1.0
        @entity.angle - 3.0
      else
        @entity.angle
      end

    end
  end
end
