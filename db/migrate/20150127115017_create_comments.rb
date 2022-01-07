class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text    :body
      t.string  :author
      t.integer :post_id, index: true

      t.timestamps null: false
    end
  end
end