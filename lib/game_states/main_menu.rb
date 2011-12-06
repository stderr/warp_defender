module GameStates

  class MainMenu < BaseMenu

    def initialize(window, game_engine)
      super(window, game_engine)

      @menu_items = [
                     MenuItem.new("Play", Playing.new(@window, @game_engine)),
                     MenuItem.new("Options", Options.new(@window, @game_engine)),
                     MenuItem.new("Quit", Credits.new(@window, @game_engine))
                    ] 

      @title = "Main Menu"
    end

  end

end
