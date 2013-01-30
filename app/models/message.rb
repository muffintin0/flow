class Message < ActiveRecord::Base
  attr_accessible :body, :recipient_id

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  validates :body, presence: true
end
