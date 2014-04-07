class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:edit, :update] 


  def index
    @invites = Invite.all
    
  end

  def show
  end

  # GET /invites/new
  def new
    @event = Event.find(params[:event_id])    
    @to_invite = current_user.friends - @event.invited_users
    @invite = @event.invites.new
  end

  def edit
  end

  def create
    @event = Event.find(params[:event_id])
    # the invitee ids is an array, need to iterate to get each user id
    params[:invitee_ids].each do |user_id|
      @invite = Invite.create(event_id: @event.id, user_id: user_id.to_i)
      @guest = @invite.user
      # UserMailer.invite_email(current_user, @guest, @event).deliver
    end
    redirect_to @event
  end

  def update
    # invite updates are not in the user flow.
    @event = @invite.event
    respond_to do |format|
      if @invite.update(invite_params)
        format.html { redirect_to @event, notice: 'Invite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # you can not destroy invites
    @invite.destroy
    respond_to do |format|
      format.html { redirect_to invites_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_invite
    @invite = Invite.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invite_params
    params.require(:invite).permit(:attending, :event_id, :user_id)
  end
end
