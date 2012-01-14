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

    class << self

      def icon
        @icon ||= Gosu::Image.new($window, "media/icons/blaster_icon.png", false)
      end

    end
  end
end
