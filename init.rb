$:.unshift File.expand_path(File.dirname(__FILE__))

require 'gosu'

require 'lib/game'
require 'lib/game_engine'

require 'lib/game_states/game_state'
require 'lib/game_states/menu'
require 'lib/game_states/options'
require 'lib/game_states/playing'
require 'lib/game_states/credits'

require 'lib/utils'
require 'lib/player'
require 'lib/star'
require 'lib/debris'
require 'lib/warp'
require 'lib/meteor'
require 'lib/explosion'
require 'lib/bullet'


game = Game.new
game.show


