module GameStates

  class GameOver < GameState
    
    def initialize(game_engine)
      super(game_engine)
      @play_state = @game_engine.states.reverse.detect { |state| state.class == Playing }

      $window.music[:theme].stop
    end

    def draw
      @play_state.draw
      color = Gosu::Color.from_ahsv(200, 0, 0, 0)
      
      overlay(color, "You Lose!")
    end

    def button_down(id)
      case id 
      when Gosu::KbQ
        Process.exit
      else
        @game_engine.states.push(MainMenu.new(@game_engine))
        @game_engine.states.reject! { |state| state.class == Playing }
      end

    end

  end

end
