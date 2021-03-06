class Post
    attr_reader :postid, :userid, :title, :content, :score
    attr_writer  :postid, :userid, :title, :content, :score

    def num_likes
        puts "MORE SQL! GETTING LIKES FOR THE POST."
        return DATABASE.conn.exec("SELECT * FROM likes WHERE postid='#{@postid}'").to_a.length
    end

    # TODO
        # def popular_score
        # score.popular_score
    # end

    def Post.newFromInfo(info)
        newPost = Post.new
        newPost.postid  = info["postid"].nil? ? Time.now.to_f.to_s : info["postid"]
        newPost.userid  = info["userid"]
        newPost.title   = info["title"]
        newPost.content = info["content"]
        newPost.score = Score.new(@postid, newPost.num_likes)
        return newPost
    end

    def Post.newFromDB(postid)
        puts "\n\n-------------------------Post.newFromDB\n\n"
        @postid = postid
        info = DATABASE.find("posts", "postid", @postid)
        return newFromInfo(info)
    end

    # Checks if user has already liked a post
    # user - User object.
    # returns true if likes has an entry with both the wanted postid and userid
    def likedBy?(user)
        puts "\n\n"
        user.likes.include?(@postid) if user
    end

    # Increments/decrements score of post when user clicks arrow.
    def Post.likeClicked(postid, user)
        puts "\n\n-------------------------Post.likeClicked\n\n"
        uid = DATABASE.find("users", "username", user.username)["userid"]
        thispost = Post.newFromDB(postid)
        if thispost.likedBy?(user)
            thispost.send(:removeLike, uid)
        elsif !uid.nil?
            thispost.send(:addLike, uid)
        end
    end

    # Create a post.
    # 
    # post_info - Hash of post info.
    def save
        entry = {"postid" => @postid, "userid" => @userid, "title" => @title, "content" => @content}
        DATABASE.newEntry("posts", entry)
    end

    # Returns an array of the 25 Posts for the specified page, or nil
    #
    # sort_method - String of sort method for page
    # page_number - Integer page number
    def Post.page(sort_method,page_number)
        if sort_method == "newest"
            sorter = "ORDER BY postid DESC"
        end

        offset = (page_number - 1) * 25

        sql = "SELECT * FROM posts #{sorter} OFFSET #{offset} LIMIT 25"
        DATABASE.conn.exec(sql).map do |row|
            Post.newFromInfo(row)
        end
    end

    # Returns username string associated with Post's userID value.
    def getAuthor
        author = User.newFromDBbyID(userid).username
        return author
    end

    private

    def addLike(uid)
        entry = {"postid" => @postid, "userid" => uid}
        DATABASE.newEntry("likes", entry)
    end

    def removeLike(uid)
        hash = DATABASE.all("likes","likeid")
        lid = nil
        hash.each do |k, v|
            if v["userid"] == uid && v["postid"] == @postid
                lid = k
            end
        end
        DATABASE.delete("likes","likeid", lid)
    end

    # Defines method to sort posts by age.
    # Returns array of postids sorted by newest first.
    def Post.newest()
        array = Post.all.keys.sort
        return array.reverse
    end

    # Defines method to sort posts by total score.
    # Returns array of postids sorted by score, highest first
    def Post.top()
        result = {}
        Post.all.each do |k, v|
            result[k] = Post.newFromInfo(v).num_likes
        end
        result = result.sort_by {|k, v| v}.to_h
        return result.keys.reverse
    end

    # Defines method to sort posts by score adjusted by age.
    def Post.popular()
        result = {}
        Post.all.each do |k, v|
            result[k] = Post.newFromInfo(v).score.popular_value
        end
        result = result.sort_by {|k, v| v}.to_h
        return result.keys.reverse
    end

    def Post.IDsToPosts(postids)
        posts = []
        for id in postids
            posts.push(Post.newFromDB(id))
        end
        return posts
    end

    def Post.pageIDs(sort_method,page_number)
        postids = Post.sort(sort_method)
        start_post = (page_number-1)*25
        end_post = start_post + 24
        return postids[start_post..end_post]
    end

    # Get all posts.
    # 
    # Returns a Hash of all posts.
    def Post.all
        DATABASE.all("posts", "postid");
    end

    # Calls appropriate sort method according to desired display.
    #
    # method - String of desired sort method
    def Post.sort(method)
        if method == "newest"
            return newest()
        elsif method == "top"
            return top()
        else
            return popular()
        end
    end

end