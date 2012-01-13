module Collision

  attr_accessor :collision_shape

  def create_bounds(sprite)
    config = $window.sprites[sprite]
    if not config or not config['bounds']
      @collision_shape = nil
      return
    end

    config['bounds'][0].each do |k,v|
      instance_variable_set("@collision_#{k}", v)
      self.class.send(:define_method, "collision_#{k}".to_sym) do
        instance_variable_get("@collision_#{k}")
      end
    end
  end

  def width
    case @collision_shape
    when "circle"
      return @collision_radius*2
    when "rectangle"
      return @collision_width
    end

    return 0
  end

  def height
    case @collision_shape
    when "circle"
      return @collision_radius*2
    when "rectangle"
      return @collision_height
    end

    return 0
  end

  def collides_with?(entity, other)
    if not @collision_shape or not other.physics.collision_shape
      return false
    end

    # ugly but we don't have complicated enough shapes to justify running a
    # visitor pattern
    shapes = [@collision_shape, other.physics.collision_shape]
    if shapes == ["circle", "circle"]
      return circle_intersects_circle(entity, other)
    elsif shapes == ["rectangle", "rectangle"]
      return rectangle_intersects_rectangle(entity, other)
    elsif shapes == ["circle", "rectangle"]
      return circle_intersects_rectangle(entity, other)
    elsif shapes == ["rectangle", "circle"]
      return circle_intersects_rectangle(other, entity)
    end

    throw "unrecognized shapes for collision detection"
  end

  def circle_intersects_circle(one, two)
    dx = one.x - two.x
    dy = one.y - two.y
    dr = one.physics.collision_radius + two.physics.collision_radius

    dx**2 + dy**2 < dr**2
  end

  def circle_intersects_rectangle(one, two)
    # only working with axis-aligned rectangles currently
    circ_dist_x = (one.x - two.x).abs
    circ_dist_y = (one.y - two.y).abs

    if circ_dist_x > (two.physics.collision_width/2 + one.physics.collision_radius)
      return false
    end
    if circ_dist_y > (two.physics.collision_height/2 + one.physics.collision_radius)
      return false
    end

    if circ_dist_x <= two.physics.collision_width/2
      return true
    end
    if circ_dist_y <= two.physics.collision_height/2
      return true
    end

    ((circ_dist_x - two.physics.collision_width/2)**2 +
     (circ_dist_y - two.physics.collision_height/2)**2) <= one.physics.collision_radius**2
  end

  def rectangle_intersects_rectangle(one, two)
    # only working with axis-aligned rectangles currently
    not (two.x + two.physics.collision_width/2 < one.x or two.x > one.x + one.physics.collision_width/2 or
         two.y + two.physics.collision_height/2 < one.y or two.y > one.y + two.physics.collision_height/2)
  end

end
