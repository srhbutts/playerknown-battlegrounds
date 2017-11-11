module Generator
	NAME_LOCATION = ENV["NAMES_LOCATION"] || File.join(".", "json", "names.json")
	WEAPON_LOCATION = ENV["WEAPONS_LOCATION"] || File.join(".", "json", "weapons.json")

	def self.name()
		return Grammar.new(JSON.parse(File.read(open(NAME_LOCATION)))).flatten("#origin#")
	end
	
	def self.weapon()
		return Grammar.new(JSON.parse(File.read(open(WEAPON_LOCATION)))).flatten("#origin#")
	end
end