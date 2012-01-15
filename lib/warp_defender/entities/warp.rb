module Entities
  class Warp < Entity
    attr_reader :current_defense, :max_defense
    
    def initialize(x, y)
      super(:x => x, :y => y,
            :z_order => Utils::ZOrder::Warps,
            :sprite => "warp")
      
      @max_defense = @current_defense = 10

      @render.state = "idle"

      @defense_bar = GUI::Bar.new(:width => width/2,
                                  :height => 5,
                                  :outer_color => Gosu::Color.rgba(0, 0, 0, 160),
                                  :left_color => Gosu::Color.rgba(65, 108, 112, 220),
                                  :right_color => Gosu::Color.rgba(65, 108, 112, 220))

    end
    
    def map_color; Gosu::Color::BLUE; end
    def map_draw?; true; end

    def update(delta)
      #@angle += 360/90*delta
    end

    def draw(delta)
      @render.draw(self, delta)
      @defense_bar.draw(@x-width/4,
                        15 + @y + height/2, 
                        :width => width/2,
                        :current => @current_defense,
                        :max => @max_defense,
                        :z_order => 1)
      
    end

    def warp(entity)
      $window.sounds[:warp].play
      entity.kill
      if @render.state != "warp" or @render.animations_finished?
        @render.state = "warp"
      end

      @current_defense -= 1.0
    end

  end

end
