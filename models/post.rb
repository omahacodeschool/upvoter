get "/" do
  @posts = Post.new
  @posts.all

  erb :posts
end




class Post
  def all
    db = Database.new
    dbbuildHash("posts", "timestamp");
  end
end