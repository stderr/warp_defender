module Behaviors
  
  class Behavior

    def initialize(entity)
      @entity = entity
    end

    def spawn
      case rand(3)
        when 0 then @entity.x = 0 && @entity.y = rand(1200)
        when 1 then @entity.x = 1600 && @entity.y = rand(1200)
        when 2 then @entity.x = rand(1600) && @entity.y = 0
        when 3 then @entity.x = rand(1600) && @entity.y = 1200
      end
    end

    def move
    end

  end

end
