module GameStates
  
class Display < BaseMenu
  def initialize(window, game_engine)
    super(window, game_engine)

    @menu_items = [
                   GUI::Checkbox.new(:text => "Fullscreen") do |item|
                     @window.sounds[:click].play
                     item.checked = !item.checked
                   end,
                   
                   GUI::Text.new(:text => "Back") do 
                     leave
                   end
                  ]

    @title = "Display"
  end
end

end
