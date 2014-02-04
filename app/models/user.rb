class User < ActiveRecord::Base
	has_many :invites
	has_many :events, through: :invites
	# has_many :pending_invites,
 #         :through => :invites,
 #         :source => :guest,
 #         :conditions => "attending = 0"

end
