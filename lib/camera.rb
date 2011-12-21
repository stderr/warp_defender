class Camera

  attr_reader :x, :y
  attr_accessor :target

  def initialize(target, zoom)
    @target = target
    @x = target.x
    @y = target.y
    @zoom = zoom
  end

  def smooth_retarget(target, zoom, easing, period, delay=0)
    @target = target
    @easing_target_zoom = zoom
    @easing_start_zoom = @zoom
    @easing = easing
    @easing_start_time = Gosu::milliseconds
    @easing_period = period
    @easing_delay = delay
    @easing_start_x = @x
    @easing_start_y = @y
  end

  def update(delta)
    if @easing
    	elapsed = Gosu::milliseconds - @easing_start_time - @easing_delay
    	if elapsed > 0
        @x = Ease.ease(@easing,
                      elapsed,
                      @easing_start_x,
                      @target.x - @easing_start_x,
                      @easing_period)
        @y = Ease.ease(@easing,
                      elapsed,
                      @easing_start_y,
                      @target.y - @easing_start_y,
                      @easing_period)
        @zoom = Ease.ease(@easing,
                          elapsed,
                          @easing_start_zoom,
                          @easing_target_zoom - @easing_start_zoom,
                          @easing_period)
      end
    	if elapsed > @easing_period
    		@easing = nil
    	end
    else
      @x = @target.x
      @y = @target.y
    end
  end

  def draw(&drawing_code)
    $window.translate(-@x + $window.native_width/2,
                      -@y + $window.native_height/2) do
      $window.scale(@zoom, @zoom, @x, @y) { yield }
    end
  end
end
