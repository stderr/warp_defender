module GameStates

  class Audio < BaseMenu
    def initialize(game_engine)
      super(game_engine)
      @menu_items = [
                     GUI::Checkbox.new(:text => "Music", :value => @game_engine.config.audio.music || false ) do
                       press_enter do
                         $window.sounds[:click].play
                         sink.checked = !sink.checked

                         game_engine.config.audio.music = sink.checked
                         game_engine.config.write
                       end
                     end,
                     
                     GUI::Checkbox.new(:text => "Sound", :value => @game_engine.config.audio.sound || false) do 
                       press_enter do
                         $window.sounds[:click].play
                         sink.checked = !sink.checked
                         
                         game_engine.config.audio.sound = sink.checked
                         game_engine.config.write
                       end
                     end,
                     
                     GUI::Text.new(:text => "Back") do
                       press_enter do
                         game_engine.clear_state!(Audio)
                       end
                     end
                    ]
      @title = "Audio"
    end
  end

end
