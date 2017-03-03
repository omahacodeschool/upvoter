require_relative './services/database.rb'
require_relative './models/post.rb'
require_relative './models/user.rb'
require_relative './services/score.rb'
require 'sinatra'

cur_page = 1

get("/"){
    @page_of_posts = Post.page("newest",cur_page)
    if @page_of_posts.nil?
    	cur_page -= 1
    	@page_of_posts = Post.page("newest",cur_page)
    end
  	erb :index
}

get("/next_page") {
	cur_page += 1
	redirect "/"	
}

get("/prev_page") {
	cur_page -= 1
	if cur_page < 1 then cur_page = 1 end
	redirect "/"	
}

get("/newPost"){
	erb :newPost
}	