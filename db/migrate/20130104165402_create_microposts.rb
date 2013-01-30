class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :body,	null:false
      t.text :body_html, null:false
      t.integer :user_id, null:false

      t.timestamps
    end

    add_index :microposts, [:user_id, :created_at]
  end
end
