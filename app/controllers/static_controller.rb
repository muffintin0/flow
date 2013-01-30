class StaticController < ApplicationController

	def home
		if user_signed_in?
    	@microposts = current_user.feeds(limit:PAGE_LIMIT) #grab all microposts
    	@offset = PAGE_LIMIT+1 #for the more button
    	if current_user.feeds(limit:FEEDS_LIMIT).count< @offset
      	@offset = -1 # no more feeds are shown
    	end 
  		render "home_member"
		else 
  		render "home_guest" 
		end
	end

end