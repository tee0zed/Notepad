require_relative "post.rb"

class Link < Post 

	def initialize 
		super 
		@url = ""
	end 

	def read_from_console 
		puts "Введите адрес ссылки"
		@url = STDIN.gets.chomp 

		puts "Введите описание ссылки"
		@text = STDIN.gets.chomp 
	end

	def to_string 

		time_string = "Создано: #{@time_created.strftime("%c")} \n\r \n\r"

		return [@url, @text, time_string]
	end 
end 