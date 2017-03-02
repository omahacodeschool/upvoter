class Score
	DATABASE = Database.new
	MINUTE = 60
	HOUR = 60*MINUTE
	DAY = 24*HOUR
	WEEK = 7*DAY
	MONTH = 4*WEEK

	def initialize(postID)
		@postID = postID
	end

	def score()
		hash = DATABASE.all("likes","likeID")
		score = 0
		hash.each do |k, v|
			if v["postID"] == @postID
				score += 1
			end
		end
		return score
	end

	def popular_score()
	    postTime = @info["postID"].to_f
	    currently = Time.now.to_f
	    age = currently - postTime
	    decay(age)

	end

	def decay(age)
		case
		when age < HOUR # Full score when newer than 1 hour
			return score
		when age < 8*HOUR # 95% score when between 1 and 8 hours
			return score*0.95
		when age < DAY # 75% score when less than 1 day
			return score*0.75
		when age < WEEK # 50% score when less than 1 week
			return score*0.5
		when age < MONTH # 25% score when less than 1 month
			return score*0.25
		when age < 12*MONTH # 15% score when less than 1 year
			return score*0.15
		else # 5% score when older than 1 year
			return score*0.05
		end
	end

end