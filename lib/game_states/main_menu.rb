module GameStates

  class MainMenu < BaseMenu

    def initialize(window, game_engine)
      super(window, game_engine)

      @menu_items = [
                     MenuItem.new("New") do 
                       @game_engine.states.push(Playing.new(@window, @game_engine))
                     end,

                     MenuItem.new("Options") do 
                       @game_engine.states.push(Options.new(@window, @game_engine))
                     end,

                     MenuItem.new("Quit") do
                       Process.exit
                     end
                    ] 

      @title = "Main Menu"
    end

  end

end
