class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]



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
    @user = User.find(params[:user_id])
    @event = Event.find(params[:invite][:event_id])
    @invite = @user.invites.new(invite_params)
    respond_to do |format|
      if @invite.save
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @add_avatar = false
    @event = Event.find(params[:invite][:event_id])
    @owner = @event.owner

    if @invite.rsvp == "Undecided"
      @add_avatar = true
    end
    respond_to do |format|
      if @invite.update(invite_params)
        if @invite.rsvp == 'going'
          @badge = '✓'
        elsif @invite.rsvp == 'not-going'
          @badge = 'x'
        elsif @invite.rsvp == 'maybe'
          @badge = '?'
        end
        format.html { redirect_to @event }
        if invite_params.include?("rsvp")
          format.js
        end
        if invite_params.include?("payment_method")
          format.js { render partial: "update_payment"}
        end
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
    params.require(:invite).permit(:rsvp, :event_id, :payment, :user_id, :reason, :payment_method)
  end
end
