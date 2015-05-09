class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_status, only: [:show]
  # before_action :authenticate_user, only: [:new]
  before_filter :set_view_path, only: [:show]
  helper_method :host_hasnt_bought_tickets?, :booked?, :paid?, :not_paid?, :confirmed_guest?

  include ApplicationHelper


  def index
    if current_user
      @events = Event.where(owner: current_user) + current_user.event_invitations
    elsif guest_user
      @events = guest_user.event_invitations
    end
    @events.sort_by!(&:on_sale)

    render layout: "application"
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
  end

  # GET /events/new
  def new

    @event = Event.new
    render layout: "application"
  end

  def edit
    @event = Event.find(params[:id])
    @user = @event.owner
  end


  def create
    @event = Event.new(event_params)
    @event.owner = @current_user
    respond_to do |format|
      if @event.save
        redirect_to event_path(@event)
      else
        render action: 'new'
      end
    end
  end


  def update

    respond_to do |format|
      if @event.update(event_params)
        # will need an update email notification here
        if event_params.include?("ticket")
          format.js { render partial: "ticket_status"}
        end
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
    render layout: "application"
  end

  def campaign_form
    @event = Event.new
  end

  private

  def user_type
    (current_user == @event.owner) ? "planner" : "guest"
  end

  def set_view_path
    prepend_view_path("#{Rails.root}/app/views/#{user_type}")
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def check_status
    if @event.status !=  "invite" && @event.on_sale <= DateTime.now
      @event.update(status: "closed")
    elsif @event.on_sale > DateTime.now
      @event.update(status: "open")
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:event_when_text, :what, :description, :on_sale_text, :price, :where, :lat, :lng, :ticket)
  end

  def paid?
    current_or_guest_user.invites.where(event: @event).first.payment
  end

  def not_paid?
    !paid? && @event.booked
  end

  def confirmed_guest?
    paid? && @event.closed?
  end

  def host_hasnt_bought_tickets?
    @event.closed? && @event.unconfirmed?
  end

  def booked?
    @event.closed? && @event.booked?
  end
end
