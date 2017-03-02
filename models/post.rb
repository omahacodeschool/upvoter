class Post
  DATABASE = Database.new

  def initialize(id)
    @id = id
    @info = DATABASE.find("posts", "timestamp", @id.to_s)
  end

  # Create a post.
  # 
  # post_info - Hash of post info.
  def Post.create(post_info)
    info = "\"#{post_info["userID"]}\",\"#{post_info["title"]}\",\"#{post_info["content"]}\""
    DATABASE.newEntry("posts", info)
  end

  # Get all posts.
  # 
  # Returns a Hash of all posts.
  def Post.all
    DATABASE.all("posts", "timestamp");
  end

  # Calls appropriate sort method according to desired display.
  #
  # method - String of desired sort method
  def Post.sort(method)
    if method == "newest"
      return newest()
    elsif method == "top"
      return top()
    else
      return popular()
    end
  end

  # Defines method to sort posts by age.
  # Returns array of postIDs sorted by newest first.
  def Post.newest()
    array = Post.all.keys.sort
    return array.reverse
  end

  # Defines method to sort posts by total score.
  # Returns array of postIDs sorted by score, highest first
  def Post.top()
    result = {}
    hash = Post.all
    hash.each do |k, v|
      post = Post.new(k)
      score = post.score
      result[k] = score
    end
    result = result.sort_by {|k, v| v}.to_h
    return result.keys.reverse
  end

  # Defines method to sort posts by score adjusted by age.
  def Post.popular()
    # TODO
  end
  
  # Returns amount of likes for particular post
  def score()
    hash = DATABASE.all("likes","likeID")
    score = 0
    hash.each do |k, v|
      if v["postID"] == @info["timestamp"]
        score += 1
      end
    end
    return score
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