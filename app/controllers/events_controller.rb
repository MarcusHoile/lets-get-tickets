class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    # it is the index of invites for the current user
    # you can only see events that you host or have been invited to
    @user = current_user
    @invites = Invite.where(user_id: @user.id)
    @events = Event.all   #where(user_id: @user.id).order("on_sale DESC")
  end

  # GET /events/1
  # GET /events/1.json
  def show
    # display event details
    # event owner has different view, can edit and add friends
    @user = @event.owner
    @guests = @event.users
    @invites = @event.invites
    @date = @event.when
    # find the invite for the current user, for each event
    # there is only one invite per person per event
    # @invite isn used to display the rsvp buttons
    @invite = @event.invites.where(user_id: current_user.id).first
    @undecided = @event.invites.where(attending: "Undecided")
    @confirmed = @event.invites.where(attending: "Going")
    # @confirmed =  @confirmed.count + 1


    # delete the invite id once rsvpd
    

  end

  # GET /events/new
  def new
    @event = Event.new
    @user = current_user
    # need to lookup friendships to determine appropriate view
    # if user has no friends they are prompted to add friends before creating event
    # if user has no events but has friends, they can create event
    # else they see all events they are included in
    @friendships = current_user.friendships
  end

  # GET /events/1/edit
  def edit
    # need the same data as new above
    @event = Event.find(params[:id])
    @user = @event.owner
    @friendships = current_user.friendships
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @guests = @event.users
    @user = User.find(params[:event][:user_id])
  

    respond_to do |format|
      if @event.save
        # if user invited friends when creating event
        # invite emails are triggered
        @guests.each do |guest|
          UserMailer.invite_email(@user, guest, @event).deliver
        end
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
        # will need an update email notification here
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
    # there is no links to destroy atm
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
