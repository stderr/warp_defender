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

require 'lib/game_states/game_state'
require 'lib/game_states/paused'
require 'lib/game_states/playing'
require 'lib/game_states/credits'

# Menu states
require 'lib/game_states/menu/base_menu'
require 'lib/game_states/menu/main_menu'
require 'lib/game_states/menu/options'
require 'lib/game_states/menu/audio'
require 'lib/game_states/menu/display'
require 'lib/game_states/menu/menu_item'

require 'lib/behaviors/behavior'
require 'lib/behaviors/beeline'
require 'lib/behaviors/hunt' 

require 'lib/physics/dynamic'

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


