require_relative './services/database.rb'
require 'sinatra'

get("/"){
	erb :index
}

get("/newPost"){
	erb :newPost
}