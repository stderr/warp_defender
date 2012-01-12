class GameEngine
  attr_accessor :config, :level

  def initialize
    @config = Configurability::Config.load(File.expand_path(File.dirname(__FILE__) +"/../config/game_data.yml"))
    @state_manager = GameStates::StateManager.new

    @level = GameLevel.new("level_one.yml")
    @frame_counter = 0
    @frame_block_start = Gosu::milliseconds
    @fps = nil
  end

  def current_state
    @state_manager.current
  end
  
  def play_state
    @state_manager.last_play_state
  end

  def paused?
    current_state.is_a?(GameStates::Paused)
  end
  
  def playing? 
    current_state.is_a?(GameStates::Playing)
  end

  def clear_state!(state)
    @state_manager.remove_all(state)
  end
  
  def menu! 
    @state_manager.add(GameStates::MainMenu.new(self)) 
  end
 
  def pause!
    @state_manager.add(GameStates::Paused.new(self))
  end
  
  def start!
    @state_manager.add(GameStates::MainMenu.new(self))
  end
  
  def unpause! 
    clear_state!(GameStates::Paused) 
  end

  def load_level!
    @state_manager.add(GameStates::LoadLevel.new(self))
  end

  def start_playing!
    clear_state!(GameStates::LoadLevel)
    @state_manager.add(GameStates::Playing.new(self))
  end
  
  # simplify eventually
  def load_state!(state)
    @state_manager.add(state.new(self))
  end

  def button_down(id)
    current_state.button_down(id)
  end
  
  def button_up(id)
    current_state.button_up(id)
  end
  
  def draw
    current_state.draw

    if @fps
      $window.fonts[:level_description].draw("fps: %d" % @fps, 5, 5, 0, 1, 1, Gosu::Color.rgb(255, 255, 255))
    end
  end

  def update
    @frame_counter += 1
    # average fps over a 1 second period
    if Gosu::milliseconds - @frame_block_start > 1000
    	@fps = @frame_counter.to_f / ((Gosu::milliseconds - @frame_block_start) / 1000.0)
    	@frame_counter = 0
    	@frame_block_start = Gosu::milliseconds
    end

    if @level.current_defense <= 0
      @state_manager.add(GameStates::GameOver.new(self))
    end

    if playing? && @level.completed?
      if GameLevel.has_level?(@level.next_level)
        @state_manager.remove_all(GameStates::Playing)

        @level = GameLevel.new(@level.next_level)
        @state_manager.add(GameStates::LoadLevel.new(self))
      else
        @state_manager.add(GameStates::GameCompleted.new(self))
      end
    end
    
    current_state.update
  end

end
