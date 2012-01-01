module Entities
  class Player < Entity
    attr_reader :score, :dead_x, :dead_y, :deaths
    attr_accessor :dead, :respawn_time
    #include LegacySprite

    def initialize
      super(:z_order => Utils::ZOrder::Player)

      @deaths = 0
      @dead = false
      @respawn_time = 125

      sprite_def = $window.sprite_definitions['player']
      @render = Render::Sprite.new(sprite_def)
      @render.state = "idle"
      @physics = Physics::Dynamic.new(:sprite => sprite_def)

      @score = 0
    end

    def turn_left; @physics.angular_accel = -1800; end
    def turn_right; @physics.angular_accel = 1800; end
    def draw; @render.draw(self, 1); end
    def map_color; Gosu::Color::GREEN; end
    def map_draw?; true; end

    def engines_on
      @physics.accel = 1300
      if @render.state != "accelerate"
        @render.state = "accelerate"
      end
    end

    def update(delta)
      if $window.button_down?(Gosu::KbLeft) || $window.button_down?(Gosu::GpLeft)
        turn_left
      end

      if $window.button_down?(Gosu::KbRight) || $window.button_down?(Gosu::GpRight)
        turn_right
      end

      if $window.button_down?(Gosu::KbUp) || $window.button_down?(Gosu::GpUp)
        engines_on
      else
        @render.state = "idle"
      end

      @physics.update(self, delta)
      @x = [[0, @x].max, $window.native_width].min
      @y = [[0, @y].max, $window.native_height].min
    end

    def draw(delta)
      @render.draw(self, delta)
    end

    def shoot
      $window.sounds[:laser].play
      Entities::Bullet.new(@angle, @x, @y, @vel_x, @vel_y)
    end

  end

end
