class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    # it is the index of invites for the current user
    # you can only see events that you host or have been invited to
    @user = current_user
    @invites = Invite.where(user_id: @user.id)
    events_hosting = Event.where(user_id: @user.id)
    events_guest = @user.events
    @events = []
    events_hosting.each do |event|
      @events << event
    end
    events_guest.each do |event|
      @events << event
    end
    @events = @events.sort_by(&:on_sale)
  end

  def show
    # display event details
    # event owner has different view, can edit and add friends
    @owner = @event.owner
    @guests = @event.invited_users
    @invites = @event.invites
    @date = @event.event_when
    # find the invite for the current user, for each event
    # there is only one invite per person per event
    # @invite isn used to display the rsvp buttons
    @invite = @event.invites.where(user_id: current_user.id).first
    @undecided = @event.invites.where(attending: "Undecided")
    @confirmed = @event.invites.where(attending: "Going")
    gon.day = @event.on_sale.day
    gon.hour = @event.on_sale.hour
    # delete the invite id once rsvpd
    

  end

  # GET /events/new
  def new
    
    @user = current_user
    @event = Event.new

  
  end

  def edit
    # need the same data as new above
    @event = Event.find(params[:id])
    @user = @event.owner
  end


  def create
    # event_params[:when] = Chronic.parse(event_params[:when])
    @event = Event.new(event_params)
    @event.owner = current_user
    @guests = @event.invited_users

    respond_to do |format|
      if @event.save
        # if user invited friends when creating event
        # invite emails are triggered
        # @guests.each do |guest|
        #   UserMailer.invite_email(@owner, guest, @event).deliver
        # end
        format.html { redirect_to new_event_invite_path(@event) }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


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


  def destroy
    # there is no links to destroy atm
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def search
    query = params[:q]
    auth = {:username => "marcushoile", :password => "bmm6vbmv3bmm"}
    response = HTTParty.get('http://api.eventfinder.com.au/v2/events.json?row=2&q=' + query, :basic_auth => auth)  
    @results = response["events"]
      # event["images"]["images"].each do |image|
      #   puts image["id"]
      #   image["transforms"]["transforms"].each do |transform|
      #     puts transform["url"]
      #   end
      # end

    respond_to do |format|
      format.html { redirect_to new_event }
      format.js 
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end



  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:event_when_text, :what, :description, :on_sale_text, :price, :where, user_ids:[])
  end
end
