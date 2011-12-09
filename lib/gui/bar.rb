module GUI
  class Bar < BaseElement
    
    def initialize(options = {}, &on_activate)
      super(options, &on_activate)
    end

    def draw(window, x, y, options = {})
      super(window, x, y, options)

      window.draw_quad(x, y, @options[:outer_color],
                       x+@options[:width], y, @options[:outer_color],
                       x+@options[:width], y-@options[:height], @options[:outer_color],
                       x, y-@options[:height], @options[:outer_color],
                       Utils::ZOrder::HUD)
      
      inner_bar(window, x, y)
    end

    private

    def inner_bar(window, x, y)
      @options[:current] = @options[:current] < 0 ? 0 : @options[:current] 

      padding = @options[:height] / 10.0
      window.draw_quad(x+padding, y-padding, @options[:left_color],
                       x+(@options[:width] * (@options[:current] / @options[:max]).to_f)-padding, y-padding, @options[:right_color],
                       x+(@options[:width] * (@options[:current] / @options[:max]).to_f)-padding, (y-@options[:height])+padding, @options[:right_color],
                       x+padding, (y-@options[:height])+padding, @options[:left_color],
                       Utils::ZOrder::HUDOverlay)
      
    end

  end
end
