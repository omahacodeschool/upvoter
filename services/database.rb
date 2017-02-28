require "csv"

class Database

	# Add a row to the database.
	# 
	# table - Table name String
	# row   - String row to add.
	def append(table, row)
		file_name = "./data/#{table}.csv"

		# TODO Auto-generate ID as first col.

		open(file_name 'a') do |f|
			f.puts row
		end
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

	# TODO
	def delete(table, key_name, key_value)
		the_hash = all(table, key_name)
		the_hash.delete(key_value)
		writeAll(table, the_hash)
	end

	# TODO
	def edit(table, key_name, key_value, new_row)
		delete(table,key_name,key_value)
		append(table, new_row)	
	end

	def writeAll(table, hash) 
		emptyTable(table)
		for row in hash
			append(table,hash[row])
		end
	end

	def emptyTable(table)
		file_name = "./data/#{table}.csv"
		headers = CSV.read(file_name,headers: true).headers.join(",")
		open(file_name 'w') do |f|
			f.puts headers
		end
	end

end