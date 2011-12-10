module Entities

  class Grunt < Entity
    include Sprite
    attr_reader :velocity, :target

    def initialize(target)
      super(:width => frame_width(:grunt),
            :height => frame_height(:grunt),
            :z_order => Utils::ZOrder::Player)

      @behavior = Behaviors::Hunt.new(self)
      @target = target

      @physics = Physics::Dynamic.new(0, 0)


      animate(:grunt, :loop, 100)
    end

    def spawn(width, height)
      super(width, height)
    end

    def update(delta)
      aim(delta)
      @physics.update(self, delta)
    end

    def aim(delta)
      new_angle = @behavior.angle
      if new_angle < 0
      	new_angle = 360 - new_angle.abs
      end

      # not time scaled but this is temporary code
      if @angle > new_angle
      	@angle -= 240 * ((340 - @behavior.velocity) / 240) * delta
      elsif @angle < new_angle
      	@angle += 240 * ((340 - @behavior.velocity) / 240) * delta
      end

      if @angle < 0
      	@angle = 360 - @angle.abs
      end

      @vel_x = Gosu::offset_x(@angle, @behavior.velocity)
      @vel_y = Gosu::offset_y(@angle, @behavior.velocity)
    end

    def velocity
      @behavior.velocity
    end

  end

end
