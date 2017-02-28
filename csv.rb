require "csv"

class Database

	# Add a row to the database.
	# 
	# table - Table name String
	# row   - String row to add.
	def append(table, row)
		file_name = "./data/#{file_name}.csv"

		open(csv_file, 'a') do |f|
			f.puts row
		end
	end

	# def buildUserIDHash
	# 	return buildHash(@users_file, "userID")
	# end

	# def buildUserNameHash
	# 	return buildHash(@users_file, "username")
	# end

	# Get all rows from a table.
	# 
	# table         - Table name String
	# key_result_by - Primary key to identify each row by.
	# 
	# Returns a Hash containing each row's information.
	def all(table, key_result_by)
		file_name = "./data/#{file_name}.csv"

		the_hash = {}
		CSV.foreach(file_name, {headers: true, return_headers: false}) do |row|
			key = row[key_result_by];
			the_hash[key] = row.to_hash
		end
		return the_hash
	end

	def addUserEntry(user_id, user_info)		
		#userID,username,email,password
		entry_string = "#{user_id},\"#{user_info["username"]}\","
		entry_string += "\"#{user_info["email"]}\",\"#{user_info["password"]}\""
		append("users", entry_string)
	end

	def addPostEntry(post_id, post_info)
		#timestamp,userID,score,likedIDs,dislikeIDs,title,content
		entry_string = "#{post_id},\"#{post_info["userID"]}\","
		entry_string += "\"#{post_info["score"]}\",\"#{post_info["likedIDs"]}\""
		entry_string += "\"#{post_info["dislikeIDs"]}\",\"#{post_info["title"]}\""
		entry_string += "\"#{post_info["content"]}\""
		append("posts", entry_string)
	end

	def editPostEntry(post_id, post_info)
		#Can we do this without rewriting the entire csv every time?
	end

	def editUserEntry(user_id, user_info)

	end

end