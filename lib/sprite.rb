module Sprite

  attr_accessor :x, :y, :width, :height, :angle, :z_order

  def draw
    if @animstart == :unstarted
    	@animstart = Gosu::milliseconds
    end
    transpired_ms = Gosu::milliseconds - @animstart

    frame = nil
    case @animtype
    when :once
      frame_idx = [transpired_ms / @animinterval, 
                   frame_count(@animname)-1].min
      frame = @window.animations[@animname][frame_idx]
      if frame_idx == frame_count(@animname)-1 and @animonfinish
      	@animonfinish.call
      end
    when :once_reverse
      frame_idx = [frame_count(@animname)-1 - transpired_ms / @animinterval, 
                   0].max
      frame = @window.animations[@animname][frame_idx]
      if frame_idx == 0 and @animonfinish
      	@animonfinish.call
      end
    when :loop
      frame_idx = transpired_ms / @animinterval % frame_count(@animname)
      frame = @window.animations[@animname][frame_idx]
    when :loop_reverse
      frame_idx = frame_count(@animname)-1 - transpired_ms / @animinterval % frame_count(@animname)
      frame = @window.animations[@animname][frame_idx]
    when :single
      frame = @window.animations[@animname][@animsingleindex]
    end

    frame.draw_rot(@x, @y, @z_order, @angle)

  end

  def animate(name, type, interval, on_finish = nil)
    raise "Invalid animation type" unless [:once, :once_reverse, :loop, :loop_reverse].include? type
    @animname = name
    @animtype = type
    @animinterval = interval
    @animonfinish = on_finish
    @animstart = :unstarted
  end

  def draw_frame(name, index)
    @animname = name
    @animtype = :single
    @animinterval = 0
    @animstart = :unstarted
    @animsingleindex = index
  end

  def frame_count(name)
    @window.animations[name].size
  end

  def frame_width(name, window=@window)
    window.animations[name].first.width
  end

  def frame_height(name, window=@window)
    window.animations[name].first.height
  end

end
