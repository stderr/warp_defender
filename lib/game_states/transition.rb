module GameStates

  class Transition < GameState

    def initialize(game_engine, to_game_state, transition)
      raise ArgumentError, "#{to_game_state.class} is not a GameState." unless to_game_state.is_a?(GameState)
      super(game_engine)
      
      @to_game_state = to_game_state
      @transition = transition
    end
    
    def draw
      @to_game_state.draw
      @transition.draw
    end

    def update
      @transition.update
    end

    def finished?
     @transition.finished?
    end

  end

end
