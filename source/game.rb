class Game
	NAMES_LOCATION = "https://gist.githubusercontent.com/krainboltgreene/c67b666b3cbd453381677c51217e5b40/raw/283aff01e036a45615447a61627e29a44b28ec51/names.csv"
	WEAPONS_LOCATION = "https://gist.githubusercontent.com/krainboltgreene/c67b666b3cbd453381677c51217e5b40/raw/283aff01e036a45615447a61627e29a44b28ec51/weapons.csv"
	HANDGUNS_LOCATION = "https://gist.githubusercontent.com/krainboltgreene/c67b666b3cbd453381677c51217e5b40/raw/29a994bdc0f03ffcaaede6ecfa8c856ce07846f3/handguns.csv"

	NAMES = CSV.parse(open(NAMES_LOCATION)).flatten
	WEAPONS = CSV.parse(open(WEAPONS_LOCATION)).flatten
	HANDGUNS = CSV.parse(open(HANDGUNS_LOCATION)).flatten

	TOTAL_PLAYERS = 3

	def initialize()
		@names = NAMES.dup
		@players = generate_players(TOTAL_PLAYERS)
	end

	def start(client)
		until @players.size == 1 do
			client.update(murder)
		end
	end

	def pick_name()
		fail("not enough names in #{NAMES_LOCATION}") if @names.size.zero?
		return @names.delete(@names.sample)
	end

	private def murder()
		killer, killed = @players.sample(2)

		@players.delete(killed)

		return "#{killer.name} has killed #{killed.name} with #{killer.weapon} - #{@players.length} players remaining"
	end

	private def generate_players(number)
		return number.times.map do
			generate_player()
		end
	end

	private def generate_player()
		return Player.new(self)
	end
end