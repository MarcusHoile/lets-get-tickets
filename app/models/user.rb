class User < ActiveRecord::Base
	has_many :events, through: :invites
	has_many :pending_invites,
         :through => :invites,
         :source => :guest,
         :conditions => "confirmed = 0"

end
