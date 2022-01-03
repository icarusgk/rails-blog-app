class Post
  attr_reader :id, :title, :body, :author, :created_at, :errors

  def initialize(attributes={})
    set_attributes attributes
    @errors = {}
  end

  def set_attributes(attributes)
    @id = attributes['id'] if new_record?
    @title = attributes['title']
    @body = attributes['body']
    @author = attributes['author']
    @created_at ||= attributes['created_at']
  end

  def valid?
    @errors['title'] = "can't be blank" if title.blank?
    @errors['body'] = "can't be blank" if body.blank?
    @errors['author'] = "can't be blank" if author.blank?
    title.present? && body.present? && author.present?
  end

  def new_record?
    id.nil?
  end

  def save
    # Guard clause
    return false unless valid?

    if new_record?
      insert
    else
      update
    end
  end

  def insert
    insert_query = <<-SQL
      INSERT INTO posts (title, body, author, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query,
                       title,
                       body,
                       author,
                       Date.current.to_s
  end

  def update
    update_query = <<-SQL
      UPDATE posts
      SET title      = ?,
          body       = ?,
          author     = ?
      WHERE posts.id = ?
    SQL

    connection.execute update_query,
                       title,
                       body,
                       author,
                       id
  end

  def destroy
    connection.execute "DELETE FROM posts WHERE posts.id = ?", id
  end

  def comments
    comment_hashes = connection.execute "SELECT * FROM comments WHERE comments.post_id = ?", id
    comment_hashes.collect do |comment_hash|
      Comment.new comment_hash
    end
  end

  def create_comment(attributes)
    comment = Comment.new attributes.merge! 'post_id' => id
    comment.save
  end

  def self.all
    post_hashes = connection.execute "SELECT * FROM posts"

    # Return all post hashes as Post's
    post_hashes.collect do |post_hash|
      Post.new(post_hash)
    end
  end

  def self.find(id)
    post_hash = connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", id).first

    # Return the found post has as a post
    Post.new(post_hash)
  end

  private

  def self.connection
    db_connection = SQLite3::Database.new "db/development.sqlite3"
    db_connection.results_as_hash = true
    db_connection
  end

  def connection
    self.class.connection
  end
end