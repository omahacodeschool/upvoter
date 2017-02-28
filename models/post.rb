class Post

  # Create a post.
  # 
  # post_info - Hash of post info.
  def create(post_info)
    db = Database.new

    info = "\"#{post_info["userID"]}\","
    info += "\"#{post_info["score"]}\",\"#{post_info["likedIDs"]}\""
    info += "\"#{post_info["dislikeIDs"]}\",\"#{post_info["title"]}\""
    info += "\"#{post_info["content"]}\""

    db.append("posts", info)
  end

  # Get all posts.
  # 
  # Returns a Hash of all posts.
  def all
    db = Database.new
    db.all("posts", "timestamp");
  end
end