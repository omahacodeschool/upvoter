require 'faker'
require_relative './upvotefaker.rb'
require_relative '../../services/database.rb'

DATABASE = Database.new("../data")
UF = UpvoteFaker.new

UF.makeTables()

puts Time.at(UF.tsFrom(1,5,"m"))
puts Time.at(UF.tsFrom(60,60.017,"m"))

UF.makeTables()
UF.fakeUsers(30)
UF.fakePosts(100)
UF.fakeLikes(20)
