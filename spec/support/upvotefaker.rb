class UpvoteFaker
	MINUTE = 60
	HOUR = 60*MINUTE
	DAY = 24*HOUR
	WEEK = 7*DAY
	MONTH = 4*WEEK

	def fakeUsers(count)
		count.times do
			fakeUser()
		end
	end

	def fakeUser()
		userID = tsFrom(0,365,"d")
		username = Faker::Internet.user_name
		email = Faker::Internet.email
		password = Faker::Internet.password(4, 10)
		row = "#{userID},#{username},#{email},#{password}"
		DATABASE.append("users",row)
	end

	def fakeUserWithCredentials(username,password)
		userID = tsFrom(0,365,"d")
		username = username
		email = Faker::Internet.email
		password = password
		row = "#{userID},#{username},#{email},#{password}"
		DATABASE.append("users",row)
	end

	def fakePost(postID = tsFrom(0,365,"d"))
		userID = randomUIDFromUsers()
		title = Faker::Company.catch_phrase
		content = Faker::Internet.url
		row = "#{postID},#{userID},#{title},#{content}"
		DATABASE.append("posts",row)
	end

	def fakePosts(count)
		count.times do
			fakePost()
		end
	end

	def fakeLike(postID,num_likes)
		num_users = DATABASE.all("users","userID").keys.length
		num_likes = num_likes > num_users ? num_users : num_likes
		num_likes.times do
			likeID = tsFrom(0,365,"d")
			userID = randomUIDFromUsers()
			row = "#{likeID},#{postID},#{userID}"
			DATABASE.append("likes",row)
		end
	end

	def fakeLikes(max_likes)
		pids = DATABASE.all("posts","postID").keys
		for pid in pids
			fakeLike(pid,rand(0..max_likes))
		end
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

	def tsFrom(start_count,end_count,unit)
		time1 = Time.now.to_f - start_count*timeMulti(unit)
		time2 = Time.now.to_f - end_count*timeMulti(unit)
		rn = (time1-time2).abs * rand(0.1..1.0)
		return ([time1,time2].min+rn)
	end

	private

	def timeMulti(unit)
		case unit.downcase
		when "m"
			return MINUTE
		when "h"
			return HOUR
		when "d"
			return DAY
		when "w"
			return WEEK
		else
			time = 0
		end
	end

	def randomUIDFromUsers()
		uids = DATABASE.all("users","userID").keys
		i = rand(0..uids.length-1)
		return uids[i]
	end

end