module LegacySprite

  def layers
    @layers ||= {}
  end

  def draw
    finish_callbacks = []
    layers.each do |key, layer|
      if layer[:start] == :unstarted
        layer[:start] = Gosu::milliseconds
      end
      transpired_ms = Gosu::milliseconds - layer[:start]

      frame = nil
      case layer[:type]
      when :once
        frame_idx = [transpired_ms / layer[:interval], 
                    frame_count(layer[:name])-1].min
        frame = $window.animations[layer[:name]][frame_idx]
        if frame_idx == frame_count(layer[:name])-1 and layer[:onfinish]
        	finish_callbacks << layer[:onfinish]
        end
      when :once_reverse
        frame_idx = [frame_count(layer[:name])-1 - transpired_ms / layer[:interval], 
                    0].max
        frame = $window.animations[layer[:name]][frame_idx]
        if frame_idx == 0 and layer[:onfinish]
        	finish_callbacks << layer[:onfinish]
        end
      when :loop
        frame_idx = transpired_ms / layer[:interval] % frame_count(layer[:name])
        frame = $window.animations[layer[:name]][frame_idx]
      when :loop_reverse
        frame_idx = frame_count(layer[:name])-1 - transpired_ms / layer[:interval] % frame_count(layer[:name])
        frame = $window.animations[layer[:name]][frame_idx]
      when :single
        frame = $window.animations[layer[:name]][layer[:singleframe]]
      end

      frame.draw_rot(@x, @y, @z_order, @angle, 0.5, 0.5, @scale, @scale)
    end

    finish_callbacks.each { |e| e.call }
  end

  def animate(name, type, interval, zorder, layer=:default, on_finish = nil)
    raise "Invalid animation type" unless [:once, :once_reverse, :loop, :loop_reverse].include? type
    layers.delete(layer)
    layers[layer] = {}
    layers[layer][:name] = name
    layers[layer][:type] = type
    layers[layer][:interval] = interval
    layers[layer][:zorder] = zorder
    layers[layer][:onfinish] = on_finish
    layers[layer][:start] = :unstarted
    layers[layer].delete(:singleframe)
  end

  def draw_frame(name, index, zorder, layer=:default)
    layers.delete(layer)
    layers[layer] = {}
    layers[layer][:name] = name
    layers[layer][:type] = :single
    layers[layer][:zorder] = zorder
    layers[layer][:start] = :unstarted
    layers[layer][:singleframe] = index
    layers[layer].delete(:interval)
    layers[layer].delete(:onfinish)
  end

  def frame_count(name)
    $window.animations[name].size
  end

  def frame_width(name)
    $window.animations[name].first.width
  end

  def frame_height(name)
    $window.animations[name].first.height
  end

end
