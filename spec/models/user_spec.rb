require "pry"

RSpec.describe(User, ".all") do
  it "creates a hash of all user data" do
  	
    expect(User.all).to include("username" => "quixote")

  end
end

RSpec.describe("User", "format_for_database") do
  it "joins hash into comma separated string" do

  	#Setup
  	sampleUser = User.new("quixote")

  	actual = sampleUser.format_for_database

  	#Exercise/Verify
    expect(actual).to include("quixote")

    #Teardown
    #None required
  end
end


RSpec.describe("New user", "create") do
  it "creates a new user with the given information and adds it to the database" do

  	#Setup
  	userInfoHash = {
  		"username" => "nennington",
  		"email" => "barlsworth@gmail.com",
  		"password" => "iBark"
  	}

  	#Exercise
  	createNewUser = User.create(userInfoHash)
  	nenningtonCat = User.new("nennington")

  	#Verify
    expect(nenningtonCat.info).to include("username" => "nennington", "email" => "barlsworth@gmail.com", "password" => "iBark")

    #Teardown
    table = CSV.table("./data/users.csv")

    table.delete_if do |row|
      row[:username] == 'nennington'
    end

    File.open("./data/users.csv", 'w') do |f|
      f.write(table.to_csv)
    end

  end
end









