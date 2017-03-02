class Post
  attr_reader :info

  DATABASE = Database.new
  MINUTE = 60
  HOUR = 60*MINUTE
  DAY = 24*HOUR
  WEEK = 7*DAY
  MONTH = 4*WEEK

  def initialize(id)
    @id = id
    @info = DATABASE.find("posts", "postID", @id.to_s)
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
      result[k] = Post.new(k).score
    end
    result = result.sort_by {|k, v| v}.to_h
    return result.keys.reverse
  end

  # Defines method to sort posts by score adjusted by age.
  def Post.popular()
    result = {}
    Post.all.each do |k, v|
      result[k] = Post.new(k).popular_score
    end
    result = result.sort_by {|k, v| v}.to_h
    return result.keys.reverse
  end
  
  # Returns amount of likes for particular post
  def score()
    hash = DATABASE.all("likes","likeID")
    score = 0
    hash.each do |k, v|
      if v["postID"] == @info["postID"]
        score += 1
      end
    end
    return score
  end

  def popular_score()
    postTime = @info["postID"].to_f
    currently = Time.now.to_f
    age = currently - postTime
    case
    when age < HOUR # Full score when newer than 1 hour
      return score
    when age < 8*HOUR # 95% score when between 1 and 8 hours
      return score*0.95
    when age < DAY # 75% score when less than 1 day
      return score*0.75
    when age < WEEK # 50% score when less than 1 week
      return score*0.5
    when age < MONTH # 25% score when less than 1 month
      return score*0.25
    when age < 12*MONTH # 15% score when less than 1 year
      return score*0.15
    else # 5% score when older than 1 year
      return score*0.05
    end
  end

  private
  # OBSOLETE BECAUSE OF 'RESULT.KEYS' ??
  # def Post.buildArr(sorted)
  #   result = []
  #   sorted.each do |k, v|
  #     result.push(v)
  #   end
  #   return result
  # end
end