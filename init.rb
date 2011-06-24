$:.unshift File.expand_path(File.dirname(__FILE__))

require 'gosu'
require 'lib/utils'
require 'lib/window'
require 'lib/player'
require 'lib/star'

w = GameWindow.new
w.show


