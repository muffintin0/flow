class Repost < ActiveRecord::Base
  attr_accessible :original_post_id, :repost_id

  belongs_to :original_post, class_name: 'Micropost'
  belongs_to :repost, class_name: 'Micropost'

  validates :originial_post_id, presence: true
  validates :repost_id, presence: true
end
