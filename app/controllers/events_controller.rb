class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  before_action :check_status, only: [:show]
  # skip_before_filter :current_user

  include ApplicationHelper





  def index
    # it is the index of invites for the current user
    # you can only see events that you host or have been invited to
    if current_user
      @events = Event.where(owner: @current_user) + @current_user.event_invitations
    elsif guest_user
      @events = @cached_guest_user.event_invitations
    end
    @events.sort_by!(&:on_sale)
  end

  def show
    @owner = @event.owner
    @user = current_or_guest_user
    @date = @event.event_when
    # @undecided = @event.invites.where(rsvp: "Undecided")
    # @declined = @event.invites.where(rsvp: "Not Going")
    @confirmed = @event.invites.where(rsvp: "going")
    gon.lat = @event.lat
    gon.lng = @event.lng
    @invite = Invite.find_by(user_id: @user.id, event_id: @event.id) || @user.invites.create(rsvp: "Undecided", event_id: @event.id)
    if @owner == @user
      @invite.update(rsvp: "going")
    end
    gon.rsvp = @invite.rsvp
    @invites = @event.invites.where.not(rsvp: "Undecided")

    render layout: "events"
  end

  # GET /events/new
  def new

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
    @event.owner = @current_user

    respond_to do |format|
      if @event.save
        # if user invited friends when creating event
        # invite emails are triggered
        # @guests.each do |guest|
        #   UserMailer.invite_email(@owner, guest, @event).deliver
        # end

        format.html { redirect_to event_path(@event)   }

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
        format.html { redirect_to @event}
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
    query = params[:q].to_uri
    auth = {:username => "marcushoile", :password => "bmm6vbmv3bmm"}
    response = HTTParty.get('http://api.eventfinder.com.au/v2/events.json?row=2&q=' + query, :basic_auth => auth)  
    @results = response["events"]

    respond_to do |format|
      format.html { redirect_to new_event }
      format.js 
    end

  end

  def campaign_form
    @event = Event.new
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def check_status
    if @event.status !=  "invite" && @event.on_sale <= DateTime.now
      @event.update(status: "closed")
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:event_when_text, :what, :description, :on_sale_text, :price, :where, :lat, :lng, :ticket)
  end
end
