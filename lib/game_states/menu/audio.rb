module GameStates

  class Audio < BaseMenu
    def initialize(window, game_engine)
      super(window, game_engine)
      
      @menu_items = [
                     MenuItem.new("Music", :checkbox) do |item|
                       @window.sounds[:click].play
                       item.checked = !item.checked
                     end,
                     
                     MenuItem.new("Sound", :checkbox) do |item|
                       @window.sounds[:click].play
                       item.checked = !item.checked
                     end,
                     
                     MenuItem.new("Back") do
                       leave
                     end
                    ]
      @title = "Audio"
    end
  end

end
