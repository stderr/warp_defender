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
require 'lib/player'

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

require 'lib/entities/entity'
require 'lib/entities/grunt'

require 'lib/player'
require 'lib/star'
require 'lib/debris'
require 'lib/warp'
require 'lib/meteor'
require 'lib/explosion'
require 'lib/bullet'


game = Game.new
game.show


