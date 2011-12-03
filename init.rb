$:.unshift File.expand_path(File.dirname(__FILE__))

require 'gosu'

require 'lib/game'
require 'lib/game_engine'
require 'lib/sprite'
require 'lib/utils'
require 'lib/player'

require 'lib/game_states/game_state'
require 'lib/game_states/menu'
require 'lib/game_states/options'
require 'lib/game_states/paused'
require 'lib/game_states/playing'
require 'lib/game_states/credits'

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


