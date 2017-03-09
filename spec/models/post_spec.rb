require 'pry'

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
		click1 = DATABASE.conn.exec("SELECT * FROM likes WHERE postid='12';")
		Post.likeClicked('12', 'nennington')
		click2 = DATABASE.conn.exec("SELECT * FROM likes WHERE postid='12';")

		# Verify
		expect(click1).to be_truthy
		expect(click2).to be_falsey

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
RSpec.describe(Post, ".all") do
	it "gathers all post entries" do

		# Setup
		tableCleaner

		# Exercise

		# Verify

		# Teardown
		tableCleaner

	end
end

# Tests sorting the entries by different methods
RSpec.describe(Post, ".sort") do
	it "arranges post entries" do

		# Setup
		tableCleaner

		# Exercise

		# Verify

		# Teardown
		tableCleaner

	end
end
