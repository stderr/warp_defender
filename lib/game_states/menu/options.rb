module GameStates

  class Options < BaseMenu
    def initialize(game_engine)
      super(game_engine)

      @menu_items = [
                     GUI::Text.new(:text => "Controls") do
                       @game_engine.states.push(Controls.new(@game_engine))
                     end,
                     
                     GUI::Text.new(:text => "Audio") do
                       @game_engine.states.push(Audio.new(@game_engine))
                     end,
                     
                     GUI::Text.new(:text => "Display") do
                       @game_engine.states.push(Display.new(@game_engine))
                     end,
                     
                     GUI::Text.new(:text => "Back") do
                       leave
                     end
                    ]

      @title = "Options"
    end
  end

end
