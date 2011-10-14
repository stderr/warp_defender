module GameStates

  class Menu < GameState

    def initialize(window, game_engine)
      super(window, game_engine)
      
      @menu_items = ["Start Game", "Options", "Quit"] 

      @selected_item = 0
    end

    def button_down(id)
      case id
      when Gosu::KbDown
        @selected_item = [(@selected_item + 1), 2].min
      when
        Gosu::KbUp
        @selected_item = [(@selected_item - 1), 0].max
      when Gosu::KbReturn
        case @selected_item
        when 0 
          @game_engine.state = GameStates::Playing.new(@window, @game_engine)
        when 1
          @game_engine.state = GameStates::Options.new(@window, @game_engine)
        when 2
          @game_engine.state = GameStates::Credits.new(@window, @game_engine)
        end
      end
    end

    def draw
      @window.images[:background].draw(0,0,0)
      
      @window.fonts[:menu].draw_rel("Main Menu", 800, 300, 0, 0.5, 1, 2, 2)

      @menu_items.each_index do |i|
        if i == @selected_item
          @window.fonts[:menu].draw_rel(@menu_items[i], 800, 380+i*40, 0, 0.5, 1, 1, 1, Gosu::Color::GREEN)
        else
          @window.fonts[:menu].draw_rel(@menu_items[i], 800, 380+i*40, 0, 0.5, 1)
        end
      end

    end


  end

end
