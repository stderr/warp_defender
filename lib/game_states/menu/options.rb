module GameStates

  class Options < BaseMenu
    def initialize(game_engine)
      super(game_engine)

      @menu_items = [
                     GUI::Text.new(:text => "Controls") do
                       press_enter do
                         game_engine.load_state! GameStates::Controls
                       end
                     end,
                     
                     GUI::Text.new(:text => "Audio") do
                       press_enter do
                         game_engine.load_state! GameStates::Audio
                       end
                     end,
                     
                     GUI::Text.new(:text => "Display") do
                       press_enter do
                         game_engine.load_state! GameStates::Display
                       end
                     end,
                     
                     GUI::Text.new(:text => "Back") do
                       press_enter do
                         game_engine.clear_state!(Options)
                       end
                     end
                    ]

      @title = "Options"
    end
  end

end
