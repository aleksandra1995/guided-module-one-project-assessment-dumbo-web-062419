class CreateForumsBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :forums_books do |t|
      t.integer :book_id
      t.integer :forum_id
    end
  end
end
