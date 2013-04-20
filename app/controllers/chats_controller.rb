class ChatsController < ApplicationController

	before_filter :authenticate_user!

  def room
  	
  end

  def new_message
	  # Check if the message is private
	  if params[:recipient]!='public'
	  	#if recipient = params[:message].match(/@(.+) (.+)/)
	    # It is private, send it to the recipient's private channel
	    #@channel = "/messages/private/#{recipient.captures.first}"
	    @channels = ["/messages/private/#{params['recipient']}","/messages/private/#{current_user.username}"]
	    @message = { :username => current_user.username, :msg => params[:message], :pub_time=>Time.new.strftime("%Y-%m-%d %H:%M:%S") }

	    # store to the database
	    @recipient = User.find_by_username(params[:recipient])
	    if @recipient
	    	@store_message = Message.new
	    	@store_message.sender_id=current_user.id
	    	@store_message.recipient_id=@recipient.id
	    	@store_message.body= params[:message]
	    	@store_message.save
	    end
	  else
	    # It's public, so send it to the public channel
	    @channels = ["/messages/public"]
	    @message = { :username => current_user.username, :msg => params[:message], :pub_time=>Time.new.strftime("%Y-%m-%d %H:%M:%S")  }
	  end
	end
end
