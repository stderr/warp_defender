module GameStates
  
  class Display < BaseMenu
    def initialize(game_engine)
      super(game_engine)
      # We have to use 'video' in the config rather than 'display' due to retardation
      @menu_items = [
                     GUI::Checkbox.new(:text => "Fullscreen", :value => @game_engine.config.video.fullscreen || false) do 
                       press_enter do
                         $window.sounds[:click].play
                         sink.checked = !sink.checked
                         
                         game_engine.config.video.fullscreen = sink.checked
                         game_engine.config.write
                       end
                     end,
                     
                     GUI::Text.new(:text => "Back") do 
                       press_enter do
                         game_engine.clear_state!(Display)
                     end
                     end
                    ]
      
      @title = "Display"
    end
  end
end
