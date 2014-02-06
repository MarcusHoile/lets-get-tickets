class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @user = current_user
    @invites = Invite.where(user_id: @user.id)
    @events = Event.where(user_id: @user.id)
  end

  # GET /events/1
  # GET /events/1.json
  def show

    @user = @event.owner
    @guests = @event.users
    @invites = @event.invites
    @date = @event.when
    # find the invite for the current user, for each evnet there is only one
    @invite = @event.invites.where(user_id: current_user.id).first
    


    # delete the invite id once rsvpd
    

  end

  # GET /events/new
  def new
    @event = Event.new
    @user = User.find(params[:user_id])
    @friendships = current_user.friendships
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @user = @event.owner
    # @users = User.where("id != ?", @user.id)
    @friendships = current_user.friendships
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @guests = @event.users
    @user = User.find(params[:event][:user_id])
    # set all invites to false as they have not responded yet
    # no_invitation = @event.invites
    # no_invitation.each do ||



    respond_to do |format|
      if @event.save
        # @user.invites.each do |invite|
        #   invite.update(attending: false)
        #   invite.save
        # end
        # @guests.each do |guest|
          # guest.invite.attending = false
          # UserMailer.invite_email(@user, guest, @event).deliver
        # end
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

 

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:when, :what, :description, :on_sale, :price, :where, :user_id, user_ids:[])
    end
end
