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
		userid = tsFrom(0,365,"d")
		username = Faker::Internet.user_name
		email = Faker::Internet.email
		password = Faker::Internet.password(4, 10)
		#row = "#{userid},#{username},#{email},#{password}"
		entry = {"userid" => userid, "username" => username, "email" => email, "password" => password}
		DATABASE.newEntry("users",entry)
	end

	def fakeUserWithCredentials(username,password)
		userid = tsFrom(0,365,"d")
		username = username
		email = Faker::Internet.email
		password = password
		#row = "#{userid},#{username},#{email},#{password}"
		entry = {"userid" => userid, "username" => username, "email" => email, "password" => password}
		DATABASE.newEntry("users",entry)
	end

	def fakePost(postid = tsFrom(0,365,"d"))
		userid = randomUIDFromUsers()
		title = Faker::Company.catch_phrase
		content = Faker::Internet.url
		#row = "#{postid},#{userid},#{title},#{content}"
		entry = {"postid" => postid, "userid" => userid, "title" => title, "content" => content}
		DATABASE.newEntry("posts",entry)
	end

	def fakePosts(count)
		count.times do
			fakePost()
		end
	end

	def fakeLike(postid,num_likes)
		# num_users = DATABASE.all("users","userid").keys.length
		# num_likes = num_likes > num_users ? num_users : num_likes
		num_likes.times do
			likeid = tsFrom(0,365,"d")
			userid = randomUIDFromUsers()
			# row = "#{likeid},#{postid},#{userid}"
			entry = {"postid" => postid, "userid" => userid}
			DATABASE.newEntry("likes",entry)
		end
	end

	def fakeLikes(max_likes)
		pids = DATABASE.all("posts","postid").keys
		for pid in pids
			fakeLike(pid,rand(0..max_likes))
		end
	end

	def tsFrom(start_count,end_count,unit)
		time1 = Time.now.to_f - start_count*timeMulti(unit)
		time2 = Time.now.to_f - end_count*timeMulti(unit)
		rn = (time1-time2).abs * rand(0.1..1.0)
		return ([time1,time2].min+rn)
	end

	# private

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
		uids = DATABASE.conn.exec("SELECT userid FROM users;")
		uids = uids.values
		i = rand(0..uids.length-1)
		return uids[i]
	end

end