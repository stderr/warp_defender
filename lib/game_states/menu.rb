module GameStates

  class Menu < GameState

    def initialize(window, game_engine)
      super(window, game_engine)
      
      @menu_items = ["Start Game", "Options", "Quit"] 

      @selected_item = 0
      
      @position_x = @window.width / 2
      @position_y = @window.height / 2
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
          leave
          @game_engine.states.push(GameStates::Playing.new(@window, @game_engine))
        when 1
          leave
          @game_engine.state.push(GameStates::Options.new(@window, @game_engine))
        when 2
          leave
          #@game_engine.state.push(GameStates::Credits.new(@window, @game_engine))
          Process.exit
        end
      end
    end

    def draw
      @window.images[:background].draw(0,0,0)
      
      @window.fonts[:menu].draw_rel("Main Menu", @position_x, @position_y - 40, 0, 0.5, 1, 2, 2)

      @menu_items.each_index do |i|
        if i == @selected_item
          @window.fonts[:menu].draw_rel(@menu_items[i], @position_x, @position_y+i*40, 0, 0.5, 1, 1, 1, Gosu::Color::GREEN)
        else
          @window.fonts[:menu].draw_rel(@menu_items[i], @position_x, @position_y+i*40, 0, 0.5, 1)
        end
      end

    end


  end

end
