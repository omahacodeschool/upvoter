require "pry"

# Testing the .newEntry Database method.
RSpec.describe(Database, ".newEntry") do
  it "adds new user to database" do
  	
  	# Setup
  	newUser = Database.new
  	newUser.newEntry("users", "nennington,barlsworth@gmail.com,nenners")

  	csv = CSV.read("./data/users.csv")

  	# IS THIS ACTUALLY CHECKING FOR NENNINGTON IN THE ARRAY OF ARRAYS?

    expect(csv.any? { |word| word = "nennington"}).to be true

    # Teardown
    table = CSV.table("./data/users.csv")

    table.delete_if do |row|
      row[:username] == 'nennington'
    end

    File.open("./data/users.csv", 'w') do |f|
      f.write(table.to_csv)
    end

  end
end

# Testing the .find Database method.
RSpec.describe(Database, ".find") do
  it "returns information on a single row in a table" do
  	
  	# Setup
  	findUser = Database.new
  	resultRow = findUser.find("users", "email", "codecowboy@hacker.com")

    expect(resultRow).to include("username" => "GitMaster", "email" => "codecowboy@hacker.com", "password" => "yeehaw")

  end
end

# Testing the .all Database method.
RSpec.describe(Database, ".all") do
  it "returns information on all info in a table" do
  	
  	# Setup
  	allUsers = Database.new

  	# Exercise
  	allHash = allUsers.all("users", "userid")

  	# Verify
    expect(allHash.any? { |name1, name2, password1, password2| name1 = "Administrator", name2 = "bigmike", password1 = "admini", password2 = "littlemike"}).to be true

  end
end

# Testing the .edit Database method.
RSpec.describe(Database, ".edit") do
  it "returns information on all info in a table" do
  	
  	# Setup
  	allUsers = Database.new

  	# Exercise
  	allHash = allUsers.all("users", "userid")

  	# Verify
    expect(allHash.any? { |name1, name2, password1, password2| name1 = "Administrator", name2 = "bigmike", password1 = "admini", password2 = "littlemike"}).to be true

  end
end
