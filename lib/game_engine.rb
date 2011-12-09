class GameEngine
  attr_accessor :states, :config

  def initialize(window)
    @config = Configurability::Config.load(File.expand_path(File.dirname(__FILE__) +"/../config/game_data.yml"))

    @window = window
    @states = []
  end

  def update
    @states.last.update
  end

  def draw
    @states.last.draw
  end

  def button_down(id)
    @states.last.button_down(id)
  end

  def button_up(id)
    @states.last.button_up(id)
  end
  
end
