require 'rubygems'
require 'bundler'
Bundler.require(:default)

require_relative './services/database.rb'

DATABASE = Database.new("upvoter_test")

require_relative './models/post.rb'
require_relative './models/user.rb'
require_relative './services/score.rb'
require_relative './spec/support/upvotefaker.rb'
require_relative './spec/support/tableCleaner.rb'