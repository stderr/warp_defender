module GameStates
  
  class MenuItem
    attr_reader :name
    
    def initialize(name, &on_activate)
      @name = name

      @on_activate = on_activate if block_given?
    end
    
    def draw(window, x, y, color=1)
      window.fonts[:menu].draw_rel(@name, x, y, 0, 0.5, 1, 1, 1, color)
    end

    def activate
      @on_activate.call(self)
    end

  end

  class CheckboxItem < MenuItem
    attr_accessor :checked

    def initialize(name, &on_activate)
      super(name, &on_activate)
      
      @checked = false
    end

    def draw(window, x, y, color=1)
      super(window, x, y, color)

        if checked
          window.images[:checked].draw_rot(x+100, y-18, 0, 0)
        else
          window.images[:unchecked].draw_rot(x+100, y-18, 0, 0)
        end
    end

  end

end
