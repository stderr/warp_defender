module Sprite

  def draw_animation(type, z_order, interval = 100)
    @image = @window.animations[type][Gosu::milliseconds / interval % @window.animations[type].size]
    @image.draw_rot(@x, @y, z_order, @angle)
  end


end
