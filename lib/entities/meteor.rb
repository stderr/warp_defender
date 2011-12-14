class Meteor
  attr_reader :vel_x, :vel_y
  include LegacySprite

  def initialize(animation)
    @animation = animation

    @x = rand * 1600
    @y = rand * 1200
    
    @angle = rand 360

    @vel_x = Gosu::offset_x(@angle, rand + rand)
    @vel_y = Gosu::offset_y(@angle, rand + rand)

    @animation_counter = 0
    @animation_cache = @animation[Gosu::milliseconds / 100 % @animation.size]
  end

  def draw
    if @animation_counter > 9
      @animation_cache = @animation[Gosu::milliseconds / 100 % @animation.size]
      @animation_counter = 0
    end

    @animation_cache.draw(@x - @animation_cache.width / 2.0, @y - @animation_cache.height / 2.0, Utils::ZOrder::Meteors, 1, 1)
    @animation_counter += 1
  end

  def move
    @x += @vel_x
    @y += @vel_y
    
    @x %= 1600
    @y %= 1200
  end

end
