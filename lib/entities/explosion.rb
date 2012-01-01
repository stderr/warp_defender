module Entities
  class Explosion < Entity
    
    def initialize(x, y, vel_x=0.0, vel_y=0.0)
      super(:x => x, :y => y,
            :vel_x => vel_x, :vel_y => vel_y,
            :z_order => Utils::ZOrder::Explosion,
            :sprite => "explosion",
            :physics => :dynamic)
      
      #@physics = Physics::Dynamic.new(:friction => 0.01)
      @render.state = "explode"
    end

    def update(delta)
      @physics.update(self, delta)
    end

    def draw(delta)
      if @render.state == "explode" and @render.animations_finished?
      	@render.state = "implode"
      elsif @render.state == "implode" and @render.animations_finished?
        kill
        return
      end
      @render.draw(self, delta)
    end

  end

end
