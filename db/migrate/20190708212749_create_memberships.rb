class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :mamberships do |t|
      t.integer :user_id
      t.integer :forum_id
    end
  end
end
