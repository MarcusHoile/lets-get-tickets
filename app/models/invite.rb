class Invite < ActiveRecord::Base
  # belongs_to :owner, :class_name => "User"
  # belongs_to :guest, :class_name => "User"
  belongs_to :event
  belongs_to :user

  before_create :init

  def init
  	self.attending = "Not Responded"
  end
end
