module Utils
  module ZOrder
    Background, UI, Debris, Meteors, Warps, Player, Explosion, Stars, PauseOverlay = *0..8 
  end

  class Timer
    def initialize
      @last_time = Gosu::milliseconds
    end
    
    def time_passed?(ms)
      new_time = Gosu::milliseconds
      
      if (new_time - @last_time > ms)
        @last_time = new_time
        return true
      else
        return false
      end
    end

  end

end
