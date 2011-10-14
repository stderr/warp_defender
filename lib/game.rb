class Game < Gosu::Window

  attr_accessor :fonts, :images

  def initialize
    super(1600, 1200, false)
    self.caption = 'Warp Defender'

    @game_engine = GameEngine.new(self)
    @game_engine.state = GameStates::Menu.new(self, @game_engine)

    @images = {}
    @fonts = {}
    @sounds = {}
    @animations = {}

    load_images
    load_fonts
    load_sounds
  end

  def update
    @game_engine.update
  end

  def draw
    @game_engine.draw
  end

  def button_down(id)
    @game_engine.button_down(id)
  end

  def button_up(id)
    @game_engine.button_up(id)
  end

  def load_images
    @images[:background] = Gosu::Image.new(self, "media/space.jpg", true)
    @images[:player] = Gosu::Image.new(self, "media/fighter.png", false)
  end

  def load_fonts
    @fonts[:menu] = Gosu::Font.new(self, 'media/font.ttf', 40)
  end

  def load_sounds
  end

  def load_animations
    @animations[:debris] = Gosu::Image::load_tiles(self, "media/debris.png", 50, 40, false)
    @animations[:warp] = Gosu::Image::load_tiles(self, "media/warp.png", 98, 96, false)
    @animations[:meteor] = Gosu::Image::load_tiles(self, "media/meteor.png", 72, 72, false)
  end

end
