module GameStates

	class Paused < GameState

    def initialize(window, game_engine)
			super(window, game_engine)
			@play_state = @game_engine.states.reverse.detect { |state| state.class == GameState::Playing }
		end

		def draw
			@play_state.draw
			color = Gosu::Color.from_ahsv(200, 0, 0, 0)
			@window.draw_quad(0, 0, color,
												@window.width, 0, color,
												0, @window.height, color,
												@window.width, @window.height, color)

		end

	end

end

