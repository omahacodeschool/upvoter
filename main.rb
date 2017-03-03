require_relative './services/database.rb'
require_relative './models/post.rb'
require_relative './models/user.rb'
require_relative './services/score.rb'
require 'sinatra'

cur_page = 1
search = "newest"

get("/") {
	cur_page = params["pg"]
	if cur_page.nil? 
		cur_page = 1 
	else
		cur_page = cur_page.to_i
	end

	search = "newest"
	if !params["search"].nil? then search = params["search"] end
		
    @page_of_posts = Post.page(search,cur_page)
  	erb :index
}

get("/next_page") {
	cur_page += 1
	if Post.page(search,cur_page).nil?
    	cur_page -= 1
  	end
	redirect "/?pg="+cur_page.to_s
}

get("/prev_page") {
	cur_page -= 1
	if cur_page < 1 then cur_page = 1 end
	redirect "/?pg="+cur_page.to_s
}

get("/newPost") {
	erb :newPost
}

post("/newPost") {

}
