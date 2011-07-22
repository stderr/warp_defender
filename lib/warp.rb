class Warp
  attr_reader :x, :y
  
  def initialize(animation)
    @animation = animation
    
    @x = rand * 1600
    @y = rand * 1200
  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size]
    
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0, Utils::ZOrder::Warps, 1, 1)
  end

end
