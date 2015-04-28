class Event < ActiveRecord::Base
	belongs_to :owner, :class_name => "User", foreign_key: "user_id"
	has_many :invites, dependent: :destroy
  has_many :guests, through: :invites, source: :guest
  has_many :tickets

  attr_writer :event_when_text
  attr_writer :on_sale_text

  validate :check_event_when_text
  validate :check_on_sale_text

  before_save :save_event_when_text
  before_save :save_on_sale_text

  serialize :latlng, Hash

  # def confirmed_guests
  #   invites.where(rsvp: "going")
  #   self.guests.
  #         joins('INNER JOIN "users" ON "invites"."id" = "league_season_matches"."home_team_id"').
  #         where('league_season_matches.league_season_id' => current_league_season.id).
  # end


  def event_when_text
  	@event_when_text || event_when.try(:strftime, "%a %d %b %I:%M %P")
  end

  def save_event_when_text
  	self.event_when = Chronic.parse(@event_when_text) if @event_when_text.present?
  end

  def check_event_when_text
  	if @event_when_text.present? && Chronic.parse(@event_when_text).nil?
  		errors.add :event_when_text, "It needs to be valid date format"
  	end
  rescue ArgumentError
  	errors.add :event_when_text, "is out of range"
  end

  def on_sale_text
    @on_sale_text || on_sale.try(:strftime, "%a %d %b %I:%M %P")
  end

  def save_on_sale_text
    self.on_sale = Chronic.parse(@on_sale_text) if @on_sale_text.present?
  end

  def check_on_sale_text
    if @on_sale_text.present? && Chronic.parse(@on_sale_text).nil?
      errors.add :on_sale_text, "It needs to be valid date format"
    end
  rescue ArgumentError
    errors.add :on_sale_text, "is out of range"
  end

  def owner?(user)
    user == owner
  end

  def no_invites?
    self.guests.count < 2
  end
end
