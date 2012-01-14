module Weapons
  class Blaster < Weapon

    def projectile
      Entities::Projectiles::Bullet
    end

    def sound
      $window.sounds[:laser]
    end

    def fire_rate
      500
    end

    def velocity_x
      Gosu::offset_x(@owner.angle, 800.00)
    end

    def velocity_y
      Gosu::offset_y(@owner.angle, 800.00)
    end

  end
end
