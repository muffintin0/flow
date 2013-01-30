class MicropostImagesController < ApplicationController

	before_filter :authenticate_user!

  def create
  	@image = MicropostImage.create(params[:micropost_image])
  end

end
