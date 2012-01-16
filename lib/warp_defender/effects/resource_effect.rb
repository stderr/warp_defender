module Effects

  class ResourceEffect
    COLOR = Gosu::Color.rgb(255, 255, 255)

    def initialize(resource, x, y)
      @lifetime = 100
      @resource = resource
      @finished = false
      @x, @y = x, y
    end

    def finished?
      @finished
    end

    def update(delta)
      if @lifetime > 0
        change = delta * 20.0
        
        @lifetime -= change
        if @lifetime <= 0 
          @finished = true
        end
      end

    end

    def draw
      color = COLOR.dup
      color.alpha = (@lifetime * 1.5).to_i
      $window.fonts[:resource_effect].draw_rel(@resource, @x, @y + (@lifetime - 100) / 0.5, 
                                               Utils::ZOrder::HUD, 0.5, 0.5, 1.0, 1.0, color)
    end

  end

end
