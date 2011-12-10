module GameStates
  
class Display < BaseMenu
  def initialize(game_engine)
    super(game_engine)
    # We have to use 'video' in the config rather than 'display' due to retardation
    @menu_items = [
                   GUI::Checkbox.new(:text => "Fullscreen", :value => @game_engine.config.video.fullscreen || false) do |item|
                     $window.sounds[:click].play
                     item.checked = !item.checked
                     @game_engine.config.video.fullscreen = item.checked
                     @game_engine.config.write
                   end,
                   
                   GUI::Text.new(:text => "Back") do 
                     leave
                   end
                  ]

    @title = "Display"
  end
end

end
