puts "\nMaking seed user.\n"

user = User.newFromInfo({
  "username" => "sumeetjain",
  "email" => "sumeet@sumeetjain.com",
  "password" => "jijijiji"
})

user.register

puts "Seed user created! #{user.inspect}"