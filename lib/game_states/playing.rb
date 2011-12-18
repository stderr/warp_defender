module GameStates

  class Playing < GameState
    
    def initialize(game_engine)
      super(game_engine)
      @bullets = []

      # HUD
      @mini_map = GUI::MiniMap.new(:color => Gosu::Color.rgba(0, 0, 0, 160), 
                                   :width => 190, 
                                   :height => 100,
                                   :scale_x => 5,
                                   :scale_y => 5)

      @defense_bar = GUI::Bar.new(:width => 172, 
                                  :height => 8,
                                  :left_color => Gosu::Color.rgba(65, 108, 112, 220),
                                  :right_color => Gosu::Color.rgba(65, 108, 112, 220))

      @timer = Utils::Timer.new
      
      @last_update_ms = Gosu::milliseconds
      @last_draw_ms = Gosu::milliseconds

      $window.music[:theme].play(true)
    end

    def update
      # frame timescaling
      frame_ms = Gosu::milliseconds
      delta = (frame_ms - @last_update_ms) / 1000.0
      @last_update_ms = frame_ms

      if(@timer.time_passed?(level.interval))
        level.spawn
        level.next_wave if level.to_next_wave?
      end

      level.update(delta)
    end

    def draw
      # frame timescaling
      frame_ms = Gosu::milliseconds
      delta = (frame_ms - @last_draw_ms) / 1000.0
      @last_draw_ms = frame_ms

      $window.images[:background].draw(0, 0, Utils::ZOrder::Background,
                                       1/$window.screen_scale,
                                       1/$window.screen_scale)
      
      level.draw(delta)

      $window.images[:hud].draw($window.native_width-$window.images[:hud].width, 
                                $window.native_height - $window.images[:hud].height,
                                Utils::ZOrder::HUD)

      @defense_bar.draw($window.native_width-381, $window.native_height-29, 
                        :current => level.current_defense,
                        :max => level.max_defense)

      @mini_map.draw($window.native_width-98, $window.native_height-53, :entities => level.entities)
    end

    def button_down(id)
       case id
       
       when Gosu::KbEscape, Gosu::GpButton9
         $window.music[:theme].pause
         @game_engine.states.push(GameStates::Paused.new(@game_engine))
       
       when Gosu::KbSpace, Gosu::GpButton2 
         bullet = level.player.shoot
         level.bullets << bullet
       end
    end
    
    private
    
    def level
      @game_engine.level
    end

  end

end
