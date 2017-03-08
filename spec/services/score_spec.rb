require 'pry'

# Testing .num_likes score method
RSpec.describe(Score, ".num_likes") do
	it "calculates the score for a post" do

		# Setup
		score = Database.new("upvoter_test")
		....

		# Exercise
		....

		# Validation
		....

		# Teardown
		....

	end
end

RSpec.describe(Score, ".popular_score") do
	it "calculates score decayed by time" do

		# Setup
		....

		# Exercise
		....

		# Validation
		....

		# Teardown
		....

	end
end

RSpec.describe(Score, ".decay") do
	it "deprecates a score over time" do

		# Setup
		....

		# Exercise
		....

		# Validation
		....

		# Teardown
		....

	end
end
