require "csv"

class Database

	# Add a row to the database.
	# 
	# table - Table name String
	# row   - CSV string row to add.
	def append(table, row)
		file_name = "./data/#{table}.csv"

		open(file_name, 'a') do |f|
			f.puts row
		end
	end

	# Writes new entry to database with self-generated ID.
	#
	# table - Table name String
	# row   - CSV string to be modified, then added
	def newEntry(table, row)
		id = Time.now.to_f
		row = id + "," + row
		append(table, row)
	end

	# Get a single row based on a key and value.
	# 
	# table         - Table name String
	# key           - String of the column header to search upon.
	# key_value     - Value of column to return matching entry
	# 
	# Returns a Hash of the row's information, or Nil.
	def find(table, key, key_value)
		file_name = "./data/#{table}.csv"
		CSV.foreach(file_name, {headers: true, return_headers: false}) do |row|
			if row[key] == key_value
				return row.to_hash
			end
		end
		return nil
	end

	# Get all rows from a table.
	# 
	# table         - Table name String
	# key_result_by - Primary key to identify each row by.
	# 
	# Returns a Hash containing each row's information.
	def all(table, key_result_by)
		file_name = "./data/#{table}.csv"
		the_hash = {}
		CSV.foreach(file_name, {headers: true, return_headers: false}) do |row|
			key = row[key_result_by];
			the_hash[key] = row.to_hash
		end
		return the_hash
	end

	# Delete a row from a table
	#
	# table     - Table name String
	# key_name  - Name of key to delete
	# key_value - Value of key_name to delete
	# 
	# Examples: - delete(users, username, "bruce")
	#           - delete(users, userID, 1234567890.123456)
	def delete(table, key_name, key_value)
		the_hash = all(table, key_name)
		the_hash.delete(key_value)
		writeAll(table, the_hash)
	end

	# Edit a row from a table
	# 
	# table     - Table name string
	# key_name  - Name of key to edit
	# key_value - Value of key_name to edit
	# new_row   - csv string containing data for new row
	def edit(table, key_name, key_value, new_row)
		delete(table,key_name,key_value)
		append(table, new_row)	
	end

	# Write all values from a hash of table rows into a table
	#
	# table - Table name string
	# hash  - Hash wth all the rows
	def writeAll(table, hash) 
		emptyTable(table)
		hash.each do |k,v|
			append(table,v.values.join(","))
		end
	end

	# Empty all the values from a table leaving the headers
	#
	# table - Table name string
	def emptyTable(table)
		file_name = "./data/#{table}.csv"
		headers = CSV.read(file_name,headers: true).headers.join(",")
		open(file_name, 'w') do |f|
			f.puts headers
		end
	end

end