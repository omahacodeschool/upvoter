require "csv"

class Database

	# Add a row to the database.
	# 
	# table - Table name String
	# row   - String row to add.
	def append(table, row)
		file_name = "./data/#{file_name}.csv"

		# TODO Auto-generate ID as first col.

		open(csv_file, 'a') do |f|
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
		file_name = "./data/#{file_name}.csv"

		the_hash = {}
		CSV.foreach(file_name, {headers: true, return_headers: false}) do |row|
			key = row[key_result_by];
			the_hash[key] = row.to_hash
		end
		return the_hash
	end

	# TODO
	def delete

	end

	# TODO
	def edit
	end

end