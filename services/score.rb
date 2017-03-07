class Score
	attr_reader :value
	attr_reader :popular_value

	MINUTE = 60
	HOUR = 60*MINUTE
	DAY = 24*HOUR
	WEEK = 7*DAY
	MONTH = 4*WEEK

	def initialize(postid)
		@postid = postid
		@value = num_likes
		@popular_value = popular_score
	end

	def num_likes()
		hash = DATABASE.all("likes","likeid")
		num_likes = 0
		hash.each do |k, v|
			if v["postid"] == @postid
				num_likes += 1
			end
		end
		return num_likes
	end

	def popular_score()
	    postTime = @postid.to_f
	    currently = Time.now.to_f
	    age = currently - postTime
	    return decay(age)
	end

	def decay(age)
		case
		when age < HOUR # Full score when newer than 1 hour
			return num_likes
		when age < 8*HOUR # 95% score when between 1 and 8 hours
			return num_likes*0.95
		when age < DAY # 75% score when less than 1 day
			return num_likes*0.75
		when age < WEEK # 50% score when less than 1 week
			return num_likes*0.5
		when age < MONTH # 25% score when less than 1 month
			return num_likes*0.25
		when age < 12*MONTH # 15% score when less than 1 year
			return num_likes*0.15
		else # 5% score when older than 1 year
			return num_likes*0.05
		end
	end

end