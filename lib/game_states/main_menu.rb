module GameStates

  class MainMenu < BaseMenu

    def initialize(window, game_engine)
      super(window, game_engine)

      @menu_items = [
                     MenuItem.new("Play", Playing),
                     MenuItem.new("Options", Options),
                     MenuItem.new("Quit", Credits)
                    ] 

      @title = "Main Menu"
    end

  end

end
