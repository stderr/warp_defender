module GameStates

  class GameCompleted < GameState

    def initialize(game_engine)
      super(game_engine)
      @play_state = @game_engine.states.reverse.detect { |state| state.class == Playing }
    end

    def draw
      @play_state.draw
      color = Gosu::Color.from_ahsv(200, 0, 0, 0)

      $window.draw_rect($window.native_width/2, $window.native_height/2, 
                        $window.native_width, $window.native_height, 
                        color, Utils::ZOrder::PauseOverlay)
                        
      position_x = $window.native_width / 2
      position_y = $window.native_height / 2
      $window.fonts[:menu].draw_rel("You Win!", position_x, position_y - 40, Utils::ZOrder::PauseOverlay, 0.5, 1, 2, 2)
    end

    def button_down(id)
      case id
      when Gosu::KbQ
        Process.exit
      end
    end
  end

end
