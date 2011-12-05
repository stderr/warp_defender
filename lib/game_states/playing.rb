module GameStates

  class Playing < GameState
    
    def initialize(window, game_engine)
      super(window, game_engine)
      @player = Player.new(@window)
      @player.move_to(@window.width/2, @window.height/2 + 80)

      @warp = Warp.new(@window, @window.width/2, @window.height/2)

      @entities = []
      grunt = Entities::Grunt.new(@window, @warp)
      grunt.spawn(@window.width, @window.height)
      
      @entities << grunt

      @bullets = []
      @entities = []
      @explosions = []
      
      @timer = Utils::Timer.new
      
      play_theme_song
    end

    def update
      if @window.button_down?(Gosu::KbLeft) || @window.button_down?(Gosu::GpLeft)
        @player.turn_left
      end

      if @window.button_down?(Gosu::KbRight) || @window.button_down?(Gosu::GpRight)
        @player.turn_right
      end

      if @window.button_down?(Gosu::KbUp) || @window.button_down?(Gosu::GpUp)
        @player.accelerate
      end
      
      if(@timer.time_passed?(5000)) 
        grunt = Entities::Grunt.new(@window, @player)
        grunt.spawn(@window.width, @window.height)
        
        @entities << grunt
      end

      @bullets.reject! { |b| b.dead? }
      @entities.reject! { |e| e.dead? }
      @explosions.reject! { |e| e.dead? }

      @player.move
      @entities.each { |e| e.move }
      @bullets.each { |b| b.move }

      @bullets.each do |bullet| 
        @entities.each do |entity|
         
          if bullet.collides_with?(entity)
            bullet.kill
            entity.kill
            @window.sounds[:explosion].play
            @explosions << Explosion.new(@window, entity.x, entity.y)
          end
       
        end
      end

      @entities.each do |entity|
        if @warp.collides_with?(entity)
          @warp.warp(entity)
        end

      end

    end

    def draw
      @window.images[:background].draw(0, 0, Utils::ZOrder::Background)
      
      @player.draw
      
      @entities.each { |e| e.draw }

      @bullets.each do |b| 
         b.draw 
      end

      @warp.draw

      @explosions.each { |e| e.draw }
    end

    def button_down(id)
       case id
       
       when Gosu::KbEscape, Gosu::GpButton9
         stop_theme_song
         @game_engine.states.push(GameStates::Paused.new(@window, @game_engine))
       
       when Gosu::KbSpace, Gosu::GpButton2 
         @bullets << @player.shoot
       end
    end

    def play_theme_song
      @window.music[:theme].play(true)
    end

    def stop_theme_song
      @window.music[:theme].stop
    end

  end

end
