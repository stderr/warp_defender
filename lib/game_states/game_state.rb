module GameStates

  class GameState
 
    def initialize(window, game_engine)
      @window = window
      @game_engine = game_engine
    end

    def update
    end
    
    def draw
    end

    def leave
      @game_engine.states.reject! { |state| state.class == self.class }
    end

    def button_down(id)
    end

    def button_up(id)
    end

  end

end
