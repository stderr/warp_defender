module Gosu

  class Window
    # Simple method to draw a rectangle centered on x and y
    def draw_rect(x, y, width, height, color, z_order=0)
      draw_quad(x-width/2, y-height/2, color,
                x+width/2, y-height/2, color,
                x+width/2, y+height/2, color,
                x-width/2, y+height/2, color,
                z_order)
    end

  end

end
