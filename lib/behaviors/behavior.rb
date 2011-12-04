module Behaviors
  
  class Behavior

    def initialize(entity)
      @entity = entity
    end

    def spawn(width, height)
      case rand(4)
        when 0 then @entity.x = 0 && @entity.y = height
        when 1 then @entity.x = 0 && @entity.y = 0
        when 2 then @entity.x = width && @entity.y = 0
        when 3 then @entity.x = width && @entity.y = height
      end
    end

    def position
    end

    def velocity
    end

    def angle
    end

  end

end
