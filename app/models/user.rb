class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 	
	has_many :invites
	has_many :events, through: :invites
	# has_many :pending_invites,
 #         :through => :invites,
 #         :source => :guest,
 #         :conditions => "attending = 0"

end
