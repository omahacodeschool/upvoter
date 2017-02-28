require "csv"

class UpvoteCSVManipulator
	def initialize
		@users_file = "./data/users.csv"
		@posts_file = "./data/posts.csv"
	end

	def appendToCSVFile(csv_file, csv_line)
		open(csv_file, 'a') do |f|
			f.puts csv_line
		end
	end

	def buildPostsHash
		return buildHash(@posts_file,"timestamp");
	end

	def buildUserIDHash
		return buildHash(@users_file,"userID")
	end

	def buildUserNameHash
		return buildHash(@users_file,"username")
	end

	def buildHash(file_name, key_result_by)
		the_hash = {}
		CSV.foreach(file_name, {headers: true, return_headers: false}) do |row|
			key = row[key_result_by];
			posts_hash[key] = row.to_hash
		end
		return the_hash
	end

	def addUserEntry(user_id, user_info)		
		#userID,username,email,password
		entry_string = "#{user_id},\"#{user_info["username"]}\","
		entry_string += "\"#{user_info["email"]}\",\"#{user_info["password"]}\""
		appendToCSVFile(@users_file, entry_string)
	end

	def addPostEntry(post_id, post_info)
		#timestamp,userID,score,likedIDs,dislikeIDs,title,content
		entry_string = "#{post_id},\"#{post_info["userID"]}\","
		entry_string += "\"#{post_info["score"]}\",\"#{post_info["likedIDs"]}\""
		entry_string += "\"#{post_info["dislikeIDs"]}\",\"#{post_info["title"]}\""
		entry_string += "\"#{post_info["content"]}\""
		appendToCSVFile(@posts_file, entry_string)
	end

	def editPostEntry(post_id, post_info)
		#Can we do this without rewriting the entire csv every time?
	end

	def editUserEntry(user_id, user_info)

	end

end