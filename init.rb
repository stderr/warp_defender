$:.unshift File.expand_path(File.dirname(__FILE__))
# Global gems
require 'gosu'
require 'configurability'
require 'configurability/config'

# Load all files in lib/
Dir[File.join(File.dirname(__FILE__), "lib") + "/*.rb"].each do |file|
  require file
end

game = Game.new
game.show


