require_relative "post.rb"

class Memo < Post

	def read_from_console
		
		puts "Новая заметка. Все что будет написано до строчки \"end\" уйдет в запись"
		
		@text = [] 	

		line = nil 
		
		while line != "end" do
			line = STDIN.gets.chomp
			@text << line 
		end 	
	
	@text.pop
	
	end 

	def to_strings
		time_string = "Создано: #{@time_created.strftime("%c")} \n\r \n\r"

		return @text.unshift(time_string)

	end

	def db_to_hash
		return super.merge (
													 {
	 	'text' => @text.join('\n\r')
		}
		)
	end

end 
