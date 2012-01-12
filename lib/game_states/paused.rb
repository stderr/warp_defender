module GameStates

  class Paused < GameState

    def initialize(game_engine)
      super(game_engine)
    end

    def draw
      @game_engine.play_state.draw
      color = Gosu::Color.from_ahsv(200, 0, 0, 0)

      overlay(color, "Paused")
    end

    def button_down(id)
      case id
      when Gosu::KbEscape, Gosu::GpButton9
        $window.music[:theme].play(true)
        @game_engine.unpause!

      when Gosu::KbQ
        # temporary until we have a menu in the pause screen
        Process.exit
      end
    end
  end

end

