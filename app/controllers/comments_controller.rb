class CommentsController < ApplicationController

	before_filter :authenticate_user!

	before_filter :destroy_privilege, only: :destroy

	def index
		@micropost = Micropost.find(params[:micropost_id])
		@comments = @micropost.comments
	end	


	def create
		@comment = Comment.new
		@comment.user=current_user
		@comment.micropost_id=params[:micropost_id]
		@comment.body=params[:comment][:body]
		if @comment.save #use ajax here
			flash.now[:notice]="Comment posted"
	    respond_to do |format|
	      format.js { render 'comments/create_success' }
	    end
    else
    	@error_message = @comment.errors.full_messages.join(", ").html_safe
    	respond_to do |format|
	    	format.js { render 'comments/create_failure' }
	    end
    end		
	end

	def destroy
    @comment.destroy #use ajax here
	end	

	private

	def destroy_privilege
		@post = Micropost.find(params[:micropost_id])
		@comment = @post.comments.find(params[:id])
		redirect_to root_path, error: "Only micropost owner or comment owner can delete comment" unless current_user === @post.user or current_user === @comment.user or current_user.admin?
	end
end
