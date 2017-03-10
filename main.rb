require 'rubygems'
require 'bundler'
Bundler.require(:default)

require_relative './services/database.rb'
DATABASE = Database.new("upvoter_development")

require_relative './models/post.rb'
require_relative './models/user.rb'
require_relative './services/score.rb'

enable :sessions

SORTDEFAULT = "popular"

def current_user
	if session[:user]
		@current_user ||= User.newFromDB(session[:user])
	end
end

get("/") do
	@cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	@sort     = params["sort"].nil? ? SORTDEFAULT : params["sort"]

  @page_of_posts = Post.page(@sort, @cur_page)

	erb :index
end

get("/newPost") do
	erb :newPost
end

post("/newPost") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	sort     = params["sort"].nil? ? SORTDEFAULT : params["sort"]

	post_info = {"userid" => current_user.userid, "title" => params["title"], "content" => params["content"]}
	post = Post.newFromInfo(post_info)
	post.save
	Post.likeClicked(post.postid, current_user)

	redirect("/?pg="+cur_page.to_s+"&sort="+sort)
end

get("/login") do
	@cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	@sort   = params["sort"].nil? ? SORTDEFAULT : params["sort"]

	@err = session[:login] == "error"
	session.clear

	erb :login
end

post("/login") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	sort   = params["sort"].nil? ? SORTDEFAULT : params["sort"]

	if User.loginValid?(params["username"],params["password"])
		session[:login] = "true"
		session[:user] = params["username"]
		redirect("/?pg="+cur_page.to_s+"&sort="+sort)
	else
		session[:login] = "error"
		redirect("/login?pg="+cur_page+"&sort="+sort)
	end
end

get("/logout") do
	session.clear
	redirect("/")
end

post("/likeclicked") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	sort   = params["sort"].nil? ? SORTDEFAULT : params["sort"]

	if current_user
		Post.likeClicked(params["pid"],params["user"])
		redirect("/?pg="+cur_page.to_s+"&sort="+sort)
	else
		redirect("/login")
	end
end

get("/newUser") do
	@cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	@sort   = params["sort"].nil? ? SORTDEFAULT : params["sort"]

	erb :newUser
end

post("/newUser") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	sort   = params["sort"].nil? ? SORTDEFAULT : params["sort"]

	user_info = {"username" => params["username"], "email" => params["email"], "password" => params["password"]}
	user = User.newFromInfo(user_info)
	user.register

	redirect("/?pg="+cur_page.to_s+"&sort="+sort)
end

post("/newPassword") do
	cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	sort   = params["sort"].nil? ? SORTDEFAULT : params["sort"]

	current_user.newPassword(params["password"])

	redirect("/?pg="+cur_page.to_s+"&sort="+sort)
end


