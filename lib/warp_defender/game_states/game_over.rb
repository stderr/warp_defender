module GameStates

  class GameOver < GameState
    
    def initialize(game_engine)
      super(game_engine)
      
      $window.music[:theme].stop

      controls do 
        press_quit do
          Process.exit
        end
        
        default(:press) do
          game_engine.menu!
        end

      end

    end

    def draw
      @game_engine.play_state.draw
      color = Gosu::Color.from_ahsv(200, 0, 0, 0)
      
      overlay(color, "You Lose!")
    end

    def button_down(id)
      super(id)
    end

  end

end
