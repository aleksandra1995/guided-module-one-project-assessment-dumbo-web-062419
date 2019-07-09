class CreateForums < ActiveRecord::Migration[5.2]
  def change
    create_table :forums do |t|
      t.integer :book_id
      t.string :forum_title
      t.string :content
    end
  end
end
 