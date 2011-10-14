class GameEngine

  attr_accessor :state

  def initialize(window)
    @window = window
  end

  def update
    @state.update
  end

  def draw
    @state.draw
  end

  def button_down(id)
    @state.button_down(id)
  end

  def button_up(id)
    @state.button_up(id)
  end

end
