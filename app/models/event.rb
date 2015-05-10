# when    datetime 
# what          string   
# description   text     
# where         string   
# deadline       datetime 
# price         integer  
# user_id       integer  
# lat           decimal  
# lng           decimal  
# status        string         default: "open"
# image         string   
# booked        boolean        default: false

class Event < ActiveRecord::Base
	belongs_to :owner, :class_name => "User", foreign_key: "user_id"
	has_many :invites, dependent: :destroy
  has_many :guests, through: :invites, source: :guest
  has_many :tickets

  attr_writer :when_text
  attr_writer :deadline_text

  validate :check_when_text
  validate :check_deadline_text

  before_save :save_when_text
  before_save :save_deadline_text

  serialize :latlng, Hash

  def when_text
  	@when_text || self.when.try(:strftime, "%a %d %b %I:%M %P")
  end

  def save_when_text
  	self.when = Chronic.parse(@when_text) if @when_text.present?
  end

  def check_when_text
  	if @when_text.present? && Chronic.parse(@when_text).nil?
  		errors.add :when_text, "It needs to be valid date format"
  	end
  rescue ArgumentError
  	errors.add :when_text, "is out of range"
  end

  def deadline_text
    @deadline_text || deadline.try(:strftime, "%a %d %b %I:%M %P")
  end

  def save_deadline_text
    self.deadline = Chronic.parse(@deadline_text) if @deadline_text.present?
  end

  def check_deadline_text
    if @deadline_text.present? && Chronic.parse(@deadline_text).nil?
      errors.add :deadline_text, "It needs to be valid date format"
    end
  rescue ArgumentError
    errors.add :deadline_text, "is out of range"
  end

  def owner?(user)
    user == owner
  end

  def no_invites?
    guests.count < 2
  end

  def booked?
    booked
  end

  def confirmed?
    closed? && booked?
  end

  def unconfirmed?
    closed? && !booked?
  end

  def open?
    status == 'open'
  end

  def closed?
    status == 'closed'
  end

  def check_status
    if deadline <= DateTime.now
      update(status: "closed")
    elsif deadline > DateTime.now
      update(status: "open")
    end
  end
end
