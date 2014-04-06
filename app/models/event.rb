class Event < ActiveRecord::Base
	belongs_to :owner, :class_name => "User", foreign_key: "user_id"
	has_many :invites
  has_many :invited_users, through: :invites, source: :event
  has_many :tickets

  attr_writer :event_when_text

  validate :check_event_when_text
  before_save :save_event_when_text


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

end
