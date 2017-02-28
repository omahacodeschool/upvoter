post "/new_post" do
  params["title"]

  post = Post.new
  post.create(params)
end





class Post
  def create(post_info)
    db = Database.new

    info = "\"#{post_info["userID"]}\","
    info += "\"#{post_info["score"]}\",\"#{post_info["likedIDs"]}\""
    info += "\"#{post_info["dislikeIDs"]}\",\"#{post_info["title"]}\""
    info += "\"#{post_info["content"]}\""

    db.append("posts", info)
  end

  def all
    db = Database.new
    dbbuildHash("posts", "timestamp");
  end
end