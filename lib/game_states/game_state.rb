module GameStates

  class GameState
 
    def initialize(game_engine)
      @game_engine = game_engine
    end

    def update
    end
    
    def draw
    end

    def leave
      @game_engine.clear_state!(self.class)
    end

    def button_down(id)
    end

    def button_up(id)
    end

    private

    def overlay(color, message = "")
      pos_x = $window.native_width / 2
      pos_y = $window.native_height / 2

      $window.draw_rect(pos_x, pos_y,
                        $window.native_width, $window.native_height,
                        color, Utils::ZOrder::Infinity)

      $window.fonts[:menu].draw_rel(message, pos_x, pos_y - 40, Utils::ZOrder::Infinity,
                                    0.5, 1, 2, 2, Gosu::Color::WHITE)
    end

  end

end
