require 'rubygems'
require 'bundler'
Bundler.require(:default)

require_relative './services/database.rb'
DATABASE = Database.new("upvoter_development")

require_relative './models/post.rb'
require_relative './models/user.rb'
require_relative './services/score.rb'

enable :sessions

SEARCHDEFAULT = "popular"

get("/") do
	@cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	@sort   = params["sort"].nil? ? SEARCHDEFAULT : params["sort"]
	@user     = session[:user]
	
    @page_of_posts = Post.page(@sort, @cur_page)
	erb :index
end

get("/newPost") do
	erb :newPost
end

post("/newPost") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	search   = params["sort"].nil? ? SEARCHDEFAULT : params["sort"]

	post_info = {"userid" => params["userid"], "title" => params["title"], "content" => params["content"]}
	Post.create(post_info)
	redirect("/?pg="+cur_page+"&search="+search)
end

get("/login") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	search   = params["sort"].nil? ? SEARCHDEFAULT : params["sort"]

	@err = session[:login] == "error"
	session.clear
	erb :login
end

post("/login") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	search   = params["sort"].nil? ? SEARCHDEFAULT : params["sort"]

	if User.loginValid?(params["username"],params["password"])
		session[:login] = "true"
		session[:user] = params["username"]
		redirect("/?pg="+cur_page+"&search="+search)
	else
		session[:login] = "error"
		redirect("/login?pg="+cur_page+"&search="+search)
	end
end

get("/logout") do
	session.clear
	redirect("/")
end

post("/likeclicked") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	search   = params["sort"].nil? ? SEARCHDEFAULT : params["sort"]

	Post.likeClicked(params["pid"],params["user"])
	redirect("/?pg="+cur_page+"&search="+search)
end

get("/newUser") do
	@cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	@sort   = params["sort"].nil? ? SEARCHDEFAULT : params["sort"]

	erb :newUser
end

post("/newUser") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	search   = params["sort"].nil? ? SEARCHDEFAULT : params["sort"]

	user_info = {"username" => params["username"], "email" => params["email"], "password" => params["password"]}
	User.create(user_info)
	redirect("/?pg="+cur_page+"&search="+search)
end

post("/newPassword") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	search   = params["sort"].nil? ? SEARCHDEFAULT : params["sort"]
	
	username = session[:user]
	user = User.new(username)
	user.newPassword(params["password"])
	redirect("/?pg="+cur_page+"&search="+search)
end


