class Explosion
  include Sprite
  
  def initialize(window, x, y)
    @window = window
    
    @x = x
    @y = y
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

end
