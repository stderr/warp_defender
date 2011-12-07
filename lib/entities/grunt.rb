module Entities

  class Grunt < Entity
    include Sprite
    attr_reader :velocity

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

    def update(delta)
      move(delta)
    end

    def move(delta)
      new_angle = @behavior.angle
      if new_angle < 0
      	new_angle = 360 - new_angle.abs
      end

      @velocity = @behavior.velocity

      # not timescaled but this is temporary code
      if @angle > new_angle
      	@angle -= 240 * ((340 - @velocity) / 240) * delta
      elsif @angle < new_angle
      	@angle += 240 * ((340 - @velocity) / 240) * delta
      end

      if @angle < 0
      	@angle = 360 - @angle.abs
      end

      @x += Gosu::offset_x(@angle, @velocity) * delta
      @y += Gosu::offset_y(@angle, @velocity) * delta
    end

  end

end
