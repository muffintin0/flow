class MicropostImage < ActiveRecord::Base
  attr_accessible :image_url, :name
  before_create :default_name

  belongs_to :micropost

  def default_name
  	self.name ||= File.basename(image_url, '.*').titleize if image_url
  end
end
