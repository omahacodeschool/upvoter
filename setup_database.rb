# To install Postgres and the Ruby Postgres adapter:

# brew install postgresql
# gem install pg -- --with-pg-config=/usr/local/bin/pg_config

# -----------------------------------------------------------------------------

require "pg"

# When you need to set up the database, just UNCOMMENT the below.
# Remember to comment it back out when you're done.

conn = PG.connect( dbname: 'postgres' )
conn.exec("CREATE DATABASE upvoter_development")
conn.exec("CREATE DATABASE upvoter_test")

conn = PG.connect( dbname: 'upvoter_development' )

# And create tables...
conn.exec("CREATE TABLE likes (id SERIAL PRIMARY KEY, post_id VARCHAR(255), user_id VARCHAR(255))")
conn.exec("CREATE TABLE posts (id VARCHAR(255), user_id VARCHAR(255), title VARCHAR(255), content TEXT)")
conn.exec("CREATE TABLE users (id VARCHAR(255), username VARCHAR(255), email VARCHAR(255), password VARCHAR(255))")