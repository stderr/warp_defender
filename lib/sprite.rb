module Sprite

  def animation_frame(type, interval = 100)
    @window.animations[type][Gosu::milliseconds / interval % @window.animations[type].size]
  end

  def draw_frame(image, z_order) 
    image.draw_rot(@x, @y, z_order, @angle)
  end

  def draw_animation(type, z_order, interval = 100)
    @image = animation_frame(type, interval)
    draw_frame(@image, z_order)
  end

end
