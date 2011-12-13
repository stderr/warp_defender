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

      $window.draw_quad(x-@options[:width]/2, y-@options[:height]/2, @options[:color],
                        x+@options[:width]/2, y-@options[:height]/2, @options[:color], 
                        x+@options[:width]/2, y+@options[:height]/2, @options[:color],
                        x-@options[:width]/2, y+@options[:height]/2, @options[:color],
                        Utils::ZOrder::HUD)
      
      $window.fonts[:level_title].draw_rel(@title, x, y-(@options[:height]/3), 100,
                                           0.5, 0.5, 1, 1, Gosu::Color.rgba(255, 255, 255, 200))

      line_count = 0
      last_line = @description.split.reduce([]) do |line, word|
        if $window.fonts[:level_description].text_width(line.join(" ")) > @options[:width] - 100
          $window.fonts[:level_description].draw_rel(line.join(" "), x, (line_count * 30)+y-(@options[:height]/4), 100,
                                                     0.5, 0.5, 1, 1, Gosu::Color.rgba(255, 255, 255, 180))
          line = [word]
          line_count += 1
        else
          line << word
        end

        line

      end
      
       $window.fonts[:level_description].draw_rel(last_line.join(" "), x, (line_count * 30)+y-(@options[:height]/4), 100,
                                                     0.5, 0.5, 1, 1, Gosu::Color.rgba(255, 255, 255, 180))
      

    end

    
  end

end
