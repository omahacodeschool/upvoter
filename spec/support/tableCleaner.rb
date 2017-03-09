def tableCleaner
  DATABASE.conn.exec("DROP TABLE likes")
  DATABASE.conn.exec("DROP TABLE posts")
  DATABASE.conn.exec("DROP TABLE users")

  DATABASE.conn.exec("CREATE TABLE likes (likeid SERIAL PRIMARY KEY, postid VARCHAR(255), userid VARCHAR(255))")
  DATABASE.conn.exec("CREATE TABLE posts (postid VARCHAR(255), userid VARCHAR(255), title VARCHAR(255), content TEXT)")
  DATABASE.conn.exec("CREATE TABLE users (userid VARCHAR(255), username VARCHAR(255), email VARCHAR(255), password VARCHAR(255))")
end