module GUI

  class BaseElement
    attr_reader :options
    
    def initialize(options = {}, &on_activate)
      @options = {
        :text => ""
      }.merge!(options)

      @on_activate = on_activate if block_given?
    end
    
    def draw(window, x, y, options = {})
      # draw can reset the options instance variable due to 
      # needing window

      @options.merge!({
        :font => window.fonts[:menu]
      }).merge!(options)

    end

    def activate
      @on_activate.call(self)
    end

  end

end
