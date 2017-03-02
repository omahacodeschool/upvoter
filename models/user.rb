class User
DATABASE = Database.new

  def initialize(username)
    @username = username
    @info = DATABASE.find("users", "username", @username)
  end

  # Create a user.
  # 
  # user_info - Hash of user info
  def User.create(user_info)
    entry_string = "\"#{user_info["username"]}\","
    entry_string += "\"#{user_info["email"]}\",\"#{user_info["password"]}\""
    DATABASE.newEntry("users", entry_string)
  end

  # Gathers user info and changes password value.
  # Rebuilds user database.
  def newPassword(newPass)
    @info["password"] = newPass
    DATABASE.edit("users", "username", @username, format_for_database)
  end

  # Format user's info for the database.
  def format_for_database
    @info.values.join(",")
  end

  # Gather data for a specific user
  def getID
  	return @info["userID"]
  end

  # Retrieves the userID associated with a particular username.
  def posts
  	userID = getID
  	results = []
  	posts = DATABASE.all("posts", "timestamp")
  	posts.each do |k, v|
  		if v["userID"] == userID
  			results.push(k)
  		end
  	end
  	return results
  end

  # Gathers entire user database.
  def User.all
    DATABASE.all("users", "username")
  end

end