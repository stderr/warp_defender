module GUI

  class Checkbox < BaseElement
    attr_accessor :checked
    
    def initialize(options = {}, &on_activate)
      super(options, &on_activate)
      
      @checked = false
    end
    
    def draw(window, x, y, options = {})
      super(window, x, y, options)
      
      @options[:font].draw_rel(@options[:text], x, y, 0, 0.5, 1, 1, 1, @options[:color])

      if checked
        window.images[:checked].draw_rot(x+100, y-18, 0, 0)
      else
        window.images[:unchecked].draw_rot(x+100, y-18, 0, 0)
      end
    end

  end

end
