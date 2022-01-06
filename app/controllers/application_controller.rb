class ApplicationController < ActionController::Base
  private
  def connection
    db_connection = SQLite3::Database.new "db/development.sqlite3"
    db_connection.results_as_hash = true
    db_connection
  end
end
