$:.unshift File.expand_path(File.dirname(__FILE__))
# Global gems
require 'gosu'
require 'configurability'
require 'configurability/config'
require 'require_all'

require_all File.join(File.dirname(__FILE__))

class Game < Gosu::Window

  attr_accessor :fonts, :images, :animations, :sounds, :music, :sprites, :native_width, :native_height, :game_engine

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

  def self.run
    new.show
  end

  def media_path(path)
    File.join("media/", path)
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
    @images[:background] = Gosu::Image.new(self, media_path("images/space.jpg"), true)
    @images[:menu_background] = Gosu::Image.new(self, media_path("images/space.jpg"), true)
    @images[:unchecked] = Gosu::Image.new(self, media_path("images/unchecked.png"), false)
    @images[:checked] = Gosu::Image.new(self, media_path("images/checked.png"), false)
    @images[:hud] = Gosu::Image.new(self, media_path("images/hud_bottom_right.png"), false)
  end

  def load_fonts
    @fonts[:menu] = Gosu::Font.new(self, media_path("fonts/space.ttf"), 60)
    @fonts[:level_title] = Gosu::Font.new(self, media_path("fonts/space.ttf"), 80)
    @fonts[:level_description] = Gosu::Font.new(self, media_path("fonts/droid_sans_mono.ttf"), 36)
  end

  def load_sounds
    @sounds[:beep] = Gosu::Sample.new(self, media_path("sounds/beep.wav"))
    @sounds[:applause] = Gosu::Sample.new(self, media_path("sounds/applause.wav"))
    @sounds[:warp] = Gosu::Sample.new(self, media_path("sounds/warp.wav"))
    @sounds[:meteor] = Gosu::Sample.new(self, media_path("sounds/meteor.wav"))
    @sounds[:laser] = Gosu::Sample.new(self, media_path("sounds/laser_sound.wav"))
    @sounds[:rlaunch] = Gosu::Sample.new(self, media_path("sounds/rlaunch.wav"))
    @sounds[:explosion] = Gosu::Sample.new(self, media_path("sounds/explosion.wav"))
    @sounds[:click] = Gosu::Sample.new(self, media_path("sounds/click.wav"))
  end

  def load_music
    @music[:theme] = Gosu::Song.new(self, media_path("music/theme.ogg"))
  end

  def load_sprites
    @sprites = {}
    @animations = {}
    Dir.glob('data/sprites/*.yaml').each do |f|
      y = YAML::load(File.open(f))
      @sprites[y['sprite']] = y

      # load any referenced files
      y['layers'].each do |layer|
        @animations[layer['file']] = Gosu::Image::load_tiles(self,
                                                         media_path("images/#{layer['file']}"),
                                                         layer['width'],
                                                         layer['height'],
                                                         false)
      end
    end

  end
end

