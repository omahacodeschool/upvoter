require "pry"

# Testing the .newEntry Database method.
RSpec.describe(Database, ".newEntry") do
  it "adds new user to database" do
  	
  	# Setup
  	newUser = Database.new("upvoter_test")

    # Exercise
  	newUser.newEntry("users", {"username" => "nennington", "email" => "barlsworth@gmail.com", "password"  => "nenners"})

    # Verification
    actual = newUser.conn.exec("SELECT username FROM users WHERE username='nennington';")[0]["username"]
    expect(actual).to eq('nennington')

    # Teardown
    newUser.conn.exec("DELETE FROM users WHERE username='nennington';")

  end
end

# Testing the .find Database method.
RSpec.describe(Database, ".find") do
  it "returns information on a single row in a table" do
  	
  	# Setup
  	findUser = Database.new("upvoter_test")
    findUser.conn.exec("INSERT INTO users(username, email, password) VALUES ('nennington', 'barlsworth@gmail.com', 'nenners');")

    # Exercise
  	resultHash = findUser.find("users", "email", "barlsworth@gmail.com")

    # Verify
    expect(resultHash).to include("username" => "nennington", "email" => "barlsworth@gmail.com", "password" => "nenners")

    # Teardown
    findUser.conn.exec("DELETE FROM users WHERE username='nennington';")

  end
end

# # Testing the .all Database method.
# RSpec.describe(Database, ".all") do
#   it "returns information on all info in a table" do
  	
#   	# Setup
#   	allUsers = Database.new("upvoter_test")

#   	# Exercise
#   	allHash = allUsers.all("users", "userid")

#   	# Verify
#     expect(allHash.any? { |name1, name2, password1, password2| name1 = "Administrator", name2 = "bigmike", password1 = "admini", password2 = "littlemike"}).to be true

#   end
# end

# # Testing the .edit Database method.
# RSpec.describe(Database, ".edit") do
#   it "edits a line in the csv file" do
  	
#   	# Setup
#   	changeUser = Database.new("upvoter_test")
#   	newRow = "1488301600.525664,PapaBless,srsFupa@h3h3.fupa,JRHNBR"

#   	# Exercise
#   	changeUser.edit("users", "username", "Sensei", newRow)

#   	# Verify
#   	csv = CSV.read("./data/users.csv")
#     expect(csv.any? { |userid, uname, email, password| userid = "1488301600.525664", uname = "PapaBless", email = "srsFupa@h3h3.fupa", password = "JRHNBR"}).to be true

#     # Teardown
#     table = CSV.table("./data/users.csv")

#     table.delete_if do |row|
#       row[:username] == 'PapaBless'
#     end

#     File.open("./data/users.csv", 'w') do |f|
#       f.write(table.to_csv)
#     end

#     changeUser.append("users", "1488301600.525664,Sensei,fastlearner@ocs.edu,bellybutton")

#   end
# end
