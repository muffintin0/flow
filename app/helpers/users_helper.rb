module UsersHelper
	def gravatar_for(user, options={size:50})
    gravatar_id=Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url="http://www.gravatar.com/avatar/#{gravatar_id}.png?size=#{options[:size]}"
    image_tag(gravatar_url, alt: user.username, class:'gravatar img-rounded',
    	title: 'change profile image through gravatar.com')
  end

  def delete_micropost_privilege?(micropost)
    current_user.admin === true || current_user === micropost.user  
  end


	def delete_comment_privilege?(comment)
    current_user.admin? || current_user === comment.micropost.user ||	current_user === comment.user
  end

end
