module Entities
  class Blast < Entity
    
    def initialize(x, y, vel_x=0.0, vel_y=0.0)
      super(:x => x, :y => y,
            :vel_x => vel_x, :vel_y => vel_y,
            :z_order => Utils::ZOrder::Explosion,
            :sprite => "blast",
            :physics => :dynamic)
      
      #@physics = Physics::Dynamic.new(:friction => 0.01)
      @render.state = "explode"
    end

    def kill
      # temporary hack
      if @render.animations_finished?
      	super()
      end
    end

    def update(delta)
      @physics.update(self, delta)
    end

    def draw(delta)
      if @render.animations_finished?
        kill
        return
      end
      @render.draw(self, delta)
    end

  end

end
