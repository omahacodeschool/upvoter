require 'pry'

# Tests whether a user has liked a post
RSpec.describe(Post, ".likedBy?") do
	it "checks if a post was liked by a user" do

		# Setup
		tableCleaner

		# Exercise

		# Verify

		# Teardown
		tableCleaner

	end
end

# Tests adding and/or removing a like from a post
RSpec.describe(Post, ".likeClicked") do
	it "adds or removes a like from a post" do

		# Setup
		tableCleaner

		# Exercise

		# Verify

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
