module GameStates
  
  class Credits < GameState
    def initialize(game_engine)
      super(game_engine)
    end

    def button_down(id)
      $window.close
    end

  end

end

