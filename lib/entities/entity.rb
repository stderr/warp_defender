module Entities

  class Entity
    attr_accessor :x, :y, :vel_x, :vel_y, :vel_angle, :angle, :z_order, :physics

    def initialize(params)
      @x         = params[:x] || 0.0
      @y         = params[:y] || 0.0
      @vel_x     = params[:vel_x] || 0.0
      @vel_y     = params[:vel_y] || 0.0
      @vel_angle = params[:vel_angle] || 0.0
      @angle     = params[:angle] || 0.0
      @z_order   = params[:z_order] || 0
      @sprite    = params[:sprite]
      physics    = params[:physics] || :static
      friction   = params[:friction] || 0.03
      afriction  = params[:angular_friction] || 0.1

      @behavior = Behaviors::Behavior.new(self)

      @render = Render::Sprite.new(@sprite)

      case physics
      when :dynamic
        @physics = Physics::Dynamic.new(:sprite => @sprite,
                                        :friction => friction,
                                        :angular_friction => afriction)
      when :static
        @physics = Physics::Static.new(:sprite => @sprite)
      end
      
      @dead = false
      @warping = false
    end

    def spawn(width, height); @behavior.spawn(width, height); end
    def move; @behavior.move; end
    def kill; @dead = true; end
    def dead?; @dead; end
    def map_color; Gosu::Color::RED; end
    def enemy?; false; end
    def map_draw?; false; end

    def width; @physics.width; end
    def height; @physics.height; end

    def draw(delta)
      @render.draw(self, delta)
    end

    def move_to(x, y)
      @x, @y = x, y
    end

    def off_screen?
      @x > $window.native_width || @x < 0 || @y < 0 || @y > $window.native_height 
    end

    def collides_with?(other)
      if not @physics or not other.physics; return false; end

      @physics.collides_with?(self, other)
    end

  end
  
end
