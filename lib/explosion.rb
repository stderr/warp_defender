class Explosion
  include Sprite
  
  def initialize(window, x, y, vel_x=0, vel_y=0)
    @window = window
    
    @x = x
    @y = y
    @vel_x = vel_x
    @vel_y = vel_y
    @width = @window.animations[:explosion].first.width
    @height = @window.animations[:explosion].first.height
    @angle = 0
    @z_order = Utils::ZOrder::Explosion
    
    @dead = false

    # play forward, then backward, then kill
    animate(:explosion, :once, 20,
            lambda { animate(:explosion, :once_reverse, 15,
                             lambda { kill })})
  end
  
  def dead?
    @dead
  end

  def kill
    @dead = true
  end

  def update(delta)
    move(delta)
  end

  def move(delta)
    @x += @vel_x * delta
    @y += @vel_y * delta
  end

end
