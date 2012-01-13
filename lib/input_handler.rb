module Input

  # The Handler is included in the object you want to have input handling context
  # dispatch_context_input is for #update loops, whereas dispatch_input is for the button_down / button_up callbacks

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

  # The Context class handles the storage and insertion of input callbacks. 
  # A DSL allows you to easily declare callbacks in the Handler's control block
  class Context
    DEFAULT = -1

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
    
    def press_quit(&block)
      press(Gosu::KbQ, &block)
    end

    def press_arrow(direction, &block)
      press(Gosu.const_get("Kb#{direction.to_s.capitalize}"), &block)
    end

    def default(context = :hold, &block)
      @inputs[context][DEFAULT] = block
    end

    def default?(context)
      @inputs[context].key?(DEFAULT)
    end

    def sink
      @base_object
    end
      
    def dispatch_hold
      return @inputs[:hold][DEFAULT].call unless !default?(:hold) || @inputs[:hold].any? { |k,v| $window.button_down?(k) } 

      @inputs[:hold].each do |key, callback|
        callback.call if $window.button_down?(key)
      end
    end

    def dispatch(key_id, context = :press)
      return nil unless @inputs[context].key?(key_id) || default?(context)
      return @inputs[context][DEFAULT].call unless @inputs[context].key?(key_id)

      @inputs[context][key_id].call
    end
    
  end

end
