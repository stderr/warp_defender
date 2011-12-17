module Render

  class Sprite
    attr_accessor :state

  def ease_linear(time, start, change, duration)
    return change*time/duration.to_f + start
  end

  def ease_in_sine(time, start, change, duration)
    return -change * Math.cos(time/duration.to_f * (Math::PI/2)) + change + start
  end

  def ease_out_sine(time, start, change, duration)
    return change * Math.sin(time/duration.to_f * (Math::PI/2)) + start
  end

  def ease_inout_sine(time, start, change, duration)
    return -change/2.0 * (Math.cos(Math::PI*time/duration.to_f) - 1) + start
  end

  def ease_in_quad(time, start, change, duration)
    time /= duration.to_f
    return change * time * time + start
  end

  def ease_out_quad(time, start, change, duration)
    time /= duration.to_f
    return -change * time * (time-2) + start
  end

  def ease_inout_quad(time, start, change, duration)
    time /= duration/2.0
    if time < 1
      return change/2.0*time*time + start
    end
    --time
    return -change/2.0 * (time*(time-2) - 1) + start
  end

  def ease_in_cubic(time, start, change, duration)
    time /= duration.to_f
    return change * time*time*time + start
  end

  def ease_out_cubic(time, start, change, duration)
    time = time / duration.to_f - 1
    return change * (time*time*time + 1) + start
  end

  def ease_inout_cubic(time, start, change, duration)
    time /= duration/2.0
    if time < 1
      return change / 2.0 * time*time*time + start
    end
    time -= 2
    return change / 2.0 * (time*time*time + 2) + start
  end

  def ease_in_quart(time, start, change, duration)
    time /= duration.to_f
    return change * time*time*time*time + start
  end

  def ease_out_quart(time, start, change, duration)
    time = time/duration.to_f-1
    return -change * (time*time*time*time - 1) + start
  end

  def ease_inout_quart(time, start, change, duration)
    time /= duration/2.0
    if time < 1
      return change / 2.0 * (time*time*time*time) + start
    end
    time -= 2
    return -change/2.0 * (time*time*time*time - 2) + start
  end

  def ease_in_quint(time, start, change, duration)
    time /= duration.to_f
    return change * time*time*time*time*time + start
  end

  def ease_out_quint(time, start, change, duration)
    time = time / duration.to_f - 1
    return change * (time*time*time*time*time + 1) + start
  end

  def ease_inout_quint(time, start, change, duration)
    time /= duration/2.0
    if time < 1
      return change / 2.0 * time*time*time*time*time + start
    end
    time -= 2
    return change / 2.0 * (time*time*time*time*time + 2) + start
  end

  def ease_in_expo(time, start, change, duration)
    # TODO: should we fabs/epsilon this test?
    return (time == 0) ? start : change * (2.0**(10 * (time/duration.to_f - 1))) + start
  end

  def ease_out_expo(time, start, change, duration)
    # TODO: should we fabs/epsilon this test?
    return (time == duration) ? start + change : change * (-(2.0**(-10 * time/duration.to_f)) + 1) + start
  end

  def ease_inout_expo(time, start, change, duration)
    # TODO: should we fabs/epsilon this test?
    if time == 0
      return start
    end

    if time == duration
      return start+change
    end

    time /= duration/2.0
    if time < 1
      return change/2.0 * (2.0**(10 * (time - 1))) + start
    end

    return change/2.0 * (-(2.0**(-10 * (time - 1))) + 2) + start
  end

