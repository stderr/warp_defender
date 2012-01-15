module Behaviors

  class Beeline < Behavior
    def initialize(entity)
      super(entity)
    end

    def spawn
      super
    end

    def position
    end

    def angle
      distance_x = (@entity.target.x - @entity.x)
      distance_y = (@entity.target.y - @entity.y)

      Math.atan2(distance_y, distance_x).radians_to_gosu
    end

  end

end
