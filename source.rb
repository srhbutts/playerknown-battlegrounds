require "oj" # json parser
require "csv"
require "twitter"
require "open-uri"
require "pry"
require_relative "source/game"
require_relative "source/player"

# get credentials from env
# instantiate twitter client
# pass twitter client to start

game = Game.new
game.start()

binding.pry