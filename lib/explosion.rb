class Explosion
  attr_reader :x, :y
  
  def initialize(window, x, y)
    @window = window
    
    @animation = window.animations[:explosion]

    @lifetime = @animation.size

    @x = x
    @y = y
    
    @dead = false
  end
  
  def draw
    
    @lifetime -= 1
    
    kill if @lifetime < 0

    @image = @animation[@lifetime]

    @image.draw(@x, @y, Utils::ZOrder::Explosion) if !@dead
  end

  def kill
    @dead = true
  end

end
