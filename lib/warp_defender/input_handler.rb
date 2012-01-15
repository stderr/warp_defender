module Input

  # The Handler is included in the object you want to have input handling context
  # dispatch_constant_input is for #update loops, whereas dispatch_input is for the button_down / button_up callbacks

  module Handler

    def controls(&block)
      @context = Context.new(self)
      
      @context.instance_eval(&block) if block_given?
    end

    def dispatch_constant_input
      @context.hold_dispatch
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
      add_input(key_id, :press, &block)
    end

    def hold(key_id, &block)
      add_input(key_id, :hold, &block)
    end

    def release(key_id, &block)
      add_input(key_id, :release, &block)
    end

    def hold_left(&block)
      hold(Gosu::KbLeft,  &block)
    end

    def hold_right(&block)
      hold(Gosu::KbRight, &block)
    end

    def hold_up(&block)
      hold(Gosu::KbUp, &block)
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

    def sink
      @base_object
    end
      
    def hold_dispatch
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

    private

    def default?(context)
      @inputs[context].key?(DEFAULT)
    end

    def add_input(key_id, context, &block)
      @inputs[context][key_id] = block
    end

  end

end
