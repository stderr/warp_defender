module GUI

  class MiniMap < BaseElement

    def initialize(options = {}, &on_activate)
      super(options, &on_activate)
    end

    def draw(x, y, options = {})
      super(x, y, options)
      
      $window.draw_rect(x, y, 
                        @options[:width], @options[:height],
                        @options[:color], Utils::ZOrder::HUD)

      @options[:entities].each do |entity|
        next if !entity.map_draw? || entity.off_screen?
        
        # Compensate for rectangle drawing from center
        pos_x = (x-@options[:width]/2) + ((entity.x * @options[:width]) / $window.width) 
        pos_y = (y-@options[:height]/2) + ((entity.y * @options[:height]) / $window.height)

        $window.draw_rect(pos_x, pos_y, 5, 5, entity.map_color, Utils::ZOrder::HUDOverlay)
      end

    end

  end

end
