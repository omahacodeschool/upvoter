require 'pry'

require 'faker'
require_relative './upvotefaker.rb'
require_relative '../../services/database.rb'

DATABASE = Database.new("upvoter_development")
UF = UpvoteFaker.new

DATABASE.conn.exec("DROP TABLE likes")
DATABASE.conn.exec("DROP TABLE posts")
DATABASE.conn.exec("DROP TABLE users")

DATABASE.conn.exec("CREATE TABLE likes (likeid SERIAL PRIMARY KEY, postid VARCHAR(255), userid VARCHAR(255))")
DATABASE.conn.exec("CREATE TABLE posts (postid VARCHAR(255), userid VARCHAR(255), title VARCHAR(255), content TEXT)")
DATABASE.conn.exec("CREATE TABLE users (userid VARCHAR(255), username VARCHAR(255), email VARCHAR(255), password VARCHAR(255))")

UF.fakeUserWithCredentials("bigmike","littlemike")
UF.fakeUsers(3)
UF.fakePosts(100)
UF.fakeLikes(4)