module ApplicationHelper

	#the devise functions 
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
	
  def unread_messages(user)
    if user.last_chat_time
      @unread_messages = user.incoming_messages.where('created_at > ?',user.last_chat_time)
    else
      @unread_messages = user.incoming_messages
    end
    @unread_messages
  end

end
