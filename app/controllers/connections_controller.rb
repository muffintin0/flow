class ConnectionsController < ApplicationController
	before_filter :authenticate_user!

  def create
  	current_user.connections.create(following_id:params[:connection][:user_id])
  	@user=User.find(params[:connection][:user_id]) # for create.js.erb
  end

  def destroy
  	@connection=Connection.find(params[:id])
  	if @connection 
  		@user=User.find(@connection.following_id) # for destroy.js.erb
  		@connection.destroy
  	end
  end
end
