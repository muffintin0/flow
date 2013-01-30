class UsersController < ApplicationController
  before_filter :authenticate_user!, except:[:check_username,:check_email]

  def index
    @users = User.limit(PAGE_LIMIT)
    @offset = PAGE_LIMIT+1 #for the more button
    if User.count< @offset
      @offset = -1 # no more microposts
    end 
  end

  def followings
    @person = User.find_by_username(params[:id])
    if @person 
      @users = @person.followings.limit(PAGE_LIMIT)
      @offset = PAGE_LIMIT+1 #for the more button
      if @person.followings.count< @offset
        @offset = -1 # no more microposts
      end 
    else
      redirect_to root_path, error:"the user #{params[:id].gsub('_',' ')} does not exist." 
    end
  end

  def followers
    @person = User.find_by_username(params[:id])
    if @person
      @users = @person.followers.limit(PAGE_LIMIT)
      @offset = PAGE_LIMIT+1 #for the more button
      if @person.followers.count< @offset
        @offset = -1 # no more microposts
      end 
    else
      redirect_to root_path, error:"the user #{params[:id].gsub('_',' ')} does not exist." 
    end
  end

  def moreusers
    @users = User.limit(PAGE_LIMIT).offset(params[:offset]) #grab all microposts
    @offset = params[:offset].to_i + PAGE_LIMIT #for the more button
    if User.count< @offset
      @offset = -1 # no more microposts
    end 

    respond_to do |format|
      format.js { render 'users/moreusers' }
    end
  end

  def morefollowers
    @user = User.find_by_username(params[:id])
    @users = @user.followers.limit(PAGE_LIMIT).offset(params[:offset]) #grab all microposts
    @offset = params[:offset].to_i + PAGE_LIMIT #for the more button
    if @user.followers.count< @offset
      @offset = -1 # no more microposts
    end 

    respond_to do |format|
      format.js { render 'users/moreusers' }
    end
  end

  def morefollowings
    @user = User.find_by_username(params[:id])
    @users = @user.followings.limit(PAGE_LIMIT).offset(params[:offset]) #grab all microposts
    @offset = params[:offset].to_i + PAGE_LIMIT #for the more button
    if @user.followings.count< @offset
      @offset = -1 # no more microposts
    end 

    respond_to do |format|
      format.js { render 'users/moreusers' }
    end
  end

  def show
    #named id
    @user = User.find_by_username(params[:id])
    @microposts = @user.microposts.limit(PAGE_LIMIT) #grab all microposts
    @offset = PAGE_LIMIT+1 #for the more button
    if @user.microposts.count< @offset
      @offset = -1 # no more microposts
    end 
  end

  def moreposts
    @user = User.find_by_username(params[:id])
    @offset = params[:offset].to_i + PAGE_LIMIT #for the more button
    if params[:category] =='feeds' #feeds or microposts
      @microposts = @user.feeds(limit:PAGE_LIMIT,offset:params[:offset])
      if FEEDS_LIMIT< @offset
        @offset = -1 # no more microposts
      end
    else
      @microposts = @user.send(params[:category]).limit(PAGE_LIMIT).offset(params[:offset])
      if @user.send(params[:category]).count< @offset
        @offset = -1 # no more microposts
      end 
    end

    respond_to do |format|
      format.js { render 'users/moreposts' }
    end
  end

  def check_username
    @user = User.find_by_username(params[:user][:username])
    if @user
      user_available=false
    else
      user_available=true
    end
    respond_to do |format|
      format.json {  render :json => user_available }
    end
  end

  def check_email
    @user = User.find_by_email(params[:user][:email])
    if @user
      user_available=false
    else
      user_available=true
    end
    respond_to do |format|
      format.json {  render :json => user_available }
    end
  end

  def search
    @usernames=User.where("username like ?","%#{params[:query]}%").select('username').map(&:username)
    #@usernames = User.find(:all,:select=>'username').map(&:username)
    respond_to do |format|
      format.json{
        render :json => @usernames.to_json
      }
    end
  end

  def update_activity
    if user_signed_in?
      current_user.update_attribute(:last_activity_time,Time.new)
    end
  end

  def update_last_chat_time
    if user_signed_in?
      current_user.update_attribute(:last_chat_time,Time.new)
    end
  end
	
end
