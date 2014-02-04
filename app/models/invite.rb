class Invite < ActiveRecord::Base
  # belongs_to :owner, :class_name => "User"
  # belongs_to :guest, :class_name => "User"
  belongs_to :event
  belongs_to :user

  after_initialize :init

  def init
  	self.attending = "Not Responded"
  end
end
