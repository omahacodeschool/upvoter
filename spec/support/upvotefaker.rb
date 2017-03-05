class UpvoteFaker

	def fakeUser()

	end

	def fakeUsers(count)
		

	end

	def fakeUserWithUserame(username)

	end

	def fakeUserWithCredentials(username,password)

	end

	def fakePost(posterID, likeCount, daysAgo)

	end

	def makeTables()
		makeTable("likes", "likeID,postID,userID")
		makeTable("posts", "postID,userID,title,content")
		makeTable("users", "userID,username,email,password")
	end

	def makeTable(table, headers) 
		file_name = DATABASE.table_path(table)
		open(file_name, 'w') do |f|
			f.puts headers
		end
	end

end