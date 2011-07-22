$:.unshift File.expand_path(File.dirname(__FILE__))

require 'gosu'

require 'lib/utils'
require 'lib/window'
require 'lib/player'
require 'lib/star'
require 'lib/debris'
require 'lib/warp'
require 'lib/meteor'
require 'lib/explosion'

w = GameWindow.new
w.show


