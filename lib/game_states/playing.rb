module GameStates

  class Playing < GameState
    
    def initialize(window, game_engine)
      super(window, game_engine)
      @player = Player.new(window)
      
      @bullets = []
      @entities = []
      @explosions = []
      
      @timer = Utils::Timer.new
    end

  end

end
