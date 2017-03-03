require_relative './services/database.rb'
require_relative './models/post.rb'
require_relative './models/user.rb'
require_relative './services/score.rb'
require 'sinatra'


get("/"){
    @featured = Post.featured("newest")
    @page_of_posts = Post.page("newest",1)
  	erb :index
}

get("/newPost"){
	erb :newPost
}