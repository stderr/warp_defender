module Input

  module Handler

    def controls(&block)
      @context = Context.new(self)
      
      @context.instance_eval(&block) if block_given?
    end

    def dispatch_constant_input
      @context.dispatch_hold
    end

    def dispatch_input(key_id, context = :press)
      @context.dispatch(key_id, context)
    end    

  end

  class Context

    def initialize(base_object)
      @base_object = base_object

      @inputs = {}

      @inputs[:press] = {}
      @inputs[:release] = {}
      @inputs[:hold] = {}
    end

    def press(key_id, context = :press, &block)
      @inputs[context][key_id] = block
    end

    def hold_left(&block)
      press(Gosu::KbLeft, :hold, &block)
    end

    def hold_right(&block)
      press(Gosu::KbRight, :hold, &block)
    end

    def hold_up(&block)
      press(Gosu::KbUp, :hold, &block)
    end

    def press_enter(&block)
      press(Gosu::KbReturn, &block)
    end

    def press_arrow(direction, &block)
      press(Gosu.const_get("Kb#{direction.to_s.capitalize}"), &block)
    end

    def default(context = :hold, &block)
      @inputs[context][-1] = block
    end

    def default?(context)
      @inputs[context].key?(-1)
    end

    def sink
      @base_object
    end
      
    def dispatch_hold
      return @inputs[:hold][-1].call unless !default?(:hold) || @inputs[:hold].any? { |k,v| $window.button_down?(k) } 

      @inputs[:hold].each do |key, callback|
        callback.call if $window.button_down?(key)
      end
    end

    def dispatch(key_id, context = :press)
      return unless @inputs[context].key?(key_id)
      @inputs[context][key_id].call
    end
    
  end

end
