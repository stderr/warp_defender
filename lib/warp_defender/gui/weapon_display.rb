module GUI
  class WeaponDisplay < BaseElement
  
    def initialize(options = {}, &on_activate)
      @weapons = options[:weapons]
      super(options = {}, &on_activate)
    end

    def draw(x, y, options = {})
      active = options[:active]
      @weapons.each do |weapon| 
        color = weapon.class == active ? Gosu::Color.rgba(65, 108, 112, 220) : Gosu::Color.rgba(0, 0, 0, 160)

        $window.draw_rect(x, y, 50, 50, color, Utils::ZOrder::HUD)
        
        weapon.class.icon.draw_rot(x, y, Utils::ZOrder::HUD, 0.0)
        x += 50 + 10

      end

    end

  end
end
