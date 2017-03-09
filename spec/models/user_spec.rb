RSpec.describe(User,"#newFromInfo") do
	it "creates a new User with info from a hash" do
		entry = {"userid" => "1234567890", 
			"username" => "Able", 
			"email" => "bravocharlie@delta.echo",
            "password" => "foxtrot"}

        user = User.newFromInfo(entry)

        expected = ["1234567890","Able","bravocharlie@delta.echo","foxtrot"]
        actual   = [user.userid, user.username, user.email, user.password]
        expect(actual).to eq(expected)
	end
end

RSpec.describe(User,"#newFromDB") do
	it "creates a new User with info from the users table" do
		tableCleaner
		query =  "INSERT INTO users(userid, username, email, password) "
		query += "VALUES ('1234567890', 'Able', 'bravocharlie@delta.echo', 'foxtrot');"
		DATABASE.conn.exec(query)

		user = User.newFromDB("Able")

		expected = ["1234567890","Able","bravocharlie@delta.echo","foxtrot"]
        actual   = [user.userid, user.username, user.email, user.password]
		expect(actual).to eq(expected)

		tableCleaner
	end
end

RSpec.describe(User,".loginValid?") do
	it "checks to see if a username/password combination exists" do
		tableCleaner
		query =  "INSERT INTO users(userid, username, email, password) "
		query += "VALUES ('1234567890', 'Able', 'bravocharlie@delta.echo', 'foxtrot');"
		DATABASE.conn.exec(query)

		expect(User.loginValid?("Able","foxtrot")).to be true
		#TODO Should we also test an invalid combo?

		tableCleaner
	end
end

RSpec.describe(User,".register") do
	it "saves the User to the database" do
		tableCleaner
		user = User.new
		user.userid = "1234567890"
		user.username = "Able"
		user.email = "bravocharlie@delta.echo"
        user.password = "foxtrot"

        user.register
        expected = {"userid"=>"1234567890",
 			"username"=>"Able",
 			"email"=>"bravocharlie@delta.echo",
 			"password"=>"foxtrot"}
        user_info = DATABASE.conn.exec("SELECT * FROM users WHERE username='Able';")[0]
       
        expect(user_info).to eq(expected)

        tableCleaner
	end
end

RSpec.describe(User,".newPassword") do
	it "changes a User's password in the database" do
		tableCleaner
		query =  "INSERT INTO users(userid, username, email, password) "
		query += "VALUES ('1234567890', 'Able', 'bravocharlie@delta.echo', 'foxtrot');"
		DATABASE.conn.exec(query)
		user = User.new
		user.username = "'Able'"

        user.newPassword("'gamma'")
        expected = {"userid"=>"1234567890",
 			"username"=>"Able",
 			"email"=>"bravocharlie@delta.echo",
 			"password"=>"gamma"}
        user_info = DATABASE.conn.exec("SELECT * FROM users WHERE username='Able';")[0]
       
        expect(user_info).to eq(expected)

        tableCleaner
	end
end

RSpec.describe(User,".posts") do
	it "returns an array of postids for this User's posts" do
		tableCleaner
		user = User.new
		user.userid = "1"
		post1_q =  "INSERT INTO posts(postid, userid, title, content) "
		post1_q += "VALUES ('1234567890', '1', 'Post 1', 'http://able.com');"
		post2_q =  "INSERT INTO posts(postid, userid, title, content) "
		post2_q += "VALUES ('1234567891', '1', 'Post 2', 'http://bravo.com');"
		DATABASE.conn.exec(post1_q)
		DATABASE.conn.exec(post2_q)

		expect(user.posts).to eq(['1234567890','1234567891'])

		tableCleaner
	end
end