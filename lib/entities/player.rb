module Entities
  class Player < Entity
    attr_reader :score, :dead_x, :dead_y, :deaths
    attr_accessor :dead, :respawn_time
    #include LegacySprite

    def initialize
      super(:z_order => Utils::ZOrder::Player, :scale => 0.25 * 0.75)

      @deaths = 0
      @dead = false
      @respawn_time = 125

      @physics = Physics::Dynamic.new()
      @render = Render::Sprite.new('player')

      @score = 0

      @render.state = "idle"
      #draw_frame(:player, 0, @z_order)
    end

    def turn_left; @physics.angular_accel = -1800; end
    def turn_right; @physics.angular_accel = 1800; end
    def draw; @render.draw(self, 1); end
    def map_color; Gosu::Color::GREEN; end
    def map_draw?; true; end

    def engines_on
      @physics.accel = 1300
      @render.state = "accelerate"
      #animate(:player, :once, 100, @z_order)
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
      end

      @physics.update(self, delta)
      @x %= $window.width
      @y %= $window.height
    end

    def shoot
      $window.sounds[:laser].play
      Entities::Bullet.new(@angle, @x, @y, @vel_x, @vel_y)
    end

  end

end
