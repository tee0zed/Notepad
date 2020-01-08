require 'byebug'
class Post

  def self.post_types
    {'Memo' => Memo, 'Link' => Link, 'Task' => Task}
  end

  def self.create(type)
    return post_types[type].new
  end

  def initialize
    @time_created = Time.now
    @text = nil
  end

  def to_strings
  end

  def save
    file = File.new(file_path, 'w:UTF-8')

    to_strings.each do |i|
      file.puts(i)
    end

    file.close
  end

  def file_path
    current_path = File.dirname(__FILE__)

    file_name = @time_created.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")

    return current_path + '/' + file_name
  end

  def save_to_db
    db = SQLite3::Database.open('./Notepad.db')

    db.execute(
        'INSERT INTO Posts (' +
            db_to_hash.keys.join(',') +
            ')' \
           'VALUES (' +
            ("?," * db_to_hash.keys.size).chomp(',') +
            ')',
        db_to_hash.values
    )
    db.close
  end

  def self.find(id)
    db = SQLite3::Database.open('./Notepad.db')

    db.results_as_hash = true

    result = db.execute("SELECT * FROM posts WHERE rowid = ?", id)

    db.close

    if result.empty?
      puts "ID #{id} does not exists."
      return nil
    else

      post = create(result.first["type"])

      post.load_data(result.first)

      return post
    end
  end

  def self.find_all(type, limit)
    db = SQLite3::Database.open('./Notepad.db')
    db.results_as_hash = false

    query = "SELECT rowid, * FROM Posts "

    query += "WHERE type = :type " unless type.nil?
    query += "ORDER by rowid DESC "
    query += "LIMIT :limit " unless limit.nil?

    statement = db.prepare(query)

    statement.bind_param('type', type) unless type.nil?
    statement.bind_param('limit', limit) unless limit.nil?

    result = statement.execute!
    statement.close
    db.close
    result
  end



  def db_to_hash
    {
        'type' => self.class.name,
        'created_at' => @time_created.to_s

    }
  end

  def load_data(data_hash)
    @time_created = Time.parse(data_hash['created_at'])
  end

end

