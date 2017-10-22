module Generator
	NAME_LOCATION = ENV["NAMES_LOCATION"] || File.join(".", "json", "names.json")

	def self.name()
		return Grammar.new(JSON.parse(File.read(open(NAME_LOCATION)))).flatten("#origin#")
	end
end