module GameStates

  class MainMenu < BaseMenu

    def initialize(game_engine)
      super(game_engine)

      @menu_items = [
                     GUI::Text.new(:text => "New") do
                       @game_engine.states.push(LoadLevel.new(@game_engine))
                     end,

                     GUI::Text.new(:text => "Options") do
                       @game_engine.states.push(Options.new(@game_engine))
                     end,

                     GUI::Text.new(:text => "Quit") do
                       Process.exit
                     end
                    ] 

      @title = "Main Menu"
    end

  end

end
