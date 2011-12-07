module GameStates

  class Options < BaseMenu
    def initialize(window, game_engine)
      super(window, game_engine)

      @menu_items = [
                     MenuItem.new("Controls") do
                       @game_engine.states.push(Controls.new(@window, @game_engine))
                     end,
                     
                     MenuItem.new("Audio") do
                       @game_engine.states.push(Audio.new(@window, @game_engine))
                     end,
                     
                     MenuItem.new("Display") do
                       @game_engine.states.push(Display.new(@window, @game_engine))
                     end,
                     
                     MenuItem.new("Back") do
                       leave
                     end
                    ]

      @title = "Options"
    end
  end

end
