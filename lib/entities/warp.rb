module Entities
  class Warp < Entity
    attr_reader :current_defense, :max_defense
    include Sprite
    
    def initialize(x, y)
      super(:x => x, :y => y,
            :width => frame_width(:warp),
            :height => frame_height(:warp),
            :z_order => Utils::ZOrder::Warps)
      
      @max_defense = @current_defense = 10
      draw_frame(:warp, 0)
      @defense_bar = GUI::Bar.new(:width => @width/2,
                                  :height => 5,
                                  :outer_color => Gosu::Color.rgba(0, 0, 0, 160),
                                  :left_color => Gosu::Color::RED,
                                  :right_color => Gosu::Color::GREEN)
    end

    def update(delta)
      @angle += 360/90*delta
    end

    def draw
      super
      @defense_bar.draw(@x-@width/4, 15 + @y + @height/2, 
                        :current => @current_defense,
                        :max => @max_defense,
                        :z_order => 1)
      
    end

    def warp(entity)
      $window.sounds[:warp].play
      animate(:warp, :once, 100,
              lambda { self.animate(:warp, :once_reverse, 100) })
      entity.kill
      @current_defense -= 1.0
    end
    
    def map_color
      Gosu::Color::BLUE
    end

  end

end
