class Post
  DATABASE = Database.new

  def initialize(id)
    @id = id
    @info = DATABASE.find("posts", "timestamp", @id)
  end

  # Create a post.
  # 
  # post_info - Hash of post info.
  def Post.create(post_info)
    info = "\"#{post_info["userID"]}\","
    info += "\"#{post_info["score"]}\",\"#{post_info["likedIDs"]}\""
    info += "\"#{post_info["dislikeIDs"]}\",\"#{post_info["title"]}\""
    info += "\"#{post_info["content"]}\""

    DATABASE.append("posts", info)
  end

  # Get all posts.
  # 
  # Returns a Hash of all posts.
  def Post.all
    DATABASE.all("posts", "timestamp");
  end

  def Post.sort(method)
    if method == "newest"
      return newest()
    elsif method == "top"
      return top()
    else
      return popular()
    end
  end

  def Post.newest()
    hash = DATABASE.all("posts", "timestamp")
    hash = hash.sort
    return buildArr(hash).reverse
  end

  def Post.top()
  end

  def Post.popular()
  end

  private

  def Post.buildArr(sorted)
    result = []
    sorted.each do |k, v|
      result.push(v)
    end
    return result
  end

end