module GUI

  class Checkbox < BaseElement
    attr_accessor :checked
    
    def initialize(options = {}, &on_activate)
      super(options, &on_activate)
      
      @checked = @options[:value]
    end
    
    def draw(x, y, options = {})
      super(x, y, options)
      
      opt_x = [(x + (@options[:font].text_width(@options[:text]) / 2) + 80), x + 230].max

      @options[:font].draw_rel(@options[:text], x, y, 0, 0.5, 1, 1, 1, @options[:color])

      opt_text = checked ? "Yes" : "No"
      
      @options[:font].draw_rel(opt_text, opt_x, y, 0, 0.0, 1, 1, 1, @options[:color])
    end

  end

end
