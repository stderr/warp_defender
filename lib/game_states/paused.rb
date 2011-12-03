module GameStates

	class Paused < GameState

    def initialize(window, game_engine)
			super(window, game_engine)
			@play_state = @game_engine.states.reverse.detect { |state| state.class == Playing }
		end

		def draw
			@play_state.draw
			color = Gosu::Color.from_ahsv(200, 0, 0, 0)
			@window.draw_quad(0, 0, color,
												@window.width, 0, color,
												0, @window.height, color,
												@window.width, @window.height, color,
												Utils::ZOrder::PauseOverlay)

      position_x = @window.width / 2
      position_y = @window.height / 2
      @window.fonts[:menu].draw_rel("Paused", position_x, position_y - 40, 0, 0.5, 1, 2, 2)

		end

    def button_down(id)
    	if id == Gosu::KbEscape
    		leave
			end
    end
	end

end

