module Entities

  class Entity
    attr_accessor :x, :y, :target

    def initialize(window, target)
      @window = window
      @target = target

      @behavior = Behaviors::Behavior.new(self)
      @angle = 0.0
    end

    def spawn
      @behavior.spawn
    end

    def move 
      @behavior.move
    end

    def draw
    end

  end

end
