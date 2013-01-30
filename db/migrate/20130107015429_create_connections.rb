class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :follower_id, null:false
      t.integer :following_id, null:false

      t.timestamps
    end

    add_index :connections,:follower_id
    add_index :connections,:following_id
  end
end
