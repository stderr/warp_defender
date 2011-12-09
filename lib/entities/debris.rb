class Debris
  include Sprite

  def initialize(animation)
    @animation = animation

    @x = rand * 1600
    @y = rand * 1200
    
    @angle = rand 360
    
    @vel_x = Gosu::offset_x(@angle, rand + rand)
    @vel_y = Gosu::offset_y(@angle, rand + rand)

  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size]
    
    img.draw(@x - img.width / 2.0, @y - img.height / 2.0, Utils::ZOrder::Debris, 1, 1)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    
    @x %= 1600
    @y %= 1200
  end
  
end
