require_relative './services/database.rb'
require_relative './models/post.rb'
require_relative './models/user.rb'
require 'sinatra'


get("/"){
	posts = Post.popular
  @featured_post = Post.new(posts[0]).info

  # @posts_except_features_paginated = posts.page(params["page"])
  
	erb :index
}

get("/newPost"){
	erb :newPost
}