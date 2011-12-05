module Entities

  class Grunt < Entity
    include Sprite

    def initialize(window, target)
      super(window, target)
      @behavior = Behaviors::Hunt.new(self)

      @width = @window.animations[:grunt].first.width
      @height = @window.animations[:grunt].first.height
      @z_order = Utils::ZOrder::Player

      animate(:grunt, :loop, 100)
    end

    def spawn(width, height)
      super(width, height)
    end

    def move
      new_angle = @behavior.angle
      if new_angle < 0
      	new_angle = 360 - new_angle.abs
      end

      if @angle > new_angle
      	@angle -= 5
      elsif @angle < new_angle
      	@angle += 5
      end

      if @angle < 0
      	@angle = 360 - @angle.abs
      end

      @velocity = @behavior.velocity

      @x += Gosu::offset_x(@angle, @velocity)
      @y += Gosu::offset_y(@angle, @velocity)
    end

  end

end
