class User

  # Create a user.
  # 
  # user_info - Hash of user info
  def create(user_info)
    db = Database.new
    entry_string = "\"#{user_info["username"]}\","
    entry_string += "\"#{user_info["email"]}\",\"#{user_info["password"]}\""
    db.newEntry("users", entry_string)
  end

  # TODO Documentation
  def newPassword(currUser, newPass)
  	db = Database.new
  	hash = db.all("users", "username")
  	hash[currUser]["password"] = newPass
  	newLine = hash[currUser].values.join(",")
  	db.edit("users", "username", currUser, newLine)
  end

  # TODO Documentation
  def getID(username)
  	db = Database.new
  	hash = db.all("users", "username")
  	return hash[username]["userID"]
  end

  # TODO Documentation
  def posts(username)
  	userID = getID(username)
  	db = Database.new
  	results = []
  	posts = db.all("posts", "timestamp")
  	posts.each do |k, v|
  		if v["userID"] == userID
  			results.push(k)
  		end
  	end
  	return results
  end

end