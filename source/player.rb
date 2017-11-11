class Player
	def self.from(json)
		new(Oj.load(json).fetch("name"))
	end
	
	def initialize(name)
		@name = name
	end

	def weapon()
		return Generator.weapon
	end

	def name()
		return @name
	end

	def to_s()
		Oj.dump(instance_variables.map { |name| { name.to_s.gsub("@", "") => instance_variable_get(name) } }.reduce(&:merge))
	end
end