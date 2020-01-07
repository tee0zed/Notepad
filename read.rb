require_relative "memo.rb"
require_relative "task.rb"
require_relative "link.rb"
require_relative "post.rb"
require 'optparse'

options = {}

OptionParser.new do |opt|
  opt.banner = 'Usage: read.rb [options]'

  opt.on('-h', 'Prints help') do
    puts opt
    exit
  end

  opt.on('--type TYPE', 'what type of posts should be shown (defaults: any)') {|o| options[:type] = o}
  opt.on('--id ID', 'shows post by ID') {|o| options[:id] = o}
  opt.on('--limit NUMBER', 'expresses number of posts to be shown') {|o| options[:limit] = o}
end.parse!

result = Post.find(options[:limit], options[:type], options[:id])

if result.is_a? Post
  puts "Post #{result.class.name}, id = #{options[:id]}"
  result.to_strings.each do |line|
    puts line
  end
elsif result.nil?
  nil
else
  print "| id\t| @type\t| @created_at\t\t\t| @text\t\t\t| @url\t\t| @due_date \t"

  result.each do |row|
    puts
    row.each do |element|
      print "| #{element.to_s.delete("\\n\\r")[0..20]}\t"
    end
  end
end