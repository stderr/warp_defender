module GameStates

  class Audio < BaseMenu
    def initialize(window, game_engine)
      super(window, game_engine)
      
      @menu_items = [
                     CheckboxItem.new("Music") do |item|
                       @window.sounds[:click].play
                       item.checked = !item.checked
                     end,
                     
                     CheckboxItem.new("Sound") do |item|
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
