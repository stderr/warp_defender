module GameStates
  
class Display < BaseMenu
  def initialize(window, game_engine)
    super(window, game_engine)

    @menu_items = [
                   CheckboxItem.new("Fullscreen") do |item|
                     @window.sounds[:click].play
                     item.checked = !item.checked
                   end,
                   
                   MenuItem.new("Back") do 
                     leave
                   end
                  ]
    @title = "Display"
  end
end

end
