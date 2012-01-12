module GameStates

  class LoadLevel < GameState

    def initialize(game_engine)
      super(game_engine)
      
      @level = @game_engine.level

      @timer = Utils::Timer.new
      @intro_start = Gosu::milliseconds
    end

    def draw
      @level.draw_intro
    end

    def update
      if @level.intro_finished?(Gosu::milliseconds - @intro_start)
        @game_engine.start_playing!
      end
    end

  end

end
