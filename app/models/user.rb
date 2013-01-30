class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  VALID_USER_NAME=/\A[a-zA-Z0-9\-\. ]+\z/
  validates :username, presence: true, length: {minimum: 6}, format: {with: VALID_USER_NAME}


  has_many :microposts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :connections, foreign_key: :follower_id, dependent: :destroy
  has_many :back_connections, foreign_key: :following_id, class_name:'Connection',dependent: :destroy
  has_many :followings, through: :connections, source: :following
  has_many :followers, through: :back_connections, source: :follower
  has_many :incoming_messages, foreign_key: :recipient_id, class_name:'Message', dependent: :destroy
  has_many :outgoing_messages, foreign_key: :sender_id, class_name:'Message', dependent: :destroy

  def feeds(options={offset:0, limit:20})
    following_ids = "select following_id from connections where follower_id = #{self.id}"
    @feeds=Micropost.where("user_id = #{self.id} or user_id in (#{following_ids})").limit(options[:limit]).offset(options[:offset])
  end

  def following?(user)
    self.connections.find_by_following_id(user.id)
  end

  def friends
    self.followings & self.followers
  end

  def to_param
    username
  end

end
