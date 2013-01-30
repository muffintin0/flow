class Micropost < ActiveRecord::Base
  attr_accessible :body, :body_html, :original_post_id

  belongs_to :user

  has_many :micropost_images, dependent: :destroy
  has_many :comments, dependent: :destroy

  # self join relationship for repost
  has_many :reposts, class_name: 'Micropost', foreign_key: :original_post_id
  belongs_to :original_post, class_name: 'Micropost'

  # accepts_nested_attributes_for :micropost_images, allow_destroy: true, 
  #   :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  validates :body, presence: true, length: {maximum: 140} 

  auto_html_for :body do
    html_escape
    sized_image
    youtube(:width => 400, :height => 250)
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  before_validation do |micropost|
    unless micropost.body
      micropost.body='Repost'
    end
  end

  default_scope order: "microposts.created_at DESC"
end
