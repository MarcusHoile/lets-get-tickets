class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :invites
  has_many :hosted_events, class_name: "Event"
  has_many :event_invitations, through: :invites, source: :event
  has_many :tickets
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user


  def self.from_omniauth(auth)
  	where(auth.slice(:provider, :uid)).first_or_create do |user|
  		user.email = auth.info.email
  		user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name   # assuming the user model has a name
	    user.image = auth.info.image # assuming the user model has an image
	  end
	end

	def self.new_with_session(params, session)
		super.tap do |user|
			if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
				user.email = data["email"] if user.email.blank?
			end
		end
	end

	# attr_accessible :email
	# attr_accessible :name
	# attr_accessible :provider
	# attr_accessible :uid
	# attr_accessible :image
	# attr_accessible :oauth_token

	# def User.find_for_facebook_oauth(auth, signed_in_resource = nil)
	# 	Rails.logger.info "USER INFO #{auth.info}"
	# 	user = User.where(:provider => auth.provider, :uid => auth.uid).first

	# 	if user
	# 		Rails.logger.info "UPDATING #{auth.info.image}"
	# 		user.name = auth.extra.raw_info.name
	# 		user.email = auth.info.email
	# 		user.image = auth.info.image
	# 		user.oauth_token = auth.credentials.token      
	# 		user.save
	# 	else
	# 		user = User.create!(
	# 			provider: auth.provider,
	# 			uid: auth.uid,
	# 			name: auth.extra.raw_info.name,
	# 			email: auth.info.email,
	# 			image: auth.info.image,
	# 			oauth_token: auth.credentials.token
	# 			)
	# 		puts "NEW USER #{user}"
	# 	end
	# 	user
	# end

end
