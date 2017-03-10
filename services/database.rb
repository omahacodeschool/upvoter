require "csv"
require 'pry'
require 'pg'

class Database
	attr_reader :conn

	def initialize(database_path='upvoter_development')
		@conn = PG.connect(dbname: database_path)
	end

	# Writes new entry to database with self-generated ID.
	#
	# table - Table name as string
	# entry - Hash of values to enter
	def newEntry(table, entry)
		@conn.exec("INSERT INTO " + table + insertQuery(entry) + ";")
	end

	# Get all rows based on a key and value.
	# 
	# table         - Table name as string
	# key           - String of the column header to search
	# key_value     - Value of column to return matching entry
	# 
	# Returns an Array the row hashes.
	def find_all(table, key, key_value)
		sql = "SELECT * FROM #{table} WHERE #{key}='#{key_value}';"
		puts "Running this SQL: \n\n"
		puts sql
		puts "\n\n-----------------------------------------------------"
		
		result = @conn.exec(sql).to_a
	end

	# Get a single row based on a key and value.
	# 
	# table         - Table name as string
	# key           - String of the column header to search
	# key_value     - Value of column to return matching entry
	# 
	# Returns a Hash of the row's information, or Nil.
	def find(table, key, key_value)
		sql = "SELECT * FROM #{table} WHERE #{key}='#{key_value}';"
		puts "Running this SQL: \n\n"
		puts sql
		puts "\n\n-----------------------------------------------------"
		
		result = @conn.exec(sql)

		if result.ntuples == 0
			binding.pry
		else
			return result[0]
		end
	end

	# Get all rows from a table.
	# 
	# table         - Table name as string
	# key_result_by - Primary key to identify each row
	# 
	# Returns a Hash containing each row's information
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
	# table     - Table name as string
	# key_name  - Key of entry to delete
	# key_value - Value of key_name to delete
	# 
	# Examples: - delete(users, username, "bruce")
	#           - delete(users, userid, 1234567890.123456)
	def delete(table, key_name, key_value)
		@conn.exec("DELETE FROM " + table + " WHERE " + key_name + "=" + key_value + ";")
	end

	# Edit a row from a table
	# 
	# table     - Table name as string
	# key_name  - Key of entry to edit
	# key_value - New value of key_name
	# idkey     - Key used to idetify entry to edit
	# idval     - Value of idkey to identify entry to edit
	#
	# Example:  - edit(users, password, "chickennugs", username, "eggboi")
	def edit(table, key_name, key_value, idkey, idval)
		@conn.exec("UPDATE " + table + " SET " + key_name + "=" + key_value + " WHERE " + idkey + "=" + idval + ";")

	end

	private

	# Format entry from hash to SQL command string
	def insertQuery(row)
		heads = []
		vals = []
		row.each do |k,v|
			heads.push(k)
			vals.push(v)
		end
		heads = heads.join(", ")
		vals = vals.join("', '")
		return "(" + heads + ") VALUES ('" + vals +"')"
	end

end