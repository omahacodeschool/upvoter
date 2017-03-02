require 'sinatra'

get("/"){
	erb :index
}

get("/newPost"){
	erb :newPost
}