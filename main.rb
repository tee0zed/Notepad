require_relative "memo.rb"
require_relative "task.rb"
require_relative "link.rb"
require_relative "post.rb"

puts "Notepad v0.1"
choices = Post.post_types.keys

choice = -1

until choice.between?(0, 3)
	choices.each_with_index do |type, index|
		puts "\t #{index}. #{type}"
	end
choice = STDIN.gets.chomp.to_i 
end 

entry = Post.create(choices[choice])

entry.read_from_console

entry.save_to_db

puts "Сохранено"
