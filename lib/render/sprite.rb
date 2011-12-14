module Render

  class Sprite
    attr_accessor :state

    def initialize(sprite)
      config = $window.sprite_definitions[sprite]
      @name = config['sprite']

      @layers = { }
      config['layers'].each do |l|
        @layers[l["layer"]] = l.reject { |k, v| k == "layer" }
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
          @states[name][layer_name][:start] = :unstarted
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
        end
      end
    end

    def draw(entity, delta)
      if not @state
      	return
      end

      @states[@state].each do |name, layer|
        if layer[:start] == :unstarted
        	layer[:start] = Gosu::milliseconds
        end
        transpired_ms = Gosu::milliseconds - layer[:start]

        frame_idx = transpired_ms / layer[:interval]
        if layer[:frames].kind_of?(Array)
          frame_idx = [frame_idx, layer[:frames].length-1].min
        end

        anim_frame_index = layer[:frames].take(frame_idx+1)[-1]
        
        frame = $window.animations[@layers[name]['file']][anim_frame_index]
        frame.draw_rot(entity.x, entity.y,
                       entity.z_order, entity.angle,
                       0.5, 0.5,
                       entity.scale, entity.scale)
      
      end
    end
  end

end
