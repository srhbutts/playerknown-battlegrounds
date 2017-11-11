class Game
	WEAPONS_LOCATION = "https://gist.githubusercontent.com/krainboltgreene/c67b666b3cbd453381677c51217e5b40/raw/283aff01e036a45615447a61627e29a44b28ec51/weapons.csv"
	HANDGUNS_LOCATION = "https://gist.githubusercontent.com/krainboltgreene/c67b666b3cbd453381677c51217e5b40/raw/29a994bdc0f03ffcaaede6ecfa8c856ce07846f3/handguns.csv"

	WEAPONS = CSV.parse(open(WEAPONS_LOCATION)).flatten
	HANDGUNS = CSV.parse(open(HANDGUNS_LOCATION)).flatten

	TOTAL_PLAYERS = 3

	def initialize()
		if DATABASE.smembers("players").nil? || DATABASE.smembers("players").empty?
			@names = (TOTAL_PLAYERS * 1000).times.map do Generator.name() end.uniq().first(TOTAL_PLAYERS)
			DATABASE.sadd("players", generate_players(TOTAL_PLAYERS))
		end
		@players = DATABASE.smembers("players").map do |json|
			Player.from(json)
		end
	end

	def start(client)
		unless @players.size == 1
			client.update(murder)
		end
	end

	def pick_name()
		fail("not enough names in #{NAMES_LOCATION}") if @names.size.zero?
    	return @names.delete(@names.sample)
	end

	private def murder()
		killer, killed = @players.sample(2)
		binding.pry
		@players.delete(killed)
		
		DATABASE.srem("players", killed)

		return "#{killer.name} has killed #{killed.name} with #{killer.weapon} - #{@players.length} players remaining"
	end

	private def generate_players(number)
		return number.times.map do
			generate_player()
		end
	end

	private def generate_player()
		return Player.new(pick_name())
	end
end