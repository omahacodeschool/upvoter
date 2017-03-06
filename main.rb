require_relative './services/database.rb'
DATABASE = Database.new

require_relative './models/post.rb'
require_relative './models/user.rb'
require_relative './services/score.rb'
require 'sinatra'
require 'pry'

enable :sessions

get("/") {
	@cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	@search   = params["search"].nil? ? "newest" : params["search"]
	@user     = session[:user]
		
    @page_of_posts = Post.page(@search, @cur_page)
	erb :index
}

get("/newPost") {
	erb :newPost
}

get("/login") {
	@err = session[:login] == "error"
	session.clear
	erb :login
}

post("/login") {
	if User.loginValid?(params["username"],params["password"])
		session[:login] = "true"
		session[:user] = params["username"]
		# redirect("/?search=" + @search + "&pg=" + @cur_page)
		redirect("/")
	else
		session[:login] = "error"
		redirect("/login")
	end
}

post("/logout") {
	session.clear
	redirect("/")
}

post("/likeclicked") {
	Post.likeClicked(params["pid"],params["user"])
}

post("/newPost") {

}
