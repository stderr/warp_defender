$:.unshift File.expand_path(File.dirname(__FILE__))
# Global gems
require 'gosu'
require 'configurability'
require 'configurability/config'

# Library files
require 'lib/game'
require 'lib/game_engine'
require 'lib/sprite'
require 'lib/utils'
require 'lib/game_level'

# Game states
require 'lib/game_states/game_state'
require 'lib/game_states/paused'
require 'lib/game_states/playing'
require 'lib/game_states/credits'
require 'lib/game_states/game_over'
require 'lib/game_states/load_level'

# Menu states
require 'lib/game_states/menu/base_menu'
require 'lib/game_states/menu/main_menu'
require 'lib/game_states/menu/options'
require 'lib/game_states/menu/audio'
require 'lib/game_states/menu/display'

# GUI
require 'lib/gui/base_element'
require 'lib/gui/text'
require 'lib/gui/checkbox'
require 'lib/gui/mini_map'
require 'lib/gui/bar'
require 'lib/gui/level_dialog'

# Behaviors
require 'lib/behaviors/behavior'
require 'lib/behaviors/beeline'
require 'lib/behaviors/hunt'

# Physics
require 'lib/physics/dynamic'

# Render
require 'lib/render/sprite'

# Entities
require 'lib/entities/entity'
require 'lib/entities/grunt'
require 'lib/entities/player'
require 'lib/entities/star'
require 'lib/entities/debris'
require 'lib/entities/warp'
require 'lib/entities/meteor'
require 'lib/entities/explosion'
require 'lib/entities/bullet'


game = Game.new
game.show


