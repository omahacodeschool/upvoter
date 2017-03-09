require 'pry'

RSpec.describe(Post, ".likedBy?") do
	it "checks if a post was liked by a user" do

		# Setup

		# Exercise

		# Verify

		# Teardown


	end
end

RSpec.describe(Post, ".likeClicked") do
	it "adds or removes a like from a post" do

		# Setup

		# Exercise

		# Verify

		# Teardown


	end
end

RSpec.describe(Post, "#newFromInfo") do
	it "creates a new Post object from given info" do
		entry = {"postid" => "1234567890", 
			"userid" => "1111111111", 
			"title" => "Hello World",
            "content" => "http://www.google.com"}

        post = Post.newFromInfo(entry)

        expected = ["1234567890","1111111111","Hello World","http://www.google.com"]
        actual   = [post.postid, post.userid, post.title, post.content]
        expect(actual).to eq(expected)
	end
end

RSpec.describe(Post, "#newFromDB") do
	it "creates a new Post object from datbase info" do
		tableCleaner
		query =  "INSERT INTO posts(postid, userid, title, content) "
		query += "VALUES ('1234567890', '1111111111', 'Hello World', 'http://www.google.com');"
		DATABASE.conn.exec(query)

		post = Post.newFromDB("1234567890")

		expected = ["1234567890","1111111111","Hello World","http://www.google.com"]
        actual   = [post.postid, post.userid, post.title, post.content]
		expect(actual).to eq(expected)

		tableCleaner
	end
end

RSpec.describe(Post, ".all") do
	it "gathers all post entries" do

		# Setup

		# Exercise

		# Verify

		# Teardown


	end
end

RSpec.describe(Post, ".sort") do
	it "arranges post entries" do

		# Setup

		# Exercise

		# Verify

		# Teardown


	end
end
