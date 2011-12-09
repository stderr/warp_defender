module GameStates

  class Audio < BaseMenu
    def initialize(window, game_engine)
      super(window, game_engine)
      
      @menu_items = [
                     GUI::Checkbox.new(:text => "Music") do |item|
                       @window.sounds[:click].play
                       item.checked = !item.checked
                     end,
                     
                     GUI::Checkbox.new(:text => "Sound") do |item|
                       @window.sounds[:click].play
                       item.checked = !item.checked
                     end,
                     
                     GUI::Text.new(:text => "Back") do
                       leave
                     end
                    ]
      @title = "Audio"
    end
  end

end
