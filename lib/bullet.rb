class Bullet
  include Sprite

  def initialize(window, angle, x, y, vel_x, vel_y)
    @window = window

    @x = x
    @y = y
    @width = @window.animations[:grunt].first.width
    @height = @window.animations[:grunt].first.height
    @angle = angle
    @z_order = Utils::ZOrder::Player
    @vel_x = vel_x + Gosu::offset_x(@angle, 800.00)
    @vel_y = vel_y + Gosu::offset_y(@angle, 800.00)

    @dead = false

    animate(:bullet, :loop, 100)
  end

  def update(delta)
    move(delta)
  end

  def move(delta)
    @x += @vel_x * delta
    @y += @vel_y * delta
  end

  def off_screen?
    @x > @window.width || @x < 0 || @y < 0 || @y > @window.height 
  end

  def kill
    @dead = true
  end

  def dead?
    @dead
  end

end

