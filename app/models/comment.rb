class Comment < ActiveRecord::Base
  validates_presence_of :body, :author

  after_save :update_last_commented_on

  belongs_to :post


  private

  def update_last_commented_on
    # last_commented_on is the name of the column
    self.post.last_commented_on = self.created_at
  end
end