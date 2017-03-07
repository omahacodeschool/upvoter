require "pry"

RSpec.describe(User, ".all") do
  it "gets all users" do
  	
    expect(User.all).to include("quixote")

  end
end

RSpec.describe(User, '#format_for_database') do
  it "joins user info into comma separated string" do

  	# Setup
    sampleUser = User.new
    sampleUser.userID = 1
    sampleUser.username = "Albert"
    sampleUser.email = "abc@123.com"
    sampleUser.password = "abc123"

  	actual = sampleUser.format_for_database
    expected_str = "1,Albert,abc@123.com,abc123"

  	# Exercise/Verify
    expect(actual).to eq(expected_str)
  end
end


RSpec.describe(User, ".create") do
  it "creates new user and adds it to the database" do
 
  	# Setup
  	userInfoHash = {
  		"username" => "nennington",
  		"email" => "barlsworth@gmail.com",
  		"password" => "iBark"
  	}

  	# Exercise
  	User.create(userInfoHash)
  	table = CSV.table("./data/users.csv")
  	
    # Verify
    matching_row = false
    table.each do |row|
      if row[:username] == 'nennington'
        matching_row = true
      end
    end
    expect(matching_row).to be true

    # Teardown
    # table = CSV.table("./data/users.csv")

    # table.delete_if do |row|
    #   row[:username] == 'nennington'
    # end

    # File.open("./data/users.csv", 'w') do |f|
    #   f.write(table.to_csv)
    # end

  end
end
