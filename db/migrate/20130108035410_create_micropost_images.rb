class CreateMicropostImages < ActiveRecord::Migration
  def change
    create_table :micropost_images do |t|
      t.string :image_url, null:false
      t.string :name
      t.integer :micropost_id

      t.timestamps
    end
    add_index :micropost_images,:micropost_id
  end
end
