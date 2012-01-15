module Behaviors

  class Hunt < Behavior
    attr_reader :velocity

    def initialize(entity)
      super(entity)
      # distance per second to move
      @velocity = Gosu::random(80, 200)
    end

    def spawn(width, height)
      super(width, height)
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
