module Sprite

  def draw_animation(type, z_order, interval = 100)
    img = @window.animations[type][Gosu::milliseconds / interval % @window.animations[type].size]
    img.draw_rot(@x, @y, z_order, @angle)
  end

end
