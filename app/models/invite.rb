# rsvp           string           default: "Undecided"
# user_id        integer
# event_id       integer
# payment        boolean        default: false
# reason         string
# payment_method string

class Invite < ActiveRecord::Base

  belongs_to :event
  belongs_to :guest, :class_name => "User", foreign_key: "user_id"

end
