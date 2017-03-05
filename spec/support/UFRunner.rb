require 'faker'
require_relative './upvotefaker.rb'
require_relative '../../services/database.rb'

DATABASE = Database.new("../data")
UF = UpvoteFaker.new

UF.makeTables()

