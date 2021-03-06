module Entities
  class Player < Entity
    attr_reader :score, :dead_x, :dead_y, :deaths, :weapons
    attr_accessor :dead, :respawn_time

    def initialize
      super(:z_order => Utils::ZOrder::Player,
            :sprite => 'player',
            :physics => :dynamic)

      @deaths = 0
      @dead = false
      @respawn_time = 125

      @render.state = "idle"
      @score = 0

      @weapons = []
      @weapons << Weapons::RocketLauncher.new(self)
      @weapons << Weapons::Blaster.new(self)
      @weapons << Weapons::MineLayer.new(self)

      @current_weapon = 0

      controls do
        hold_left do
          sink.turn_left
        end

        hold_right do
          sink.turn_right
        end

        hold_up do
          sink.engines_on
        end

        hold(Gosu::KbSpace) do
          if sink.weapon.can_fire?
            bullet = sink.shoot
            $window.game_engine.level.bullets << bullet
          end
        end
        
        press(Gosu::KbC) do
          sink.cycle_weapon
        end

        default(:hold) do
          sink.idle
        end
      end

    end

    def turn_left; @physics.angular_accel = -1800; end
    def turn_right; @physics.angular_accel = 1800; end
    def map_color; Gosu::Color::GREEN; end
    def map_draw?; true; end

    def weapon
      @weapons[@current_weapon]
    end

    def cycle_weapon
      @current_weapon += 1
      @current_weapon = 0 if @current_weapon > (@weapons.size - 1)
    end

    def engines_on
      @physics.accel = 1300
      if @render.state != "accelerate"
        @render.state = "accelerate"
      end
    end

    def idle
      @render.state = "idle"
    end

    def update(delta)
      dispatch_constant_input

      @physics.update(self, delta)
      @x = [[0, @x].max, $window.native_width].min
      @y = [[0, @y].max, $window.native_height].min
    end

    def shoot
      weapon.shoot
      # $window.sounds[:laser].play
      # Entities::Bullet.new(@angle, @x, @y, @vel_x, @vel_y)
    end

  end

end
