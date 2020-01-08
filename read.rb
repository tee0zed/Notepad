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

result = unless options[:id].nil?
      Post.find(options[:id])
         else
      Post.find_all(options[:type], options[:limit])
         end

return nil if result.nil?

if result.is_a? Post
  puts "Запись #{result.class.name}, id = #{options[:id]}"

  result.to_strings.each { |line| puts line }
else
  print '| id                 '
  print '| @type              '
  print '| @created_at        '
  print '| @text              '
  print '| @url               '
  print '| @due_date          '
  print '|'

  result.each do |row|
    puts

    row.each do |element|
      element_text = "| #{element.to_s.delete("\n\r")[0..17]}"
      element_text << ' ' * (21 - element_text.size)
      print element_text
    end

    print '|'
  end

  puts
end
