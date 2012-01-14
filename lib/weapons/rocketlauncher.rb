module Weapons
  class RocketLauncher < Weapon

    def projectile
      Entities::Projectiles::Rocket
    end

    def sound
      $window.sounds[:rlaunch]
    end

    def fire_rate
      500
    end

    def velocity_x
      Gosu::offset_x(@owner.angle, 300.00)
    end

    def velocity_y
      Gosu::offset_y(@owner.angle, 300.00)
    end

  end
end
