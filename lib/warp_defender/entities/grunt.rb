module Entities

  class Grunt < Entity
    attr_reader :velocity, :target

    def initialize(target)
      super(:z_order => Utils::ZOrder::Player,
            :sprite => "grunt",
            :physics => :dynamic)

      @behavior = Behaviors::Hunt.new(self, :turn_radius => 5.0)
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
      @angle = @behavior.angle
      @vel_x = Gosu::offset_x(@angle, @behavior.velocity)
      @vel_y = Gosu::offset_y(@angle, @behavior.velocity)
    end

  end

end
