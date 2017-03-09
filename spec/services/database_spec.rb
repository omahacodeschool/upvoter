require "pry"

# Testing the .newEntry Database method.
RSpec.describe(Database, ".newEntry") do
  it "adds new entry to database" do
  	
  	# Setup
    tableCleaner
  	newUser = Database.new("upvoter_test")

    # Exercise
  	newUser.newEntry("users", {"username" => "nennington", "email" => "barlsworth@gmail.com", "password"  => "nenners"})

    # Verification
    actual = newUser.conn.exec("SELECT username FROM users WHERE username='nennington';")[0]["username"]
    expect(actual).to eq('nennington')

    # Teardown
    # newUser.conn.exec("DELETE FROM users WHERE username='nennington';")
    tableCleaner

  end
end

# Testing the .find Database method.
RSpec.describe(Database, ".find") do
  it "returns information on a single entry in a table" do
  	
  	# Setup
    tableCleaner
  	findUser = Database.new("upvoter_test")
    findUser.conn.exec("INSERT INTO users(username, email, password) VALUES ('nennington', 'barlsworth@gmail.com', 'nenners');")

    # Exercise
  	resultHash = findUser.find("users", "email", "barlsworth@gmail.com")

    # Verify
    expect(resultHash).to include("username" => "nennington", "email" => "barlsworth@gmail.com", "password" => "nenners")

    # Teardown
    # findUser.conn.exec("DELETE FROM users WHERE username='nennington';")
    tableCleaner

  end
end

# Testing the .all Database method.
RSpec.describe(Database, ".all") do
  it "returns information on all entries in a table" do
  	
  	# Setup
    tableCleaner
    allUsers = Database.new("upvoter_test")
    uf = UpvoteFaker.new
    uf.fakeUsers(30)

  	# Exercise
    allHash = allUsers.all("users", "userid")

  	# Verify
    expect(allHash.length).to eq(30)

    # Teardown
    tableCleaner

  end
end

# Testing the .edit Database method.
RSpec.describe(Database, ".edit") do
  it "edits an entry in sql table" do
  	
  	# Setup
    tableCleaner
  	changePass = Database.new("upvoter_test")
  	changePass.conn.exec("INSERT INTO users(username, email, password) VALUES ('nennington', 'barlsworth@gmail.com', 'nenners');")

  	# Exercise
  	changePass.edit("users", "password", "'snails'", "username", "'nennington'")

  	# Verify
    actual = changePass.conn.exec("SELECT password FROM users WHERE username='nennington';")[0]["password"]
    expect(actual).to eq('snails')

    # Teardown
    # changePass.conn.exec("DELETE FROM users WHERE username='nennington';")
    tableCleaner

  end
end
