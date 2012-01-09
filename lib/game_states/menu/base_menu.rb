module GameStates

  class BaseMenu < GameState
    include Input::Handler

    attr_accessor :selected_item
    attr_reader :menu_items

    def initialize(game_engine)
      super(game_engine)

      @menu_items = []
      @title = ""
      @selected_item = 0
      @spacing = 80
      
      @x = $window.native_width / 2
      @y = $window.native_height / 2

      controls do
        press_arrow(:down) do
          sink.selected_item = [(sink.selected_item + 1), 
                                sink.menu_items.index(sink.menu_items.last)].min
        end

        press_arrow(:up) do
          sink.selected_item = [(sink.selected_item - 1), 0].max
        end
      end

    end
    
    def button_down(id)
      dispatch_input(id)
      @menu_items[@selected_item].dispatch_input(id)
    end
    
    def draw
      $window.images[:menu_background].draw(0, 0, 0,
                                            1/$window.screen_scale,
                                            1/$window.screen_scale)
      $window.fonts[:menu].draw_rel(@title, @x, @y - @spacing, 0, 0.5, 1, 2, 2)
      
      @menu_items.each_index do |i|
          color = (i == @selected_item ?  Gosu::Color::GREEN : Gosu::Color::WHITE)

          @menu_items[i].draw(@x, @y+i*@spacing, :color => color)
      end
    end

  end

end
