class Comment < ActiveRecord::Base
  attr_accessible :body

  belongs_to :user
  belongs_to :micropost

  validates :body, presence: true

  default_scope order: "comments.created_at DESC"

end
