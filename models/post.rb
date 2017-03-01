class Post
  DATABASE = Database.new

  # Create a post.
  # 
  # post_info - Hash of post info.
  def create(post_info)
    info = "\"#{post_info["userID"]}\","
    info += "\"#{post_info["score"]}\",\"#{post_info["likedIDs"]}\""
    info += "\"#{post_info["dislikeIDs"]}\",\"#{post_info["title"]}\""
    info += "\"#{post_info["content"]}\""

    DATABASE.append("posts", info)
  end

  # Get all posts.
  # 
  # Returns a Hash of all posts.
  def all
    DATABASE.all("posts", "timestamp");
  end
end