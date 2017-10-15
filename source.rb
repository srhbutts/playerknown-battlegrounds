require "oj" # json parser
require "csv"
require "twitter"
require "open-uri"
require "pry"
require_relative "source/game"
require_relative "source/player"
require_relative "source/local_client"


client = Twitter::REST::Client.new do |config|
	config.consumer_key = ENV["CONSUMER_KEY"]
	config.consumer_secret = ENV["CONSUMER_SECRET"]
	config.access_token = ENV["ACCESS_TOKEN"]
	config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end

#client = LocalClient.new

game = Game.new
game.start(client)