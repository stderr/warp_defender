module GameStates

  class MainMenu < BaseMenu

    def initialize(game_engine)
      super(game_engine)

      @menu_items = [
                     GUI::Text.new(:text => "New") do
                       press_enter do
                         game_engine.load_level!
                       end
                     end,

                     GUI::Text.new(:text => "Options") do
                       press_enter do 
                         game_engine.load_state! GameStates::Options
                       end
                     end,

                     GUI::Text.new(:text => "Quit") do
                       press_enter do
                         Process.exit
                       end
                     end
                    ] 

      @title = "Main Menu"
    end

  end

end
