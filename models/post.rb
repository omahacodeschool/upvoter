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

  # Gathers data for a specific post entry
  def getData(postID)
    db = Database.new
    hash = db.all("posts", "postID")
    return hash[postID]
  end

  # Calls specific sorting method.
  def sort(method)
    if method == "newest"
      return newest()
    elsif method == "top"
      return top()
    else
      return popular()
    end
  end

  # Constructs an array of posts for display on page
  def buildArr(sorted)
    result = []
    sorted.each do |k, v|
      result.push(v)
    end
    return result
  end

  # Defines sort method for posts by timestamp.
  def newest()
    db = Database.new
    hash = db.all("posts", "timestamp")
    hash = hash.sort
    return buildArr(hash).reverse
  end

  # Defines sort method for posts by total score.
  def top()
    db = Database.new
    
  end

  # Defines sort method for posts by score adjusted for age.
  def popular()

  end

end