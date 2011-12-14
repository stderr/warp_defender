class Star
  include LegacySprite
  
  def initialize(animation)
    @animation = animation
    
    @color = Gosu::Color.new(0xff000000)
    
    @color.red = rand(255 - 40) + 40
    @color.green = rand(255 - 40) + 40
    @color.blue = rand(255 - 40) + 40
    
    @x = rand * 1600
    @y = rand * 1200    
  end

  def draw

    img = @animation[Gosu::milliseconds / 100 % @animation.size]
  
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0, 
             Utils::ZOrder::Stars, 1, 1, @color, :additive)
    
  end

end
