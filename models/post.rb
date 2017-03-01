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

  def getData(postID)
    hash = DATABASE.all("posts", "postID")
    return hash[postID]
  end

  def sort(method)
    if method == "newest"
      return newest()
    elsif method == "top"
      return top()
    else
      return popular()
    end
  end

  def buildArr(sorted)
    result = []
    sorted.each do |k, v|
      result.push(v)
    end
    return result
  end

  def newest()
    
    hash = DATABASE.all("posts", "timestamp")
    hash = hash.sort
    return buildArr(hash).reverse
  end

  def top()
    
    
  end

  def popular()

  end

end