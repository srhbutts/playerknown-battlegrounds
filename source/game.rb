class Game

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
		@players.delete(killed)
		
		DATABASE.srem("players", killed)
		
		if @players.size == 1 
			DATABASE.srem("players", killer)
		end
		
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