class User

	attr_reader :userid, :username, :email, :password
	attr_writer :userid, :username, :email, :password

	# Returns an Array of post_ids that this user likes.
	def likes
		@likes ||= fetch_likes
	end

	# Creates a new user from hash of user info
	def User.newFromInfo(info)
		newUser = User.new
		newUser.userid = info["userid"].nil? ? Time.now.to_f.to_s : info["userid"]
		newUser.username = info["username"]
		newUser.email = info["email"]
		newUser.password = info["password"]
		return newUser
	end

	# Creates a new User from database info
	def User.newFromDB(username)
		@username = username
		info = DATABASE.find("users", "username", @username)
		return User.newFromInfo(info)
	end

	# Creates a new User using ID info
	def User.newFromDBbyID(userid)
		@userid = userid
		info = DATABASE.find("users", "userid", @userid)
		return User.newFromInfo(info)
	end

	# Check if a username/password combo is present in the database
	def User.loginValid?(username,password)
		row = DATABASE.find("users","username",username)
		if row.nil? then return false end
		return row["password"] == password
	end

	# Write this user to the users table
	def register()
	entry = {"userid" => @userid, "username" => @username, "email" => @email, "password" => @password}
	DATABASE.newEntry("users", entry)
	end

	# Changes password
	#
	# newPass - String from user input
	def newPassword(newPass)
		DATABASE.edit("users", "password", newPass, "username", @username)
	end

	def posts
		puts '\n\nRunning User#posts\n\n'
		posts = DATABASE.conn.exec("SELECT postid FROM posts WHERE userid='#{@userid}';")
		posts = posts.values.flatten
		return posts
	end

	private

	def fetch_likes
		puts "\n\n--------------------------FIND! User#fetch_likes?\n\n"
		like_rows = DATABASE.find_all("likes", "userid", userid)
		like_rows.map { |row| row["postid"] }
	end

end