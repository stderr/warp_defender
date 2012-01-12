module GameStates

  class GameCompleted < GameState

    def initialize(game_engine)
      super(game_engine)
    end

    def draw
      @game_engine.play_state.draw
      color = Gosu::Color.from_ahsv(200, 0, 0, 0)

      overlay(color, "You Win!")
    end

    def button_down(id)
      case id
      when Gosu::KbQ
        Process.exit
      end
    end
  end

end
