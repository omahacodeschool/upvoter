require_relative './services/database.rb'
require_relative './models/post.rb'
require_relative './models/user.rb'
require 'sinatra'


get("/"){
	@posts = Post.popular
	erb :index
}

get("/newPost"){
	erb :newPost
}