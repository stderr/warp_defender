module GameStates
  
  class Credits < GameState
    def initialize(window, game_engine)
      super(window, game_engine)
    end

    def button_down(id)
      @window.close
    end

  end

end

