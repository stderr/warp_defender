class Player
  attr_reader :score, :dead_x, :dead_y, :deaths
  attr_accessor :dead, :respawn_time, :vel_x, :vel_y
  include Sprite

  def initialize(window)
    @window = window
    @deaths = 0
    @dead = false
    @respawn_time = 125

    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def move_to(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y

    @x %= @window.width
    @y %= @window.height

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    draw_animation(:player, Utils::ZOrder::Player)
  end

  def shoot
    @window.sounds[:laser].play
    Bullet.new(@window, @angle, @x, @y)
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
