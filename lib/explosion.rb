class Explosion
  attr_reader :x, :y
  
  def initialize(animation, x, y)
    @animation = animation
    @animation_counter = 0
    @x = x
    @y = y
  end

  def draw
    @index = @animation_counter / 5

    unless @index >= @animation.size
      img = @animation[@index]
      img.draw(@x - img.width / 2.0, @y - img.height / 2.0, Utils::ZOrder::Explosion, 1, 1)
      @animation_counter += 1
    end
  end
end
