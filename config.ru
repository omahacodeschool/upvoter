database_needs_to_be_setup = ENV["DB_NEEDS_SETUP"]

if database_needs_to_be_setup == "true"
  require_relative "./setup_database.rb"
end

require './main'

# need_seed_data = ENV["NEED_SEED_DATA"]
# if need_seed_data == "true"
  require_relative "./seed_data.rb"
# end

run Sinatra::Application