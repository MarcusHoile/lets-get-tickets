class UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :update, :destroy]

  def index
    # all users except current user
    @users = User.where("id != ?", @user.id)
    @friends = []
    @not_friends = []
    
    # find friends of user and store in array
    @user.friendships.each do |friendship|
      @friends << friendship.friend
    end
    if @friends.empty?
      # if user has no friends, then all users should be available to add
      @not_friends = @users
    else
      # check against all users which are in friends array and return non-friends
      @users.each do |user|
        if !@friends.include?(user)
          @not_friends << user
        end
      end
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        # welcome email is triggered at this point
        # UserMailer.welcome_email(@user).deliver
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @invite = Invite.find params[:user][:invite_id]
    @rsvp = params[:user][:rsvp]
    respond_to do |format|
      if @cached_guest_user.update(user_params)
        format.js
      elsif @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :oauth_token, :provider, :uid, :oauth_expires_at, :image, :guest_user)
    end
end
