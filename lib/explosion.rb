class Explosion
  attr_reader :x, :y
  
  def initialize(window, x, y)
    @window = window
    
    @animation = window.animations[:explosion]

    @lifetime = @animation.size

    @width = @window.animations[:explosion].first.width
    @height = @window.animations[:explosion].first.height
    @x = x
    @y = y
    
    @dead = false
  end
  
  def draw
    
    @lifetime -= 1
    
    kill if @lifetime < 0

    @image = @animation[@lifetime]

    @image.draw(@x - @width/2.0, @y - @height/2.0, Utils::ZOrder::Explosion) if !@dead
  end

  def kill
    @dead = true
  end

end
