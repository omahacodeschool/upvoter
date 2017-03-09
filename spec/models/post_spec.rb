require 'pry'

# Testing .num_likes score method
RSpec.describe(Post, ".num_likes") do
	it "calculates the score for a post" do
		# Score.new(342890234, 23)


		# Setup
		tableCleaner
		score = Database.new("upvoter_test")
		uf = UpvoteFaker.new
		uf.fakeUserWithCredentials("testington","fakecat")
		uf.fakePost("1")
		uf.fakeLike("1",20)

		# Exercise
		testPost = Post.newFromDB("1")
		score = testPost.num_likes
		binding.pry

		# Validation
		expect(score).to eq(20)

		# Teardown
		tableCleaner

	end
end

# Tests whether a user has liked a post
RSpec.describe(Post, ".likedBy?") do
	it "checks if a post was liked by a user" do

		# Setup
		tableCleaner
		post = Post.new
		post.postid = "12"
		post.userid = "140"
		post.title = "foob"
        post.content = "arrr"
		query =  "INSERT INTO users(userid, username, email, password) "
		query += "VALUES ('140', 'nennington', 'whatever@meow.cat', 'tail');"
		DATABASE.conn.exec(query)
        query1 =  "INSERT INTO users(userid, username, email, password) "
		query1 += "VALUES ('160', 'cowboy', 'sixshooter@dusty.cow', 'trail');"
		DATABASE.conn.exec(query1)
        entry = {"postid" => '12', "userid" => '140'}
    	DATABASE.newEntry("likes", entry)

		# Exercise
		nenlike = post.likedBy?('nennington')
		cowlike = post.likedBy?('cowboy')

		# Verify
		expect(nenlike).to be true
		expect(cowlike).to be false

		# Teardown
		tableCleaner

	end
end

# Tests adding and/or removing a like from a post
RSpec.describe(Post, ".likeClicked") do
	it "adds or removes a like from a post" do

		# Setup
		tableCleaner
		query =  "INSERT INTO posts(postid, userid, title, content) "
		query += "VALUES ('12', '140', 'whatever@meow.cat', 'tail');"
		DATABASE.conn.exec(query)
		query =  "INSERT INTO users(userid, username, email, password) "
		query += "VALUES ('140', 'nennington', 'whatever@meow.cat', 'tail');"
		DATABASE.conn.exec(query)

		# Exercise
		Post.likeClicked('12', 'nennington')
		click1 = DATABASE.conn.exec("SELECT * FROM likes WHERE postid='12';").to_a.length
		Post.likeClicked('12', 'nennington')
		click2 = DATABASE.conn.exec("SELECT * FROM likes WHERE postid='12';").to_a.length

		# Verify
		expect(click1).to eq(1)
		expect(click2).to eq(0)

		# Teardown
		tableCleaner

	end
end

RSpec.describe(Post, "#newFromInfo") do
	it "creates a new Post object from given info" do

		# Setup
		entry = {"postid" => "1234567890", 
			"userid" => "1111111111", 
			"title" => "Hello World",
            "content" => "http://www.google.com"}

        # Exercise
        post = Post.newFromInfo(entry)

        # Verify
        expected = ["1234567890","1111111111","Hello World","http://www.google.com"]
        actual   = [post.postid, post.userid, post.title, post.content]
        expect(actual).to eq(expected)

	end
end

RSpec.describe(Post, "#newFromDB") do
	it "creates a new Post object from datbase info" do

		# Setup
		tableCleaner
		query =  "INSERT INTO posts(postid, userid, title, content) "
		query += "VALUES ('1234567890', '1111111111', 'Hello World', 'http://www.google.com');"
		DATABASE.conn.exec(query)

		# Exercise
		post = Post.newFromDB("1234567890")

		# Verify
		expected = ["1234567890","1111111111","Hello World","http://www.google.com"]
        actual   = [post.postid, post.userid, post.title, post.content]
		expect(actual).to eq(expected)

		# Teardown
		tableCleaner

	end
end

RSpec.describe(Post, ".save") do
	it "saves a post entry to the database" do

		# Setup
		tableCleaner
		post = Post.new
		post.postid = "1234567890"
		post.userid = "111"
		post.title = "foob"
        post.content = "arrr"

        # Exercise
        post.save
        expected = {"postid"=>"1234567890",
 			"userid"=>"111",
 			"title"=>"foob",
 			"content"=>"arrr"}
        post_info = DATABASE.conn.exec("SELECT * FROM posts WHERE postid='1234567890';")[0]
       
       # Verify
        expect(post_info).to eq(expected)

        # Teardown
        tableCleaner

    end
end

# Tests returning all entries from posts table
RSpec.describe(Post, ".page") do
	it "...." do

		# Setup
		tableCleaner
		uf = UpvoteFaker.new
		uf.fakeUserWithCredentials("testington","fakecat")
		testNow = uf.tsFrom(0,1,"h").to_s
		testHour = uf.tsFrom(1,7,"h").to_s
		testDay = uf.tsFrom(9,20,"h").to_s
		testWeek = uf.tsFrom(2,5,"d").to_s
		testMonth = uf.tsFrom(2,3,"w").to_s
		testYear = uf.tsFrom(8,40,"w").to_s
		uf.fakePost(testNow)
		uf.fakeLike(testNow, 90)
		uf.fakePost(testHour)
		uf.fakeLike(testHour, 100)
		uf.fakePost(testDay)
		uf.fakeLike(testDay, 40)
		uf.fakePost(testWeek)
		uf.fakeLike(testWeek, 99)
		uf.fakePost(testMonth)
		uf.fakeLike(testMonth, 98)
		uf.fakePost(testYear)
		uf.fakeLike(testYear, 97)
		uf.fakePosts(30, {"start" => 400, "end" => 500,"unit" => "d"})
		nowPost = Post.newFromDB(testNow)
		hourPost = Post.newFromDB(testHour)
		dayPost = Post.newFromDB(testDay)
		weekPost = Post.newFromDB(testWeek)
		monthPost = Post.newFromDB(testMonth)
		yearPost = Post.newFromDB(testYear)

		# Exercise
		actualNew = Post.page("newest", 1)[0..5].map {|post| post.postid}
		actualTop = Post.page("top", 1)[0..5].map {|post| post.postid}
		actualPop = Post.page("popular", 1)[0..5].map {|post| post.postid}
		actual2 = Post.page("newest", 2).to_a.length

		# Verify
		expect(actualNew).to eq([testNow, testHour, testDay, testWeek, testMonth, testYear])
		expect(actualPop).to eq([testHour, testNow, testWeek, testDay, testMonth, testYear])
		expect(actualTop).to eq([testHour, testWeek, testMonth, testYear, testNow, testDay])
		expect(actual2).to eq(11)

		# Teardown
		tableCleaner

	end
end

