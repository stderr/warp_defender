module Entities
  class Warp < Entity
    attr_reader :current_defense, :max_defense
    include LegacySprite
    
    def initialize(x, y)
      super(:x => x, :y => y,
            :width => frame_width(:warp_1),
            :height => frame_height(:warp_1),
            :z_order => Utils::ZOrder::Warps,
            :scale => 0.5)
      
      @max_defense = @current_defense = 10

      draw_frame(:warp_1, 0, @z_order, :understructure)
      draw_frame(:warp_2, 0, @z_order+1, :glow)
      draw_frame(:warp_3, 0, @z_order+2, :underspiral)
      draw_frame(:warp_4, 0, @z_order+3, :overspiral)
      draw_frame(:warp_5, 0, @z_order+4, :overstructure)

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
      @defense_bar.draw(@x-@width*@scale/4,
                        15 + @y + @height*@scale/2, 
                        :width => @width*@scale/2,
                        :current => @current_defense,
                        :max => @max_defense,
                        :z_order => 1)
      
    end

    def warp(entity)
      $window.sounds[:warp].play
      #animate(:warp, :once, 100, @z_order,
      #        lambda { self.animate(:warp, :once_reverse, 100, @z_order) })
      entity.kill

      @current_defense -= 1.0
    end
    
    def map_color
      Gosu::Color::BLUE
    end

  end

end
