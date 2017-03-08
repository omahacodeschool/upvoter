require 'pry'

# Testing .num_likes score method
RSpec.describe(Score, ".num_likes") do
	it "calculates the score for a post" do

		# Setup
		score = Database.new("upvoter_test")
		uf = UpvoteFaker.new
		uf.fakeUserWithCredentials("testington","fakecat")
		uf.fakePost("1")
		uf.fakeLike("1",20)

		# Exercise
		testPost = Post.new("1")
		sco = testPost.score.num_likes

		# Validation
		expect(testPost.score.value).to eq(20)

		# Teardown
		DATABASE.delete("posts", "postid", "'1'")
		DATABASE.delete("users", "username", "'testington'")

	end
end

# RSpec.describe(Score, ".popular_score") do
# 	it "calculates score decayed by time" do

# 		# Setup
# 		score = Database.new("upvoter_test")
# 		uf = UpvoteFaker.new
# 		testNow = uf.tsFrom(0,1,"h")
# 		testHour = uf.tsFrom(1,7,"h")
# 		testDay = uf.tsFrom(9,20,"h")
# 		testWeek = uf.tsFrom(2,5,"d")
# 		testMonth = uf.tsFrom(2,3,"w")
# 		testYear = uf.tsFrom(8,40,"w")
# 		uf.fakePost(testNow)
# 		uf.fakeLike(testNow, 100)
# 		uf.fakePost(testHour)
# 		uf.fakeLike(testHour, 100)
# 		uf.fakePost(testDay)
# 		uf.fakeLike(testDay, 100)
# 		uf.fakePost(testWeek)
# 		uf.fakeLike(testWeek, 100)
# 		uf.fakePost(testMonth)
# 		uf.fakeLike(testMonth, 100)
# 		uf.fakePost(testYear)
# 		uf.fakeLike(testYear, 100)
# 		nowPost = Post.new(testNow)
# 		hourPost = Post.new(testHour)
# 		dayPost = Post.new(testDay)
# 		weekPost = Post.new(testWeek)
# 		monthPost = Post.new(testMonth)
# 		yearPost = Post.new(testYear)


# 		# Exercise
# 		scores = [nowPost.score.popular_score, hourPost.score.popular_score, dayPost.score.popular_score, weekPost.score.popular_score, monthPost.score.popular_score, yearPost.score.popular_score]
		

# 		# Validation
# 		expect(scores).to be eq([100, 95, 75, 50, 25, 15])

# 		# Teardown
# 		DATABASE.delete("posts", "postid", testNow)
# 		DATABASE.delete("posts", "postid", testHour)
# 		DATABASE.delete("posts", "postid", testDay)
# 		DATABASE.delete("posts", "postid", testWeek)
# 		DATABASE.delete("posts", "postid", testMonth)
# 		DATABASE.delete("posts", "postid", testYear)
# 		DATABASE.delete("likes", "postid", testNow)
# 		DATABASE.delete("likes", "postid", testHour)
# 		DATABASE.delete("likes", "postid", testDay)
# 		DATABASE.delete("likes", "postid", testWeek)
# 		DATABASE.delete("likes", "postid", testMonth)
# 		DATABASE.delete("likes", "postid", testYear)

# 	end
# end

# RSpec.describe(Score, ".decay") do
# 	it "deprecates a score over time" do

# 		# Setup
# 		....

# 		# Exercise
# 		testpost.decay

# 		# Validation
# 		....

# 		# Teardown
# 		....

# 	end
# end
