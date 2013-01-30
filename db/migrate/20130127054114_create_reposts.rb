class CreateReposts < ActiveRecord::Migration
  def change
    create_table :reposts do |t|
      t.integer :original_post_id, null:false
      t.integer :repost_id, null:false

      t.timestamps
    end

    add_index :reposts,[:original_post_id,:created_at]
  end
end
