class User
  def create(user_info)
    db = Database.new
    
    entry_string = "\"#{user_info["username"]}\","
    entry_string += "\"#{user_info["email"]}\",\"#{user_info["password"]}\""

    db.append("posts", info)
  end
end