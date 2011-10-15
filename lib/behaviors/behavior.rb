module Behaviors
  
  class Behavior

    def initialize(entity)
      @entity = entity
    end

    def spawn
      case rand(3)
        when 0 then @entity.x = 0 && @entity.y = rand(Gosu::screen_height)
        when 1 then @entity.x = Gosu::screen_width && @entity.y = rand(Gosu::screen_height)
        when 2 then @entity.x = rand(Gosu::screen_width) && @entity.y = 0
        when 3 then @entity.x = rand(Gosu::screen_width) && @entity.y = Gosu::screen_height
      end
    end

    def move
    end

  end

end
