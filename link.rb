require_relative "post.rb"
require 'sqlite3'

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

  def db_to_hash
    return super.merge (
                           {
                               'text' => @text,
                               :url => @url
                           }
                       )
  end
  def load_data(data_hash)
    super(data_hash)
    @url = data_hash['url']
  end
end 