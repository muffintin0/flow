class AddLastActivityTimeToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_activity_time, :datetime
  end
end
