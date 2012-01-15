module Entities

  class Grunt < Entity
    attr_reader :velocity, :target

    def initialize(target)
      super(:z_order => Utils::ZOrder::Player,
            :sprite => "grunt",
            :physics => :dynamic)

      @behavior = Behaviors::Hunt.new(self)
      @target = target

      @render.state = "idle"
      #@physics = Physics::Dynamic.new(:sprite => sprite_def,
      #                                :friction => 0, :angular_friction => 0)
    end

    def velocity; @behavior.velocity; end
    def enemy?; true; end
    def map_draw?; true; end
    def spawn(width, height); super(width, height); end


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

  end

end
