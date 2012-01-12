module GameStates

  class GameOver < GameState
    
    def initialize(game_engine)
      super(game_engine)
      
      $window.music[:theme].stop
    end

    def draw
      @game_engine.play_state.draw
      color = Gosu::Color.from_ahsv(200, 0, 0, 0)
      
      overlay(color, "You Lose!")
    end

    def button_down(id)
      case id 
      when Gosu::KbQ
        Process.exit
      else
        @game_engine.menu!
        @game_engine.clear_playing!
      end

    end

  end

end
