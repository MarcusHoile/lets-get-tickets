class EventsController < ApplicationController
  before_filter :current_event, only: [:show, :edit, :update, :destroy]
  before_filter :event_host, only: [:show, :edit, :update, :destroy]
  before_filter :check_event_status, only: [:show]
  # before_action :authenticate_user, only: [:new]
  before_filter :set_view_path, only: [:show]
  helper_method :event_host, :current_event

  include ApplicationHelper


  def index
    @events = Query::User::Events.all(current_user)
  end

  def show
    @date = current_event.when
    # @undecided = current_event.invites.where(rsvp: "Undecided")
    # @declined = current_event.invites.where(rsvp: "Not Going")
    @confirmed = current_event.invites.where(rsvp: "going")
    gon.lat = current_event.lat
    gon.lng = current_event.lng
    @invite = Invite.find_by(user_id: current_user.id, event_id: current_event.id) || current_user.invites.create(rsvp: "Undecided", event_id: current_event.id)
    if event_host == current_user
      @invite.update(rsvp: "going")
    end
    gon.rsvp = @invite.rsvp
    @invites = current_event.invites.where.not(rsvp: "Undecided")
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  def edit
  end


  def create
    @event = current_user.events.new(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render action: 'new'
    end
  end


  def update
    respond_to do |format|
      if current_event.update(event_params)
        # TODO will need an update email notification here
        if event_params.include?("ticket")
          format.js { render partial: "ticket_status"}
        end
        format.html { redirect_to current_event}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: current_event.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    # there is no links to destroy atm
    current_event.destroy
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

  def user_type
    (current_user == event_host) ? "planner" : "guest"
  end

  def set_view_path
    prepend_view_path("#{Rails.root}/app/views/#{user_type}")
  end

  def current_event
    @event ||= Event.find(params[:id])
  end

  def event_host
    current_event.owner
  end

  def check_event_status
    current_event.check_status
  end

  def event_params
    params.require(:event).permit(:when_text, :what, :description, :deadline_text, :price, :where, :lat, :lng, :ticket)
  end
end
