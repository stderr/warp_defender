module Sprite

  attr_accessor :x, :y, :width, :height, :angle

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

  def collides_with?(other)
    dx = other.x - @x
    dy = other.y - @y
    dr = other.width/2.0 + @width/2.0

    dx**2 + dy**2 < dr**2
  end
end
