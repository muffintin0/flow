class AddLastChatTimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_chat_time, :datetime
  end
end
