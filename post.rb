class Post 
 
 def self.post_types
 	[Memo, Link, Task]
 end 

 def self.create(type)
 	return post_types[type].new 
 end 
 
 def initialize 
 	@time_created = Time.now 
 	@text = nil 
 end 

 def read_from_console
#todo
 end 


 def to_strings 	
#todo
 end 

 def save 
 	file = File.new(file_path, "w:UTF-8")

 	to_strings.each do |i|
 		file.puts(i)
 	end

 	file.close 
 end 

 def file_path 
 	current_path = File.dirname(__FILE__)

 	file_name = @time_created.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")
 	
 	return current_path + "/" + file_name
 end
end