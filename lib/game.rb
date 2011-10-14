class Game < Gosu::Window

  attr_accessor :fonts

  def initialize
    super(1600, 1200, false)
    self.caption = 'Warp Defender'

    @game_engine = GameEngine.new(self)
    @game_engine.state = GameStates::Menu.new(self, @game_engine)

    @images = {}
    @fonts = {}
    @sounds = {}

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
  end

  def load_fonts
    @fonts[:menu] = Gosu::Font.new(self, 'media/font.ttf', 40)
  end

  def load_sounds
  end

end
