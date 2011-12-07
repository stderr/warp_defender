class Player
  attr_reader :score, :dead_x, :dead_y, :deaths
  attr_accessor :dead, :respawn_time, :vel_x, :vel_y
  include Sprite

  def initialize(window)
    @window = window
    @deaths = 0
    @dead = false
    @respawn_time = 125
    @acceleration = 1300
    @rotation_speed = 300

    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @z_order = Utils::ZOrder::Player
    @score = 0

    draw_frame(:player, 0)
  end

  def move_to(x, y)
    @x, @y = x, y
  end

  def turn_left(delta)
    # a bit less than one revolution per second
    @angle -= @rotation_speed * delta
  end

  def turn_right(delta)
    # a bit less than one revolution per second
    @angle += @rotation_speed * delta 
  end

  def accelerate(delta)
    @vel_x += Gosu::offset_x(@angle, @acceleration) * delta
    @vel_y += Gosu::offset_y(@angle, @acceleration) * delta
    animate(:player, :once, 100)
  end

  def update(delta)
    move(delta)
  end

  def move(delta)
    @x += @vel_x * delta
    @y += @vel_y * delta

    @x %= @window.width
    @y %= @window.height

    # apply space-friction
    @vel_x *= 0.97 * (1 - delta)
    @vel_y *= 0.97 * (1 - delta)
  end

  def shoot
    @window.sounds[:laser].play
    Bullet.new(@window, @angle, @x, @y, @vel_x, @vel_y)
  end

  def die!
    puts "You died!."
  end

  def check_meteors(meteors)
    meteors.each do |meteor|
      if Gosu::distance(@x, @y, meteor.x, meteor.y) < 30
        @window.sounds[:meteor].play
        @dead = true
        @dead_x = @x
        @dead_y = @y
        @deaths += 1
      end
    end
  end

end
