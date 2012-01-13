module GameStates

  class Paused < GameState

    def initialize(game_engine)
      super(game_engine)

      controls do
        press(Gosu::KbEscape) do
          $window.music[:theme].play(true)
          game_engine.unpause!
        end

        press(Gosu::KbQ) do
          Process.exit
        end
      end
    end

    def draw
      @game_engine.play_state.draw
      color = Gosu::Color.from_ahsv(200, 0, 0, 0)

      overlay(color, "Paused")
    end

    def button_down(id)
      super(id)
    end
  end

end

