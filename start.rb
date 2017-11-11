require_relative "./source.rb"

DATABASE = Redis.new(url: ENV["REDIS_URL"])


if ENV["CONSUMER_KEY"]
	client = Twitter::REST::Client.new do |config|
		config.consumer_key = ENV["CONSUMER_KEY"]
		config.consumer_secret = ENV["CONSUMER_SECRET"]
		config.access_token = ENV["ACCESS_TOKEN"]
		config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
	end
else
	client = LocalClient.new
end

game = Game.new
game.start(client)
