class Post
  attr_reader :info
  attr_reader :score

  MINUTE = 60
  HOUR = 60*MINUTE
  DAY = 24*HOUR
  WEEK = 7*DAY
  MONTH = 4*WEEK

  def initialize(id)
    @id = id
    @info = DATABASE.find("posts", "postID", @id.to_s)
    @score = Score.new(id)
  end

  def likedBy?(user)
    uid = DATABASE.find("users", "username", user)["userID"]
    hash = DATABASE.all("likes","likeID")
    liked = false
    hash.each do |k, v|
      if v["userID"] == uid && v["postID"] == @id
        liked = true
      end
    end
    return liked
  end

  def Post.likeClicked(postID, user)
    uid = DATABASE.find("users", "username", user)["userID"]
    thispost = Post.new(postID)
    if thispost.likedBy?(user)
      thispost.removeLike(uid)
    elsif !uid.nil?
      thispost.addLike(uid)
    end
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
    DATABASE.all("posts", "postID");
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
    Post.all.each do |k, v|
      result[k] = Post.new(k).score.value
    end
    result = result.sort_by {|k, v| v}.to_h
    return result.keys.reverse
  end

  # Defines method to sort posts by score adjusted by age.
  def Post.popular()
    result = {}
    Post.all.each do |k, v|
      result[k] = Post.new(k).score.popular_value
    end
    result = result.sort_by {|k, v| v}.to_h
    return result.keys.reverse
  end

  # TODO Should the below be returning an array of "infos" so the erb
  # could do post["content"] rather than post.info["content"]?

  # Returns an array of the 25 Posts for the specified page, or nil
  #
  # sort_method - String of sort method for page
  # page_number - Integer page number
  def Post.page(sort_method,page_number)
    pageIDs = Post.pageIDs(sort_method,page_number)
    if pageIDs.nil? 
      return nil
    else
      return Post.IDsToPosts(pageIDs)
    end
  end

  # Get the top ranked post for a given sort method
  #
  # sort_method - String of sort method
  # Returns the top ranked Post
  def Post.featured(sort_method)
    pageID = Post.sort(sort_method)[0]
    return Post.new(pageID)
  end

  def addLike(uid)
    row = @id.to_s + "," + uid.to_s
    DATABASE.newEntry("likes", row)
  end

  def removeLike(uid)
    hash = DATABASE.all("likes","likeID")
    lid = nil
    hash.each do |k, v|
      if v["userID"] == uid && v["postID"] == @id
        lid = k
      end
    end
    DATABASE.delete("likes","likeID", lid)
  end

  private

  def Post.IDsToPosts(postIDs)
    posts = []
    for id in postIDs
      posts.push(Post.new(id))
    end
    return posts
  end

  def Post.pageIDs(sort_method,page_number)
    postIDs = Post.sort(sort_method)
    start_post = (page_number-1)*25
    end_post = start_post + 24
    return postIDs[start_post..end_post]
  end

end