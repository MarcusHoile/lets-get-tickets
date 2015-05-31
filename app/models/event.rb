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
	belongs_to :host, :class_name => "User", foreign_key: "user_id"
	has_many :invites, dependent: :destroy
  has_many :guests, through: :invites, source: :guest
  has_many :tickets
  has_many :media

  serialize :latlng, Hash

  def host?(user)
    user == host
  end

  def no_invites?
    guests.count < 2
  end

  def booked?
    booked
  end

  def not_booked?
    !booked?
  end

  def confirmed?
    closed? && booked?
  end

  def unconfirmed?
    open? || !booked?
  end

  def open?
    status == 'open'
  end

  def closed?
    status == 'closed'
  end

  def booking_reminder?
    closed? && not_booked?
  end

  def unregistered?
    host.guest_user?
  end

  def check_status
    if deadline <= DateTime.now
      update(status: "closed")
    end
  end
end
