module GameStates

  class Audio < BaseMenu
    def initialize(game_engine)
      super(game_engine)
      @menu_items = [
                     GUI::Checkbox.new(:text => "Music", :value => @game_engine.config.audio.music || false ) do |item|
                       $window.sounds[:click].play
                       item.checked = !item.checked
                       @game_engine.config.audio.music = item.checked
                       @game_engine.config.write
                     end,
                     
                     GUI::Checkbox.new(:text => "Sound", :value => @game_engine.config.audio.sound || false) do |item|
                       $window.sounds[:click].play
                       item.checked = !item.checked
                       @game_engine.config.audio.sound = item.checked
                       @game_engine.config.write
                     end,
                     
                     GUI::Text.new(:text => "Back") do
                       leave
                     end
                    ]
      @title = "Audio"
    end
  end

end
