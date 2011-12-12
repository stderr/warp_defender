module GameStates

  class LoadLevel < GameState

    def initialize(game_engine)
      super(game_engine)
      
      @level = @game_engine.level
    end

    def draw
      @level.draw_intro
    end

    def update
      @game_engine.states.push(GameStates::Playing.new(@game_engine)) if @level.intro_finished?
    end

  end

end
