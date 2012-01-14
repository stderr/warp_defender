module Weapons

  class MineLayer < Weapon
    def projectile
      Entities::Projectiles::Mine
    end

    def sound
      $window.sounds[:laser]
    end

    def fire_rate
      4000
    end
    
    def velocity_x
      0
    end

    def velocity_y
      0
    end

    class << self

      def icon
        @icon ||= Gosu::Image.new($window, "media/icons/mine_icon.png", false)
      end

    end

  end

end
