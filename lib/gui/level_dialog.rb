module GUI

  class LevelDialog < BaseElement

    def initialize(options = {}, &on_activate)
      super(options, &on_activate)

      @title = @options[:title]
      @description = @options[:description]
    end

    def draw(x, y, options = {})
      super(x, y, options)
      $window.images[:background].draw(0, 0, Utils::ZOrder::Background)

      # border
      $window.draw_rect(x, y, 
                        @options[:width] + 2, 
                        @options[:height] + 2, 
                        @options[:color], 
                        Utils::ZOrder::HUD)
      # inner box
      $window.draw_rect(x, y,
                        @options[:width],
                        @options[:height],
                        Gosu::Color.rgba(0, 0, 0, 150),
                        Utils::ZOrder::HUD)

      $window.fonts[:level_title].draw_rel(@title, x, y-(@options[:height]/3), 100,
                                           0.5, 0.5, 1, 1, Gosu::Color.rgba(255, 255, 255, 200))

      line_count = 0

      last_line = @description.split.reduce([]) do |line, word|

        if $window.fonts[:level_description].text_width(line.join(" ")) > @options[:width] - 100
          draw_line(line.join(" "), x, (line_count * 30) + y - (@options[:height]/4))
          line = [word]
          line_count += 1
        else
          line << word
        end
        line
      end

      draw_line(last_line.join(" "), x, (line_count * 30)+y-(@options[:height]/4))
    end

    private

    def draw_line(line, x, y)
      $window.fonts[:level_description].draw_rel(line, x, y, 100, # <- z-order
                                                 0.5, 0.5, 1, 1, @options[:font_color])
    end
    
  end

end
