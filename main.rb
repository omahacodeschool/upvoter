require_relative './services/database.rb'
DATABASE = Database.new

require_relative './models/post.rb'
require_relative './models/user.rb'
require_relative './services/score.rb'
require 'sinatra'

get("/") {
	@cur_page = params["pg"].nil? ? 1 : params["pg"].to_i
	@search   = params["search"].nil? ? "newest" : params["search"]
		
    @page_of_posts = Post.page(@search, @cur_page)
	erb :index
}

get("/newPost") {
	erb :newPost
}

post("/newPost") {

}
