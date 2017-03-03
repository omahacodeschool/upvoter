class Post
  attr_reader :info
  attr_reader :score

  DATABASE = Database.new
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

  def Post.page(sort_method,page_number)
    posts = Post.sort(sort_method)
    start_post = (page_number-1)*25
    if start_post == 0 then start_post = 1 end #skip the featured post
    end_post = start_post + 24
    return posts[start_post..end_post]
  end
end