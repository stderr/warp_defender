module Entities

  class Grunt < Entity
    include Sprite

    def initialize(window, target)
      super(window, target)
      @behavior = Behaviors::Hunt.new(self)
      @image = @window.animations[:grunt].first
    end

    def spawn
      super
    end

    def move
      @angle = @behavior.angle
      @velocity = @behavior.velocity

      @x += Gosu::offset_x(@angle, @velocity)
      @y += Gosu::offset_y(@angle, @velocity)
    end

    def width
      @image.width
    end

    def height
      @image.height
    end

    def draw
#      img = @window.animations[:grunt][Gosu::milliseconds / 100 % @window.animations[:grunt].size]
#      img.draw_rot(@x, @y, Utils::ZOrder::Player, @angle)
      draw_animation(:grunt, Utils::ZOrder::Player) unless dead?
    end

  end

end
