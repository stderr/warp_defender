module GUI
  class Bar < BaseElement
    
    def initialize(options = {}, &on_activate)
      super(options, &on_activate)
    end

    def draw(x, y, options = {})
      super(x, y, options)
      if @options.has_key?(:outer_color)
        $window.draw_quad(x, y, @options[:outer_color],
                          x+@options[:width], y, @options[:outer_color],
                          x+@options[:width], y-@options[:height], @options[:outer_color],
                          x, y-@options[:height], @options[:outer_color],
                          @options[:z_order] || Utils::ZOrder::HUD)
      end
      inner_bar(x, y)
    end

    private

    def inner_bar(x, y)
      @options[:current] = @options[:current] < 0 ? 0 : @options[:current] 

      padding = @options[:height] / 10.0
      $window.draw_quad(x+padding, y-padding, @options[:left_color],
                       x+(@options[:width] * (@options[:current] / @options[:max]).to_f)-padding, y-padding, @options[:right_color],
                       x+(@options[:width] * (@options[:current] / @options[:max]).to_f)-padding, (y-@options[:height])+padding, @options[:right_color],
                       x+padding, (y-@options[:height])+padding, @options[:left_color],
                       @options[:z_order] || Utils::ZOrder::HUDOverlay)
      
    end

  end
end
