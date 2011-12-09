module GameStates

  class Playing < GameState
    
    def initialize(window, game_engine)
      super(window, game_engine)

      @entities = []

      @player = Entities::Player.new(@window)
      @player.move_to(@window.width/2, @window.height/2 + 80)
      
      @entities << @player

      @warp = Entities::Warp.new(@window, @window.width/2, @window.height/2)
      @entities << @warp
      
      grunt = Entities::Grunt.new(@window, @warp)
      grunt.spawn(@window.width, @window.height)
      @entities << grunt

      # track the bullets explicitly until we have better collision handling
      @bullets = []
      
      # HUD
      @mini_map = GUI::MiniMap.new(:color => Gosu::Color::BLACK, 
                                   :width => @window.width/10, 
                                   :height => @window.height/10)

      @defense_bar = GUI::Bar.new(:width => 180, 
                                  :height => 20,
                                  :outer_color => Gosu::Color::BLACK,
                                  :left_color => Gosu::Color::RED,
                                  :right_color => Gosu::Color::GREEN)
      @timer = Utils::Timer.new
      
      @last_frame_ms = Gosu::milliseconds
      @window.music[:theme].play(true)
    end

    def update
      # frame timescaling
      frame_ms = Gosu::milliseconds
      delta = (frame_ms - @last_frame_ms) / 1000.0
      @last_frame_ms = frame_ms

      if(@timer.time_passed?(2500)) 
        grunt = Entities::Grunt.new(@window, [@warp, @player][rand(2)])
        grunt.spawn(@window.width, @window.height)
        
        @entities << grunt
      end

      @entities.reject! { |e| e.dead? }
      @bullets.reject! { |b| b.dead? } # remove once bullets aren't special

      @entities.each { |e| e.update(delta) }

      @bullets.each do |bullet| 
        @entities.each do |entity|
          if entity.is_a? Entities::Grunt
            if bullet.collides_with?(entity)
              bullet.kill
              entity.kill
              @window.sounds[:explosion].play
              @entities << Entities::Explosion.new(
                                @window, entity.x, entity.y, 
                                entity.vel_x*0.7,
                                entity.vel_y*0.7)
            end
          end
        end
      end

      @entities.each do |entity|
        if not entity.equal? @warp
          # is_a? is a hack to prevent non-enemy entities being warped
          if entity.is_a? Entities::Grunt
          	if @warp.collides_with?(entity)
              @warp.warp(entity)
            end
          end
        end
      end

      @game_engine.states.push(GameStates::GameOver.new(@window, @game_engine)) if @warp.current_defense <= 0
    end

    def draw
      @window.images[:background].draw(0, 0, Utils::ZOrder::Background)
      @entities.each { |e| e.draw }
      
      @defense_bar.draw(@window, (@window.width/2)+220, @window.height-10, :current => @warp.current_defense, :max => @warp.max_defense)
      @mini_map.draw(@window, @window.width-110, @window.height-10, :entities => @entities)
    end

    def button_down(id)
       case id
       
       when Gosu::KbEscape, Gosu::GpButton9
         @window.music[:theme].pause
         @game_engine.states.push(GameStates::Paused.new(@window, @game_engine))
       
       when Gosu::KbSpace, Gosu::GpButton2 
         bullet = @player.shoot
         @entities << bullet
         @bullets << bullet
       end
    end

  end

end
