module Entities

  class Entity
    attr_accessor :x, :y, :target

    def initialize(window, target)
      @window = window
      @target = target

      @behavior = Behaviors::Behavior.new(self)
      @angle = 0.0
      
      @dead = false
    end

    def spawn
      @behavior.spawn
    end

    def move 
      @behavior.move
    end

    def draw
    end

    def width
    end

    def height
    end

    def kill
      @dead = true
    end

    def dead?
      @dead
    end

  end

end
