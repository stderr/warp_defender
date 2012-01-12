class Game < Gosu::Window

  attr_accessor :fonts, :images, :animations, :sounds, :music, :sprite_definitions, :native_width, :native_height

  def initialize
    #super(Gosu::screen_width, Gosu::screen_height, true)
    super(1066, 600, false)
    self.caption = 'Warp Defender'

    @images = {}
    @fonts = {}
    @sounds = {}
    @animations = {}
    @music = {}

    load_images
    load_fonts
    load_sounds
    load_animations
    load_sprites
    load_music

    
    $window = self

    # use 1080p for the "native" size; that is, the size at which the display
    # won't be scaled (bigger screens scale up, smaller screens scale down so
    # the same content is visible regardless of screen size)
    @native_width = 1920
    @native_height = 1080
    

    @game_engine = GameEngine.new

    @game_engine.start!
  end

  def update
    @game_engine.update
  end

  def screen_scale
    [$window.width / @native_width.to_f,
     $window.height / @native_height.to_f].min
  end

  def draw
    $window.scale(screen_scale, screen_scale, 0, 0) { @game_engine.draw }
  end

  def button_down(id)
    @game_engine.button_down(id)
  end

  def button_up(id)
    @game_engine.button_up(id)
  end

  def load_images
    @images[:background] = Gosu::Image.new(self, "media/images/space.jpg", true)
    @images[:menu_background] = Gosu::Image.new(self, "media/images/space.jpg", true)
    @images[:unchecked] = Gosu::Image.new(self, "media/images/unchecked.png", false)
    @images[:checked] = Gosu::Image.new(self, "media/images/checked.png", false)
    @images[:hud] = Gosu::Image.new(self, "media/images/hud_bottom_right.png", false)
  end

  def load_fonts
    @fonts[:menu] = Gosu::Font.new(self, 'media/fonts/font.ttf', 60)
    @fonts[:level_title] = Gosu::Font.new(self, 'media/fonts/font.ttf', 80)
    @fonts[:level_description] = Gosu::Font.new(self, 'media/small_font.ttf', 36)
  end

  def load_sounds
    @sounds[:beep] = Gosu::Sample.new(self, "media/sounds/beep.wav")
    @sounds[:applause] = Gosu::Sample.new(self, "media/sounds/applause.wav")
    @sounds[:warp] = Gosu::Sample.new(self, "media/sounds/warp.wav")
    @sounds[:meteor] = Gosu::Sample.new(self, "media/sounds/meteor.wav")
    @sounds[:laser] = Gosu::Sample.new(self, "media/sounds/laser_sound.wav")
    @sounds[:explosion] = Gosu::Sample.new(self, "media/sounds/explosion.wav")
    @sounds[:click] = Gosu::Sample.new(self, "media/sounds/click.wav")
  end

  def load_music
    @music[:theme] = Gosu::Song.new(self, "media/music/theme.ogg")
  end

  def load_animations
    @animations[:debris] = Gosu::Image::load_tiles(self, "media/debris.png", 50, 40, false)
    @animations[:warp_1] = Gosu::Image::load_tiles(self, "media/warp_L1.png", 340, 340, false)
    @animations[:warp_2] = Gosu::Image::load_tiles(self, "media/warp_L2.png", 340, 340, false)
    @animations[:warp_3] = Gosu::Image::load_tiles(self, "media/warp_L3.png", 340, 340, false)
    @animations[:warp_4] = Gosu::Image::load_tiles(self, "media/warp_L4.png", 340, 340, false)
    @animations[:warp_5] = Gosu::Image::load_tiles(self, "media/warp_L5.png", 340, 340, false)
    @animations[:meteor] = Gosu::Image::load_tiles(self, "media/meteor.png", 72, 72, false)
    @animations[:player] = Gosu::Image::load_tiles(self, "media/ship.png", 340, 340, false)
    @animations[:grunt] = Gosu::Image::load_tiles(self, "media/grunt.png", 23, 28, false)
    @animations[:bullet] = Gosu::Image::load_tiles(self, "media/bullet.png", 11, 13, false)
    @animations[:explosion] = Gosu::Image::load_tiles(self, "media/explosion.png", 32, 32, false)


    # temporary
    @animations["ship.png"] = Gosu::Image::load_tiles(self, "media/ship.png", 340, 340, false)
    @animations["warp_L1.png"] = Gosu::Image::load_tiles(self, "media/warp_L1.png", 340, 340, false)
    @animations["warp_L2.png"] = Gosu::Image::load_tiles(self, "media/warp_L2.png", 340, 340, false)
    @animations["warp_L3.png"] = Gosu::Image::load_tiles(self, "media/warp_L3.png", 340, 340, false)
    @animations["warp_L4.png"] = Gosu::Image::load_tiles(self, "media/warp_L4.png", 340, 340, false)
    @animations["warp_L5.png"] = Gosu::Image::load_tiles(self, "media/warp_L5.png", 340, 340, false)
  end

  def load_sprites
    @sprite_definitions = {}
    Dir.glob('data/sprites/*.yaml').each do |f|
      y = YAML::load(File.open(f))
      @sprite_definitions[y['sprite']] = y
    end
  end
end
