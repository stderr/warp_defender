module Weapons
  
  class Weapon
    def initialize(owner)
      @owner = owner
      @last_fire_time = Gosu::milliseconds
    end

    def shoot
      @last_fire_time = Gosu::milliseconds
      sound.play
      projectile.new(@owner.angle, @owner.x, @owner.y, 
                     @owner.vel_x + velocity_x, @owner.vel_y + velocity_y)

    end

    def can_fire?
      Gosu::milliseconds - @last_fire_time > fire_rate
    end

    # Implemented in child class
    def projectile
    end
    
    def sound
    end

    def fire_rate
    end
    
    def velocity_x
    end
    
    def velocity_y
    end

  end

end
