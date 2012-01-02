$:.unshift File.expand_path(File.dirname(__FILE__))
# Global gems
require 'gosu'
require 'configurability'
require 'configurability/config'
require 'require_all'

require_all File.join(File.dirname(__FILE__), "lib")

game = Game.new
game.show


