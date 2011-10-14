module GameStates

  class Playing < GameState
    
    def initialize(window, game_engine)
      super(window, game_engine)
      @player = Player.new(window)
      @player.move_to(800, 600)

      @bullets = []
      @entities = []
      @explosions = []
      @timer = Utils::Timer.new
    end

    def update
      if @window.button_down?(Gosu::KbLeft) || @window.button_down?(Gosu::GpLeft)
        @player.turn_left
      end

      if @window.button_down?(Gosu::KbRight) || @window.button_down?(Gosu::GpRight)
        @player.turn_right
      end

      if @window.button_down?(Gosu::KbUp)
        @player.accelerate
      end

      @player.move
    end

    def draw
      @window.images[:background].draw(0, 0, Utils::ZOrder::Background)
      
      @player.draw

    end

    def button_down(id)
       case id
         when Gosu::KbEscape then @game_engine.state = GameStates::Menu.new(@window, @game_engine)
       end
    end

  end

end
