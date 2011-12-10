module Entities

  class Entity
    attr_accessor :x, :y, :vel_x, :vel_y, :vel_angle, :angle, :width, :height,
                  :z_order

    def initialize(params)
      @x         = params[:x] || 0.0
      @y         = params[:y] || 0.0
      @vel_x     = params[:vel_x] || 0.0
      @vel_y     = params[:vel_y] || 0.0
      @vel_angle = params[:vel_angle] || 0.0
      @angle     = params[:angle] || 0.0
      @width     = params[:width] || 0
      @height    = params[:height] || 0
      @z_order   = params[:z_order] || 0

      @behavior = Behaviors::Behavior.new(self)
      
      @dead = false
      @warping = false
    end

    def move_to(x, y)
      @x, @y = x, y
    end

    def spawn(width, height)
      @behavior.spawn(width, height)
    end

    def move 
      @behavior.move
    end

    def draw
    end

    def width
    end

    def height
    end

    def kill
      @dead = true
    end

    def dead?
      @dead
    end

    def off_screen?
      @x > $window.width || @x < 0 || @y < 0 || @y > $window.height 
    end

    # will end up in physics component at some point
    def collides_with?(other)
      dx = other.x - @x
      dy = other.y - @y
      dr = other.width/2.0 + @width/2.0

      dx**2 + dy**2 < dr**2
    end

    def map_color
      Gosu::Color::RED
    end

  end
  
end
