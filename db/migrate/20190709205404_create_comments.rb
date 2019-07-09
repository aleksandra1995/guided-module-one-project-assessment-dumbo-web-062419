class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :forum_id
      t.string :contributions
    end
  end
end
