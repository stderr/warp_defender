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
      pos_x = $window.width/2
      pos_y = $window.height/2
      
      $window.draw_rect(pos_x, pos_y, 
                        $window.width, $window.height, 
                        color, Utils::ZOrder::PauseOverlay)
      
      $window.fonts[:menu].draw_rel("Game Over", pos_x, pos_y, 
                                    Utils::ZOrder::PauseOverlay, 
                                    0.5, 1, 2, 2, Gosu::Color::RED)
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
