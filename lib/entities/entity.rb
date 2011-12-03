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

  def collides_with?(other)
    @x + width > other.x and @x < other.x + other.width and
      ((@y+height > other.y and @y < other.y+other.height) or (@y < other.y+other.height and @y+height > other.y))
  end


  end

end
