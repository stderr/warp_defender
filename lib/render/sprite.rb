module Render

  class Sprite
    attr_reader :state

    def initialize(sprite)
      config = $window.sprite_definitions[sprite]
      @name = config['sprite']

      @layers = { }
      config['layers'].each do |l|
        @layers[l["layer"]] = l.reject { |k, v| k == "layer" }
      end

      # set some default states
      @layers.each do |n, layer|
        layer[:frame] = layer.fetch("frame", 0)
        layer[:scale] = layer.fetch("scale", 1)
        layer[:rotation] = layer.fetch("rotation", 0)
        layer[:rotation_rate] = layer.fetch("rotation_rate", 0)
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
            # is this || [] right?
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

          if layer.has_key?("rotation_rate")
          	@states[name][layer_name][:rotation_rate] = layer["rotation_rate"]
          end

          if layer.has_key?("animations")
          	animations = layer["animations"]
          	@states[name][layer_name][:animations] = [ ]
          	animations.each do |anim|
          	  animation = { }
          	  animation[:start] = nil
          	  if anim.has_key?("easing")
                animation[:easing] = anim["easing"]
              end
          	  if anim.has_key?("period")
                animation[:period] = anim["period"]
              end
          	  if anim.has_key?("delay")
                animation[:delay] = anim["delay"]
              end
          	  if anim.has_key?("scale")
                animation[:scale] = anim["scale"]
              end
          	  if anim.has_key?("rotation_rate")
                animation[:rotation_rate] = anim["rotation_rate"]
              end
              @states[name][layer_name][:animations] << animation
            end
          end
        end
      end
    end

    def state=(new_state)
      @state = new_state
      @state_start = Gosu::milliseconds

      # set static fields
      @states[@state].each do |name, layer|
        if layer.has_key?(:scale)
          @layers[name][:scale] = layer[:scale]
        end
        if layer.has_key?(:rotation_rate)
          @layers[name][:rotation_rate] = layer[:rotation_rate]
        end
      end
    end

    def animations_finished?
      transpired_ms = Gosu::milliseconds - @state_start
      @states[@state].each do |name, layer|
        if layer.has_key?(:animations)
          layer[:animations].each do |anim|
            delay_adjusted = transpired_ms - anim.fetch(:delay, 0)
            if anim.has_key?(:period) and delay_adjusted < anim[:period]
            	return false
            end
          end
        end
      end
      return true
    end

    def draw(entity, delta)
      if not @state
      	return
      end

      # update layers from states
      transpired_ms = Gosu::milliseconds - @state_start
      @states[@state].each do |name, layer|
        if layer.has_key?(:frames)
          frame_idx = transpired_ms / layer.fetch(:interval, 1)
          if layer[:frames].kind_of?(Array)
            frame_idx = [frame_idx, layer[:frames].length-1].min
          end

          anim_frame_index = layer[:frames].take(frame_idx+1)[-1]
          @layers[name][:frame] = anim_frame_index
        end

        if layer.has_key?(:animations)
          layer[:animations].each do |anim|
            delay_adjusted = transpired_ms - anim.fetch(:delay, 0)
            if anim.has_key?(:period) and delay_adjusted > 0 and delay_adjusted < anim[:period]
              if not anim[:start]
                anim[:start] = {}
                anim[:start][:scale] = @layers[name][:scale]
                anim[:start][:rotation_rate] = @layers[name][:rotation_rate]
              end

              if anim.has_key?(:scale)
                @layers[name][:scale] = Ease.ease(anim[:easing], delay_adjusted, anim[:start][:scale], anim[:scale] - anim[:start][:scale], anim[:period])
              end

              if anim.has_key?(:rotation_rate)
                @layers[name][:rotation_rate] = Ease.ease(anim[:easing], delay_adjusted, anim[:start][:rotation_rate], anim[:rotation_rate] - anim[:start][:rotation_rate], anim[:period])
              end
            end
          end
        end

        @layers[name][:rotation] += @layers[name][:rotation_rate] * delta

      end



      # now draw
      @layers.each do |name, layer|
        frame = $window.animations[layer['file']][layer[:frame]]
        $window.rotate(entity.angle, entity.x, entity.y) do
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
