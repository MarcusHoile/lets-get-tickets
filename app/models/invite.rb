class Invite < ActiveRecord::Base

  belongs_to :event
  belongs_to :user

  before_create :init

  def init
  	self.attending = "Undecided"
  end
end
