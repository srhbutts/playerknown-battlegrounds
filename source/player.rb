class Player
	def self.from(json)
		new(Oj.load(json).fetch("name"))
	end
	
	def initialize(name)
		@name = name
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

	def to_s()
		Oj.dump(instance_variables.map { |name| { name.to_s.gsub("@", "") => instance_variable_get(name) } }.reduce(&:merge))
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