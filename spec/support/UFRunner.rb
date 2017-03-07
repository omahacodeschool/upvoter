require 'faker'
require_relative './upvotefaker.rb'
require_relative '../../services/database.rb'

DATABASE = Database.new("../data")
UF = UpvoteFaker.new

UF.makeTables()
UF.fakeUsers(30)
UF.fakePosts(100)
UF.fakeLikes(20)
