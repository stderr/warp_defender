class GameEngine
  attr_accessor :states, :config, :level

  def initialize
    @config = Configurability::Config.load(File.expand_path(File.dirname(__FILE__) +"/../config/game_data.yml"))
    @states = []
    @level = GameLevel.new("level_one.yml")
  end

  def update
    if @level.completed?
      if GameLevel.has_level?(@level.next_level)
        @level = GameLevel.new(@level.next_level)
      else
        @states.push(GameStates::GameOver.new(self))
      end
    end

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
