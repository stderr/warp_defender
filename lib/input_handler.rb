module Input

  module Handler

    def controls(&block)
      @context = Context.new(self)
      
      @context.instance_eval(&block) if block_given?
    end

    def dispatch_input(key_id)
      @context.dispatch(key_id)
    end

  end

  class Context

    def initialize(base_object)
      @base_object = base_object
      @inputs = {}
    end

    def press(key_id, &block)
      @inputs[key_id] = block
    end

    def press_enter(&block)
      press(Gosu::KbReturn, &block)
    end

    def base_object
      @base_object
    end
      
    def dispatch(key_id)
      return unless @inputs.key?(key_id)
      @inputs[key_id].call
    end
    
  end

end
