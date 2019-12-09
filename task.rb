require 'date'
require_relative "post.rb"

class Task < Post

	def Initialize 
		super 
		@due_date = Time.now 
	end 

	def read_from_console 
		puts "Новая задача"
		@text = STDIN.gets.chomp
		puts "К какой дате? (в формате ДД.ММ.ГГГГ)"
		input = STDIN.gets.chomp 

		@due_date = Date.parse(input)
	end 


	def to_strings
		time_string = "Создано: #{@time_created.strftime("%c")} \n\r \n\r"

		deadline = "Крайний срок: #{@due_date}"

		return [deadline, @text, time_string]
	end 

end 