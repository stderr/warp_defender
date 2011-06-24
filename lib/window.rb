class GameWindow < Gosu::Window
  def initialize
    super(1600, 1200, false)
    self.caption = 'Gosu Ruby Stargame'

    @background_image = Gosu::Image.new(self, "media/space.jpg", true)

    @player = Player.new(self)
    @player.warp(800, 600)

    @star_animation = Gosu::Image::load_tiles(self, "media/star.png", 48, 48, false)
    @stars = Array.new

    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    if button_down?(Gosu::KbLeft) || button_down?(Gosu::GpLeft)
      @player.turn_left
    end

    if button_down?(Gosu::KbRight) || button_down?(Gosu::GpRight)
      @player.turn_right
    end

    if button_down?(Gosu::KbUp)
      @player.accelerate
    end

    @player.move
    @player.collect_stars(@stars)
    
    if rand(100) < 4 and @stars.size < 25
      @stars.push(Star.new(@star_animation))
    end
  end

  def draw
    @background_image.draw(0, 0, Utils::ZOrder::Background)
    @player.draw
    @stars.each { |star| star.draw }

    @font.draw("Score: #{@player.score}", 10, 10, Utils::ZOrder::UI, 1.0, 1.0, 0xffffff00)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end
