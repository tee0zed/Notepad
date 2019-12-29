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

  def db_to_hash
    {
        'type' => self.class.name,
        'created_at' => @time_created.to_s

    }
  end
end