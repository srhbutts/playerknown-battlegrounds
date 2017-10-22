require_relative "./spec_helper"

RSpec.describe Generator do
	describe ".name" do
		it "returns a single trace based on location of name tracery file" do
			expect(Generator.name()).to be_kind_of(String)
		end
	end
end