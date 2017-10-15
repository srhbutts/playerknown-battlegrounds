class Player
	def initialize()
		@name = generate_name()
		@primary = generate_primary()
		@secondary = generate_secondary()
		@handgun = generate_handgun()
	end

	def weapon()
		return [@primary, @secondary, @handgun].sample
	end

	def name()
		return @name
	end

	private def generate_name()
		return Game::NAMES.sample
	end

	private def generate_primary()
		return Game::WEAPONS.sample
	end

	private def generate_secondary()
		return Game::WEAPONS.sample
	end

	private def generate_handgun()
		return Game::HANDGUNS.sample
	end
end