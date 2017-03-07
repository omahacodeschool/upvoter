require "csv"
require 'pry'
require 'pg'

class Database
	attr_reader :conn

	def initialize(database_path='upvoter_development')
		@conn = PG.connect(dbname: database_path)
	end

	def table_path(table)
		table
	end

	# Add a row to the database.
	# 
	# table - Table name String
	# row   - CSV string row to add.
	def append(table, row)
		# open(table_path(table), 'a') do |f|
		# 	f.puts row
		# end
		# @conn.exec
	end
	
	# Writes new entry to database with self-generated ID.
	#
	# table - 
	# entry - 
	def newEntry(table, entry)
		@conn.exec("INSERT INTO " + table + insertQuery(entry) + ";")
	end

	# Get a single row based on a key and value.
	# 
	# table         - Table name String
	# key           - String of the column header to search upon.
	# key_value     - Value of column to return matching entry
	# 
	# Returns a Hash of the row's information, or Nil.
	def find(table, key, key_value)
		result = @conn.exec("SELECT * FROM " + table + " WHERE " + key + "=" + key_value + ";")[0]
		binding.pry
		return result
	end

	# Get all rows from a table.
	# 
	# table         - Table name String
	# key_result_by - Primary key to identify each row by.
	# 
	# Returns a Hash containing each row's information.
	def all(table, key_result_by)
		result = {}
		the_hash = @conn.exec("SELECT * FROM " + table + ";")
		the_hash.each do |row|
			result[row[key_result_by]] = row
		end
		return result
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
		@conn.exec("DELETE FROM " + table + " WHERE " + key_name + "=" + key_value + ";")
	end

	# Edit a row from a table
	# 
	# table     - Table name string
	# key_name  - Name of key to edit
	# key_value - Value of key_name to edit
	# new_row   - csv string containing data for new row
	def edit(table, key_name, key_value, idkey, idval)
		@conn.exec("UPDATE " + table + " SET " + key_name + "=" + key_value + " WHERE " + idkey + "=" + idval + ";")
	end

	private

	# Format stuff for insert to sql
	def insertQuery(row)
		heads = []
		vals = []
		row.each do |k,v|
			heads.push(k)
			vals.push(v)
		end
		heads = heads.join(", ")
		vals = vals.join(", ")
		return "(" + heads + ") VALUES (" + vals +")"
	end

end