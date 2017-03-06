require "pry"
# RSpec.describe(User, ".all") do
#   it "creates a hash of all user data" do

#     expect(User.all).to be_a(Hash)

#   end
# end

# RSpec.describe("User", "format_for_database") do
#   it "joins hash into comma separated string" do

#   	#Setup
#   	sampleUser = User.new("quixote")

#   	actual = sampleUser.format_for_database

#   	#Verify
#   	#None required

#   	#Exercise
#     expect(actual).to include("quixote")

#     #Teardown
#     #None required
#   end
# end

RSpec.describe("New user", "create") do
  it "creates a new user with the given information and adds it to the database" do

  	#Setup
  	newUser = User.new("nennington")
  	userInfoHash = {
  		"userID" => "1488296341.172849",
  		"username" => "nennington",
  		"email" => "barlsworth@gmail.com",
  		"password" => "iBark"
  	}

  	result = newUser.create

  	#Verify
  	#None required

  	#Exercise
    expect(result).to include("quixote")

    #Teardown
    #None required
  end
end











