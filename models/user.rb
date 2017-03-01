class User
  DATABASE = Database.new

  # Create a user.
  # 
  # user_info - Hash of user info
  def create(user_info)
    entry_string = "\"#{user_info["username"]}\","
    entry_string += "\"#{user_info["email"]}\",\"#{user_info["password"]}\""
    DATABASE.newEntry("users", entry_string)
  end

  # TODO Documentation
  def newPassword(currUser, newPass)
  	all[currUser]["password"] = newPass
  	newLine = all[currUser].values.join(",")
  	DATABASE.edit("users", "username", currUser, newLine)
  end

  # TODO Documentation
  def getID(username)
  	return all.[username]["userID"]
  end

  # TODO Documentation
  def posts(username)
  	userID = getID(username)
  	results = []
  	posts = DATABASE.all("posts", "timestamp")
  	posts.each do |k, v|
  		if v["userID"] == userID
  			results.push(k)
  		end
  	end
  	return results
  end

  # TODO Documentation
  def User.all
    DATABASE.all("users", "username")
  end

end