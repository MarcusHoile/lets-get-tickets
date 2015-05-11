class UsersController < ApplicationController

  def index
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
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    @invite = Invite.find params[:user][:invite_id]
    @rsvp = params[:user][:rsvp]
    respond_to do |format|
      if guest_user.update(user_params)
        format.js
      elsif current_user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :oauth_token, :provider, :uid, :oauth_expires_at, :image, :guest_user)
    end
end
