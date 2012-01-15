module GameStates

  class StateManager
    
    def initialize
      @states = []
    end

    def add(state)
      @states.push(state)
    end

    def pop
      @states.pop
    end

    def current
      @states.last
    end

    def last_play_state
      @states.reverse.detect { |state| state.class == Playing }
    end

    def remove_all(state_type)
      @states.reject! { |state| state.is_a? state_type }
    end

  end

end
