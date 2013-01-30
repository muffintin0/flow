class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null:false
      t.integer :user_id, null:false
      t.integer :micropost_id, null:false

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :micropost_id
  end
end
