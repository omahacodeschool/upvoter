database_needs_to_be_setup = ENV["DB_NEEDS_SETUP"]

if database_needs_to_be_setup == "true"
  require_relative "./setup_database.rb"
end

require './main'
run Sinatra::Application