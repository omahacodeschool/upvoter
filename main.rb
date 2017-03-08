require 'pry'

require 'pg'

require_relative './services/database.rb'
DATABASE = Database.new("upvoter_test")

require_relative './models/post.rb'
require_relative './models/user.rb'
require_relative './services/score.rb'
require 'sinatra'

enable :sessions

get("/") do
	@cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	@search   = params["search"].nil? ? "newest" : params["search"]
	@user     = session[:user]
		
    @page_of_posts = Post.page(@search, @cur_page)
	erb :index
end

get("/newPost") do
	erb :newPost
end

post("/newPost") do

end

get("/login") do
	@err = session[:login] == "error"
	session.clear
	erb :login
end

post("/login") do
	if User.loginValid?(params["username"],params["password"])
		session[:login] = "true"
		session[:user] = params["username"]
		# redirect("/?search=" + @search + "&pg=" + @cur_page)
		redirect("/")
	else
		session[:login] = "error"
		redirect("/login")
	end
end

get("/logout") do
	session.clear
	redirect("/")
end

post("/likeclicked") do
	Post.likeClicked(params["pid"],params["user"])
	redirect("/\#")
end


