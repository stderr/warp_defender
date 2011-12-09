module GameStates

  class MainMenu < BaseMenu

    def initialize(window, game_engine)
      super(window, game_engine)

      @menu_items = [
                     GUI::Text.new(:text => "New") do
                       @game_engine.states.push(Playing.new(@window, @game_engine))
                     end,

                     GUI::Text.new(:text => "Options") do
                       @game_engine.states.push(Options.new(@window, @game_engine))
                     end,

                     GUI::Text.new(:text => "Quit") do
                       Process.exit
                     end
                    ] 

      @title = "Main Menu"
    end

  end

end
