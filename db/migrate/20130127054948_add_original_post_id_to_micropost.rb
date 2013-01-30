class AddOriginalPostIdToMicropost < ActiveRecord::Migration
  def self.up
  	add_column :microposts, :original_post_id, :integer
  	add_index :microposts, :original_post_id
  end

  def self.down
  	remove_index :microposts, :original_post_id
  	remove_column :microposts, :original_post_id
  end
end
