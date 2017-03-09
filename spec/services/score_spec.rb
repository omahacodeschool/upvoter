# TODO Test Score in isolation, no need to connect to DB at all.

require 'pry'

# Testing .popular_score method
RSpec.describe(Score, ".popular_score") do
	it "calculates score decayed by time" do

		# Setup
		tableCleaner
		score = Database.new("upvoter_test")
		uf = UpvoteFaker.new
		uf.fakeUserWithCredentials("testington","fakecat")
		testNow = uf.tsFrom(0,1,"h").to_s
		testHour = uf.tsFrom(1,7,"h").to_s
		testDay = uf.tsFrom(9,20,"h").to_s
		testWeek = uf.tsFrom(2,5,"d").to_s
		testMonth = uf.tsFrom(2,3,"w").to_s
		testYear = uf.tsFrom(8,40,"w").to_s
		uf.fakePost(testNow)
		uf.fakeLike(testNow, 100)
		uf.fakePost(testHour)
		uf.fakeLike(testHour, 100)
		uf.fakePost(testDay)
		uf.fakeLike(testDay, 100)
		uf.fakePost(testWeek)
		uf.fakeLike(testWeek, 100)
		uf.fakePost(testMonth)
		uf.fakeLike(testMonth, 100)
		uf.fakePost(testYear)
		uf.fakeLike(testYear, 100)
		nowPost = Post.newFromDB(testNow)
		hourPost = Post.newFromDB(testHour)
		dayPost = Post.newFromDB(testDay)
		weekPost = Post.newFromDB(testWeek)
		monthPost = Post.newFromDB(testMonth)
		yearPost = Post.newFromDB(testYear)

		# Exercise
		scores = [nowPost.score.popular_score, hourPost.score.popular_score, dayPost.score.popular_score, weekPost.score.popular_score, monthPost.score.popular_score, yearPost.score.popular_score]

		# Validation
		expect(scores).to eq([100, 95.0, 75.0, 50.0, 25.0, 15.0])

		# Teardown
		tableCleaner

	end
end
