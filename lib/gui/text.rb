module GUI

  class Text < BaseElement

    def initialize(options = {}, &on_activate)
      super(options, &on_activate)

      @options = {
        :text => ''
      }.merge!(options)
    end

    def draw(x, y, options = {})
      super(x, y, options)

      @options[:font].draw_rel(@options[:text], x, y, 0, 0.5, 1, 1, 1, @options[:color])
    end

  end

end
