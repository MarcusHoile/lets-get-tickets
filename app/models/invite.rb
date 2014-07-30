class Invite < ActiveRecord::Base

  belongs_to :event
  belongs_to :guest, :class_name => "User", foreign_key: "user_id"

end
