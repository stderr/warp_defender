module GameStates

  class GameCompleted < GameState

    def initialize(game_engine)
      super(game_engine)
      
      controls do 
        press(Gosu::KbQ) do
          Process.exit
        end
      end

    end

    def draw
      @game_engine.play_state.draw
      color = Gosu::Color.from_ahsv(200, 0, 0, 0)

      overlay(color, "You Win!")
    end

    def button_down(id)
      super(id)
    end
  end

end
