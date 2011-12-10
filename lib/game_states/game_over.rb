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
      $window.draw_quad(0, 0, color,
                        $window.width, 0, color,
                        0, $window.height, color,
                        $window.width, $window.height, color,
                        Utils::ZOrder::PauseOverlay)
      
      position_x = $window.width / 2
      position_y = $window.width / 2
      $window.fonts[:menu].draw_rel("Game Over", position_x, position_y-40, 0, 0.5, 1, 2, 2, Gosu::Color::RED)
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
