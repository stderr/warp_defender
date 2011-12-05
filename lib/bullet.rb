class Bullet
  include Sprite

  def initialize(window, angle, x, y)
    @window = window

    @x = x
    @y = y
    @width = @window.animations[:grunt].first.width
    @height = @window.animations[:grunt].first.height
    @angle = angle
    @z_order = Utils::ZOrder::Player

    @dead = false

    animate(:bullet, :loop, 100)
  end

  def move
    @x += Gosu::offset_x(@angle, 10.00)
    @y += Gosu::offset_y(@angle, 10.00)
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

