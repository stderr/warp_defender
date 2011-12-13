module GUI

  class MiniMap < BaseElement

    def initialize(options = {}, &on_activate)
      super(options, &on_activate)
    end

    def draw(x, y, options = {})
      super(x, y, options)

      $window.draw_quad(x, y, @options[:color],
                       x+@options[:width], y, @options[:color],
                       x+@options[:width], y-@options[:height], @options[:color],
                       x, y-@options[:height], @options[:color],
                       Utils::ZOrder::HUD)

      @options[:entities].each do |entity|
        next if entity.is_a?(Entities::Bullet) || entity.off_screen?

        pos_x = x+(entity.x/10)
        pos_y = (y - @options[:height]) + (entity.y/10)

        $window.draw_quad(pos_x, pos_y, entity.map_color,
                         pos_x+2, pos_y, entity.map_color,
                         pos_x+2, pos_y-2, entity.map_color,
                         pos_x, pos_y-2, entity.map_color,
                         Utils::ZOrder::HUDOverlay)
      end

    end

  end

end
