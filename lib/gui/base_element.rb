module GUI

  class BaseElement
    attr_reader :options
    
    def initialize(options = {}, &block)
      @options = {
        :text => ""
      }.merge!(options)

      @event_handler = EventHandler.new(self)
      @event_handler.instance_eval(&block) if block_given?
    end
    
    def draw(x, y, options = {})
      # draw can reset the options instance variable due to 
      # needing window

      @options.merge!({
        :font => $window.fonts[:menu]
      }).merge!(options)

    end
    
    def input(id)
      @event_handler.activate(id)
    end
  end

  class EventHandler
    attr_reader :element

    def initialize(element)
      @element = element
      @keys = {}
    end

    def press(key_id, &block)
      @keys[key_id] = block
    end
    
    def press_enter(&block)
      press(Gosu::KbReturn, &block)
    end
    
    def activate(key_id)
      return unless @keys.key?(key_id)
      @keys[key_id].call
    end
  end

end