# def ease_in_circ(time, start, change, duration)
# {
# 	time /= duration
# 	return -change * (std::sqrt(1 - time*time) - 1) + start
# }
# 
# def ease_out_circ(time, start, change, duration)
# {
# 	time /= duration-1
# 	wxLogDebug(wxString() << "change: " << change << " time: " << time << " start: " << start)
# 	return change * std::sqrt(1 - time*time) + start
# }
# 
# def ease_inout_circ(time, start, change, duration)
# {
# 	time /= duration/2
# 	if(time < 1)
# 		return -change/2 * (std::sqrt(1 - time*time) - 1) + start
# 	time -= 2
# 	return change/2 * (std::sqrt(1 - time*time) + 1) + start
# }

  def ease_in_elastic_default(time, start, change, duration)
    return ease_in_elastic(time, start, change, duration, change, duration*0.3)
  end

  def ease_in_elastic(time, start, change, duration, a, p)
    # I'm not entirely sure what a and p are but I'd imagine they affect the elasticity

    # TODO: should we fabs/epsilon this test?
    if time == 0
      return start
    end

    time /= duration.to_f
    if time == 1
      return start + change
    end

    s = p/4.0
    if a >= change.abs
      s = p/(2*Math::PI) * Math.asin(change/a.to_f)
    end

    time -= 1
    return -(a*(2.0**(10 * time)) * Math.sin((time*duration-s)*(2*Math::PI)/p.to_f)) + start
  end

  def ease_out_elastic_default(time, start, change, duration)
    return ease_out_elastic(time, start, change, duration, change, duration*0.3)
  end

  def ease_out_elastic(time, start, change, duration, a, p)
    # I'm not entirely sure what a and p are but I'd imagine they affect the elasticity

    # TODO: should we fabs/epsilon this test?
    if time == 0
      return start
    end

    time /= duration.to_f
    if time == 1
      return start + change
    end

    s = p/4.0
    if a >= change.abs
      s = p/(2*Math::PI) * Math.asin(change/a.to_f)
    end

    return (a*(2.0**(-10 * time)) * Math.sin((time*duration-s)*(2*Math::PI)/p.to_f) + change + start)
  end

  def ease_inout_elastic_default(time, start, change, duration)
    return ease_inout_elastic(time, start, change, duration, change, duration*0.3*1.5)
  end

  def ease_inout_elastic(time, start, change, duration, a, p)
    # I'm not entirely sure what a and p are but I'd imagine they affect the elasticity

    # TODO: should we fabs/epsilon this test?
    if time == 0
      return start
    end

    time /= duration/2.0
    if time == 2
      return start + change
    end

    s = p/4.0
    if a >= change.abs
      s = p/(2*Math::PI) * Math.asin(change/a.to_f)
    end

    if time < 1
      time -= 1
      return -0.5*(a*(2.0**(10*time)) * Math.sin((time*duration-s)*(2*Math::PI)/p.to_f)) + start
    end

    time -= 1
    return a*(2.0**(-10*time)) * Math.sin((time*duration-s)*(2*Math::PI)/p.to_f)*0.5 + change + start
  end

  def ease_in_back_default(time, start, change, duration)
    return ease_in_back(time, start, change, duration, 1.70158)
  end

  def ease_in_back(time, start, change, duration, s)
    time /= duration.to_f
    return change * time*time*((s+1)*time - s) + start
  end

  def ease_out_back_default(time, start, change, duration)
    return ease_out_back(time, start, change, duration, 1.70158)
  end

  def ease_out_back(time, start, change, duration, s)
    time = time/duration.to_f-1
    return change * (time*time*((s+1)*time + s) + 1) + start
  end

  def ease_inout_back_default(time, start, change, duration)
    return ease_inout_back(time, start, change, duration, 1.70158)
  end

  def ease_inout_back(time, start, change, duration, s)
    time /= duration/2.0
    if time < 1
      return change/2.0*(time*time*(((s*=(1.525))+1)*time - s)) + start
    end

    time -= 2
    return change/2.0*(time*time*(((s*=(1.525))+1)*time + s) + 2) + start
  end

  def ease_in_bounce(time, start, change, duration)
    return change - ease_out_bounce(duration - time, 0, change, duration) + start
  end

  def ease_out_bounce(time, start, change, duration)
    time /= duration.to_f
    if time < 1/2.75
      return change*(7.5625*time*time) + start
    elsif time < 2/2.75
      time -= 1.5/2.75
      return change * (7.5625*time*time + 0.75) + start
    elsif time < 2.5/2.75
      time -= 2.25/2.75
      return change * (7.5625*time*time + 0.9375) + start
    else
      time -= 2.625/2.75
      return change * (7.5625*time*time + 0.984375) + start
    end
  end

  def ease_inout_bounce(time, start, change, duration)
    if time < duration/2.0
      return ease_in_bounce(time*2, 0, change, duration) * 0.5 + start
    else
      return ease_out_bounce(time*2-duration, 0, change, duration) * 0.5 + change*0.5 + start
    end
  end
  
    def initialize(sprite)
      config = $window.sprite_definitions[sprite]
      @name = config['sprite']

      @layers = { }
      config['layers'].each do |l|
        @layers[l["layer"]] = l.reject { |k, v| k == "layer" }
      end

      # set some default states
      @layers.each do |n, layer|
        layer[:frame] = layer["frame"] || 0
        layer[:scale] = layer["scale"] || 1
        layer[:rotation] = layer["rotation"] || 0
      end

      states = { }
      config['states'].each do |s|
        states[s["state"]] = s.reject { |k, v| k == "state" }
      end

      @states = {}
      states.each do |name,state|
        @states[name] = { }
        state['layers'].each do |layer|
          layer_name = layer["layer"]
          @states[name][layer_name] = { }
          if layer.has_key?("frame")
            @states[name][layer_name][:interval] = 1
            @states[name][layer_name][:frames] = [layer["frame"]]
          elsif layer.has_key?("frames")
            frames = layer["frames"]
            @states[name][layer_name][:interval] = frames["interval"]
            initial_frames = (frames["start"]   .. frames["finish"]).to_a
            restart_frames = (frames["restart"] .. frames["finish"]).to_a || []
            case frames["playback"]
            when "loop"
              @states[name][layer_name][:frames] = Enumerator.new do |y|
                initial = initial_frames
                restart = restart_frames
                i = 0
                loop do
                  if i < initial.length
                    y << initial[i]
                  else
                    y << restart[(i-initial.length)%restart.length]
                  end
                  i += 1
                end
              end
            when "once"
              @states[name][layer_name][:frames] = initial_frames + restart_frames
            end
          end

          if layer.has_key?("rotate")
          	@states[name][layer_name][:rotate] = layer["rotate"]
          end

          if layer.has_key?("animations")
          	animations = layer["animations"]
          	@states[name][layer_name][:animations] = [ ]
          	animations.each do |anim|
          	  animation = { }
          	  animation[:start] = nil
          	  animation[:easing] = anim["easing"] || nil
          	  animation[:period] = anim["period"] || nil
          	  animation[:delay] = anim["delay"] || 0
          	  animation[:scale] = anim["scale"] || nil
              @states[name][layer_name][:animations] << animation
            end
          end
        end
      end
    end

    def draw(entity, delta)
      if not @state
      	return
      end

      # update layers from states
      @states[@state].each do |name, layer|
        if not @layers[name].has_key?(:start) or @layers[name][:start] == :unstarted
        	@layers[name][:start] = Gosu::milliseconds
        end
        transpired_ms = Gosu::milliseconds - @layers[name][:start]

        if layer.has_key?(:frames)
          frame_idx = transpired_ms / (layer[:interval] || 1)
          if layer[:frames].kind_of?(Array)
            frame_idx = [frame_idx, layer[:frames].length-1].min
          end

          anim_frame_index = layer[:frames].take(frame_idx+1)[-1]
          @layers[name][:frame] = anim_frame_index
        end

        if layer.has_key?(:rotate)
          @layers[name][:rotation] += layer[:rotate] * delta
        end

        if layer.has_key?(:animations)
          layer[:animations].each do |anim|
            delay_adjusted = transpired_ms - anim[:delay]
            if anim.has_key?(:period) and delay_adjusted > 0 and delay_adjusted < anim[:period]
              if not anim[:start]
                anim[:start] = @layers[name][:scale]
              end

              if anim.has_key?(:scale)
                @layers[name][:scale] = ease_out_sine(delay_adjusted, anim[:start], anim[:scale] - anim[:start], anim[:period])
              end
            end
          end
        end
      end

      # now draw
      @layers.each do |name, layer|
        frame = $window.animations[layer['file']][layer[:frame]]
        $window.rotate(entity.angle, entity.x, entity.y) do ||
          frame.draw_rot(entity.x,
                         entity.y,
                         entity.z_order,
                         layer[:rotation],
                         0.5, 0.5,
                         layer[:scale], layer[:scale])
        end
      end
    end
  end
end
