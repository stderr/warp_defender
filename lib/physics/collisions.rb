module Physics

  def Physics.create_bounds(sprite_definition)
    if not sprite_definition; return nil; end
    bounds = sprite_definition.fetch('bounds', [{}])[0]
    if not bounds.has_key?("shape"); return nil; end

    case bounds["shape"]
    when "circle"
      return Circle.new(0, 0, bounds["radius"])
    when "rectangle"
      return Rectangle.new(0, 0, bounds["width"], bounds["height"])
    end
  end


  class Circle
    attr_accessor :x, :y, :radius

    def initialize(x, y, radius)
      @x = x
      @y = y
      @radius = radius
    end

    def width; radius*2; end
    def height; radius*2; end

    def collides_with?(other)
      self.send("collides_with_#{other.class.name}?".to_sym, other)
    end

    define_method("collides_with_Physics::Circle?".to_sym) do |other|
      dx = self.x - other.x
      dy = self.y - other.y
      dr = (self.width/2.0*self.scale + other.width/2.0*other.scale)

      dx**2 + dy**2 < dr**2
    end

    define_method("collides_with_Physics::Rectangle?".to_sym) do |other|
      # only working with axis-aligned rectangles currently
      circ_dist_x = (self.x - other.x).abs
      circ_dist_y = (self.y - other.y).abs

      if circ_dist_x > (other.width/2 + @radius); return false; end
      if circ_dist_y > (other.height/2 + @radius); return false; end

      if circ_dist_x <= other.width/2; return true; end
      if circ_dist_y <= other.height/2; return true; end

      ((circ_dist_x - other.width/2)**2 +
       (circ_dist_y - other.height/2)**2) <= @radius**2
    end

    def method_missing(method, *args)
      throw "missing collision detection for #{args[0].class.name} in #{self.class.name}"
    end
  end

  class Rectangle
    attr_accessor :x, :y, :width, :height

    # x and y are the center point
    def initialize(x, y, width, height)
      @x = x
      @y = y
      @width = width
      @height = height
    end

    def top; @y - @height/2; end
    def left; @x - @width/2; end
    def bottom; @y + @height/2; end
    def right; @x + @width/2; end

    def collides_with?(other)
      self.send("collides_with_#{other.class.name}?".to_sym, other)
    end

    define_method("collides_with_Physics::Circle?".to_sym) do |other|
      # just use Circle's version
      other.collides?(self)
    end

    define_method("collides_with_Physics::Rectangle?".to_sym) do |other|
      # only working with axis-aligned rectangles currently
      not (other.right < left or other.left > right or 
			     other.bottom < top or other.top > bottom)
    end

    def method_missing(method, *args)
      throw "missing collision detection for #{args[0].class.name} in #{self.class.name}"
    end
  end
end
