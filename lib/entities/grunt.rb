module Entities

  class Grunt < Entity
    include Sprite

    def initialize(window, target)
      super(window, target)
      @behavior = Behaviors::Hunt.new(self)
      @image = @window.animations[:grunt].first

      @width = @window.animations[:warp].first.width
      @height = @window.animations[:warp].first.height
      @z_order = Utils::ZOrder::Player

      animate(:grunt, :loop, 100)
    end

    def spawn(width, height)
      super(width, height)
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

  end

end
