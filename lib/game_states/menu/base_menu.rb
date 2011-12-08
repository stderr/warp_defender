module GameStates

  class BaseMenu < GameState
    
    def initialize(window, game_engine)
      super(window, game_engine)

      @menu_items = []
      @title = ""
      @selected_item = 0
      @spacing = 40
      
      @x = @window.width / 2
      @y = @window.height / 2
    end
    
    def button_down(id)
      case id
      when Gosu::KbDown, Gosu::GpDown
        @selected_item = [(@selected_item + 1), @menu_items.index(@menu_items.last)].min
      when Gosu::KbUp, Gosu::GpUp
        @selected_item = [(@selected_item - 1), 0].max
      when Gosu::KbReturn, Gosu::GpButton2
        @menu_items[@selected_item].activate
      end
    end
    
    def draw
      @window.images[:menu_background].draw(0, 0, 0)
      @window.fonts[:menu].draw_rel(@title, @x, @y - 40, 0, 0.5, 1, 2, 2)
      
      @menu_items.each_index do |i|
          color = (i == @selected_item ?  Gosu::Color::GREEN : Gosu::Color::WHITE)
          @menu_items[i].draw(@window, @x, @y+i*@spacing, color)
      end
    end
  
  end

end
