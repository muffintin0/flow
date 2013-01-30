class MicropostsController < ApplicationController
	
	before_filter :authenticate_user!

	before_filter :destroy_privilege, only: :destroy

	def create
		@micropost=Micropost.new(params[:micropost])
		@micropost.user= current_user

		image_ids=params[:image_ids]

		respond_to do |format|
			if @micropost.save
				if image_ids
					image_ids.each do |image_id|
						MicropostImage.find(image_id).update_attribute(:micropost_id,@micropost.id)
					end
				end
				format.html { redirect_to root_path, notice: 'New micropost published' }
			else
				flash[:error]=@micropost.errors.full_messages.join(', ').html_safe
				format.html { redirect_to root_path }
			end
		end
	end

	def repost
		@micropost=Micropost.find(params[:id])
	end


	def destroy
		#@micropost=Micropost.find(params[:id])
		@micropost.delete
		redirect_to user_path(@micropost.user), notice: 'Post deleted'
	end
	
	private

	def destroy_privilege
		@micropost = Micropost.find(params[:micropost_id])
		redirect_to root_path, error: "Only micropost owner or comment owner can delete comment" unless current_user === @micropost.user or current_user.admin?
	end

end
