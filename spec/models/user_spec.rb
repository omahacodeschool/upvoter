# require "pry"

# RSpec.describe(User, ".all") do
#   it "gets all users" do
  	
#     expect(User.all).to include("quixote")

#   end
# end

# RSpec.describe(User, '#format_for_database') do
#   it "joins hash into comma separated string" do

#     # TODO - Broken but an example of how the test should look in isolation.
#   	# Setup
#   	# sampleUser = User.new("quixote")
#     sampleUser = User.new
#     sampleUser.set_info = {
#       "username" => fjewiofjew,
#       "email"    => fjewiofwe
#     }


#   	actual = sampleUser.format_for_database
#     expected_str = "1488301918.870645,quixote,sirspaniard@knight.org,fkinwindmills"

#   	# Exercise/Verify
#     expect(actual).to eq(expected_str)
#   end
# end


# RSpec.describe(User, ".create") do
#   it "creates new user and adds it to the database" do
#     # TODO - Broken but an example of how the test should look in isolation.

#   	# Setup
#     table = CSV.table("./data/users.csv")

#   	userInfoHash = {
#   		"username" => "nennington",
#   		"email" => "barlsworth@gmail.com",
#   		"password" => "iBark"
#   	}

#   	# Exercise
#   	User.create(userInfoHash)
#   	# nenningtonCat = User.new("nennington")

#     # Verify
#     matching_row = false
#     table.find_by do |row|
#       if row[:username] == 'nennington'
#         matching_row = true
#       end
#     end

#     expect(matching_row).to be_true

#     # Teardown
#     table = CSV.table("./data/users.csv")

#     table.delete_if do |row|
#       row[:username] == 'nennington'
#     end

#     File.open("./data/users.csv", 'w') do |f|
#       f.write(table.to_csv)
#     end

#   end
# end
