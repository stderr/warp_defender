module Entities
  class Player < Entity
    attr_reader :score, :dead_x, :dead_y, :deaths
    attr_accessor :dead, :respawn_time
    include Sprite

    def initialize
      super(:z_order => Utils::ZOrder::Player)

      @deaths = 0
      @dead = false
      @respawn_time = 125

      @physics = Physics::Dynamic.new()

      @score = 0

      draw_frame(:player, 0)
    end

    def turn_left
      @physics.angular_accel = -1800
    end

    def turn_right
      @physics.angular_accel = 1800
    end

    def engines_on
      @physics.accel = 1300
      animate(:player, :once, 100)
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

    def die!
      puts "You died!."
    end

    def check_meteors(meteors)
      meteors.each do |meteor|
        if Gosu::distance(@x, @y, meteor.x, meteor.y) < 30
          $window.sounds[:meteor].play
          @dead = true
          @dead_x = @x
          @dead_y = @y
          @deaths += 1
        end
      end
    end

    def map_color
      Gosu::Color::GREEN
    end

  end

end
