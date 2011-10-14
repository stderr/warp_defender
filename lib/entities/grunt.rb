module Entities

  class Grunt < Entity
    
    def initialize(window, target)
      super(window, target)
      @behavior = Behaviors::Hunt.new(self)
    end

    def spawn
      super
    end

    def move
      @angle = @behavior.angle

      @x += Gosu::offset_x(@angle, 2.5)
      @y += Gosu::offset_y(@angle, 2.5)
    end

    def draw
      img = @window.animations[:player][Gosu::milliseconds / 100 % @window.animations[:player].size]
      img.draw_rot(@x, @y, Utils::ZOrder::Player, @angle)
    end

  end

end
