class Game < Gosu::Window

  attr_accessor :fonts, :images, :animations, :sounds

  def initialize
    super(Gosu::screen_width, Gosu::screen_height, true)
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
    load_animations
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
    @sounds[:beep] = Gosu::Sample.new(self, "media/beep.wav")
    @sounds[:applause] = Gosu::Sample.new(self, "media/applause.wav")
    @sounds[:warp] = Gosu::Sample.new(self, "media/warp.wav")
    @sounds[:meteor] = Gosu::Sample.new(self, "media/meteor.wav")
    @sounds[:laser] = Gosu::Sample.new(self, "media/laser_sound.mp3")
  end

  def load_animations
    @animations[:debris] = Gosu::Image::load_tiles(self, "media/debris.png", 50, 40, false)
    @animations[:warp] = Gosu::Image::load_tiles(self, "media/warp.png", 98, 96, false)
    @animations[:meteor] = Gosu::Image::load_tiles(self, "media/meteor.png", 72, 72, false)
    @animations[:player] = Gosu::Image::load_tiles(self, "media/spaceship.png", 49, 49, false)
    @animations[:grunt] = Gosu::Image::load_tiles(self, "media/grunt.png", 23, 28, false)
  end

end
